-- chunkname: @/tmp/or_skill/lua_compile/Skill_Master_SenLing.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Sk_Master_SenLing_Attack = {
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
					-1.2,
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
	_M.__all__.Sk_Master_SenLing_Action1 = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local myHp = global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR)

				global.ApplyHPReduce(_env, _env.ACTOR, myHp * this.DmgFactor)

				local units = global.RandomN(_env, 1, global.FriendDiedUnits(_env))

				if units[1] then
					if global.MARKED(_env, "WARRIOR")(_env, units[1]) then
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, 0, {
							2,
							5,
							1,
							3,
							4,
							6,
							7,
							8,
							9
						}, units[1])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Sk_Master_SenLing_Action1")
						end
					else
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, 0, {
							7,
							8,
							9,
							4,
							6,
							5,
							1,
							3,
							2
						}, units[1])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Sk_Master_SenLing_Action1")
						end
					end
				end
			end)
			exec["@time"]({
				3534
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.isRevive == true and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "Sk_Master_SenLing_Action1")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.RpFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_SenLing_Action2 = {
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
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, friendunit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.DispelBuff(_env, friendunit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
				end
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
	_M.__all__.Sk_Master_SenLing_Action3 = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local myHp = global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR)

				global.ApplyHPReduce(_env, _env.ACTOR, myHp * this.DmgFactor)

				for _, friendunit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.SUMMONS - global.MARKED(_env, "DAGUN") - global.HASSTATUS(_env, "CANNOT_BACK_TO_CARD")), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, friendunit)
					local card = global.BackToCard_ResultCheck(_env, friendunit, "card")

					if card then
						global.Kick(_env, friendunit)
					end
				end
			end)
			exec["@time"]({
				3367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_SenLing_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				return
			end)

			return _env
		end
	}

	return _M
end
