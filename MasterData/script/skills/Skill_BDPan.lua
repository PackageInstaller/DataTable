-- chunkname: @/tmp/or_skill/lua_compile/Skill_BDPan.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BDPan_Normal = {
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
					-1.7,
					0
				}, 200, "skill1"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyDazeEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyDelRPEffect(_env, _env.ACTOR, _env.TARGET)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Proud = {
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
					-1.7,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "CritRateUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"CRITRATEUP",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})

				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyDazeEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyDelRPEffect(_env, _env.ACTOR, _env.TARGET)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Unique = {
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
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 200, "skill3"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local buffeft1 = global.MaxHpEffect(_env, -defender.maxHp * 0.1)

				global.ApplyBuff(_env, _env.TARGET, {
					timing = 1,
					display = "MaxHpDown",
					duration = 3 + global.EftstrgToRound(_env, attacker),
					tags = {
						"STATUS",
						"DEBUFF",
						"MAXHPDOWN",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})

				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyDazeEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyDelRPEffect(_env, _env.ACTOR, _env.TARGET)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Passive = {
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
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local buffeft1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, global.BuffFactorAtk(_env, _env.ACTOR, this.buffFactorAtkRate, this.buffFactorAtkEx))

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 1,
					display = "AtkUp",
					group = "Skill_BDPan_Passive",
					limit = 3,
					duration = 3 + global.EftstrgToRound(_env, attacker),
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Proud_EX = {
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
					-1.7,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "CritRateUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"CRITRATEUP",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})

				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyDazeEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyDelRPEffect(_env, _env.ACTOR, _env.TARGET)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Unique_EX = {
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
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 200, "skill3"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local buffeft1 = global.MaxHpEffect(_env, -defender.maxHp * 0.1)

				global.ApplyBuff(_env, _env.TARGET, {
					timing = 1,
					display = "MaxHpDown",
					duration = 3 + global.EftstrgToRound(_env, attacker),
					tags = {
						"STATUS",
						"DEBUFF",
						"MAXHPDOWN",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})

				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyDazeEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyDelRPEffect(_env, _env.ACTOR, _env.TARGET)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDPan_Passive_EX = {
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
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local buffeft1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, global.BuffFactorAtk(_env, _env.ACTOR, this.buffFactorAtkRate, this.buffFactorAtkEx))

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 1,
					display = "AtkUp",
					group = "Skill_BDPan_Passive",
					limit = 3,
					duration = 3 + global.EftstrgToRound(_env, attacker),
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}

	return _M
end
