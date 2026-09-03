-- chunkname: @/tmp/or_skill/lua_compile/Skill_Master_XueZhan.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Sk_Master_XueZhan_Attack = {
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
				400
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
	_M.__all__.Sk_Master_XueZhan_Action1 = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, enemyunit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, enemyunit)
					global.ApplyRPEffect(_env, _env.ACTOR, enemyunit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, enemyunit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, enemyunit, {
						0,
						400,
						1200
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end

				local SummonedLengMo = global.Summon(_env, _env.ACTOR, "Summoned_LengMo", this.summonFactor, nil, {
					2,
					5,
					1,
					3,
					4,
					6,
					7,
					8,
					9
				})
				local SummonedHeiHei1 = global.Summon(_env, _env.ACTOR, "Summoned_HeiHei", this.summonFactor, nil, {
					7,
					9,
					4,
					6,
					1,
					3,
					5,
					2,
					8
				})
				local SummonedHeiHei2 = global.Summon(_env, _env.ACTOR, "Summoned_HeiHei", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
			end)
			exec["@time"]({
				3333
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_XueZhan_Action2 = {
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
				global.HealTargetView(_env, {
					_env.ACTOR
				})
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local atk_master = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buff1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, atk_master * this.AtkRateFactor)
				local buff2 = global.Diligent(_env)
				local buff3 = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1
					}, 1)
					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff2,
						buff3
					})
				end

				global.DiligentRound(_env)
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_XueZhan_Action3 = {
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
			_env.units_friends = nil
			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")

				_env.units_friends = global.FriendUnits(_env, global.PETS)
				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.num = #_env.units_friends

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					damage.val = damage.val * (1 + _env.num * this.DmgRateFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						600,
						1500
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end
			end)
			exec["@time"]({
				3633
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
