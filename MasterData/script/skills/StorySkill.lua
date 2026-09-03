-- chunkname: @/tmp/or_skill/lua_compile/StorySkill.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_JNLong_Unique_Story_Refresh = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedJNLong"))) do
					global.Kick(_env, summonunit)
				end

				local SummonedJNLongA = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongA then
					global.AddStatus(_env, SummonedJNLongA, "SummonedJNLong")
				end

				local SummonedJNLongB = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongB then
					global.AddStatus(_env, SummonedJNLongB, "SummonedJNLong")
				end

				local SummonedJNLongC = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongC then
					global.AddStatus(_env, SummonedJNLongC, "SummonedJNLong")
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Unique_Story_Add = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedJNLong"))) do
					global.Kick(_env, summonunit)
				end

				local SummonedJNLongA = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongA then
					global.AddStatus(_env, SummonedJNLongA, "SummonedJNLong")
				end

				local SummonedJNLongB = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongB then
					global.AddStatus(_env, SummonedJNLongB, "SummonedJNLong")
				end

				local SummonedJNLongC = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				})

				if SummonedJNLongC then
					global.AddStatus(_env, SummonedJNLongC, "SummonedJNLong")
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_CZheng_Passive_Story = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit ~= _env.ACTOR or global.INSTATUS(_env, "SecondTime")(_env, _env.ACTOR) then
					-- block empty
				elseif _env.prevHpPercent >= this.HpRateFactor and _env.curHpPercent < this.HpRateFactor then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp)
					global.AddStatus(_env, _env.ACTOR, "SecondTime")
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LLan_Unique_Story = {
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
			_env.masterextra = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
				end

				local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 1,
					duration = 3,
					display = "UnHurtRateUp",
					tags = {
						"STATUS",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				})

				local buffeft3 = global.Taunt(_env)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 1,
					duration = 3,
					display = "Taunt",
					tags = {
						"STATUS",
						"BUFF",
						"TAUNT",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft3
				})
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_AfterAction_Revive = {
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
				local reviveunit = global.Revive(_env, this.HpRateFactor, this.RageFactor, {
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
			end)

			return _env
		end
	}

	return _M
end
