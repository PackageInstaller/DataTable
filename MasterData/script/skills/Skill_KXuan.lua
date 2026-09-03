-- chunkname: @/tmp/or_skill/lua_compile/Skill_KXuan.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_KXuan_Normal = {
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
					-1.9,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				433
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
	_M.__all__.Skill_KXuan_Proud = {
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
					-1.4,
					0
				}, 100, "skill2"))
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
	_M.__all__.Skill_KXuan_Unique = {
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
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 2)) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					local buffeft4 = global.NumericEffect(_env, "+defrate", {
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
						buffeft4
					})

					local healer = global.LoadUnit(_env, _env.ACTOR, "ALL")
					local buffeft1 = global.HPPeriodRecover(_env, "HOT", healer.atk * this.HotRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 1,
						duration = 2,
						display = "Hot",
						tags = {
							"STATUS",
							"BUFF",
							"HOT",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						duration = 2,
						display = "AtkUp",
						tags = {
							"STATUS",
							"BUFF",
							"ATKUp",
							"DEFUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					}, 1)
					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						duration = 2,
						display = "DefUp",
						tags = {
							"STATUS",
							"BUFF",
							"DEFUp",
							"DEFUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft3
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
		end
	}
	_M.__all__.Skill_KXuan_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) then
					_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.ONESELF(_env, _env.ACTOR) - global.SUMMONS - global.MARKED(_env, "DAGUN") - global.HASSTATUS(_env, "CANNOT_BACK_TO_CARD")), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

					if not _env.units[1] or global.MARKED(_env, "CANNOT_BACK_TO_CARD")(_env, _env.units[1]) then
						-- block empty
					else
						for _, friendunit in global.__iter__(_env.units) do
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, friendunit)
							local card = global.BackToCard_ResultIDCheck(_env, _env.ACTOR, friendunit, "card")

							if card then
								global.Kick(_env, friendunit)

								local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_EXACT(_env, card))

								for _, card in global.__iter__(cards) do
									local buffeft1 = global.MaxHpEffect(_env, -maxHp * (1 - this.MaxHpRateFactor))
									local buffeft2 = global.NumericEffect(_env, "-atkrate", {
										"+Normal",
										"+Normal"
									}, 1 - this.AtkRateFactor)

									global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
										timing = 0,
										duration = 99,
										display = "MaxHpDown",
										tags = {
											"CARDBUFF",
											"Skill_KXuan_Passive",
											"UNDISPELLABLE",
											"UNSTEALABLE"
										}
									}, {
										buffeft1,
										buffeft2
									})
								end
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KXuan_Proud_EX = {
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
					-1.4,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KXuan_Unique_EX = {
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
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 2)) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					local buffeft4 = global.NumericEffect(_env, "+defrate", {
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
						buffeft4
					})

					local healer = global.LoadUnit(_env, _env.ACTOR, "ALL")
					local buffeft1 = global.HPPeriodRecover(_env, "HOT", healer.atk * this.HotRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 1,
						duration = 2,
						display = "Hot",
						tags = {
							"STATUS",
							"BUFF",
							"HOT",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						duration = 2,
						display = "AtkUp",
						tags = {
							"STATUS",
							"BUFF",
							"ATKUp",
							"DEFUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					}, 1)
					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						duration = 2,
						display = "DefUp",
						tags = {
							"STATUS",
							"BUFF",
							"DEFUp",
							"DEFUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft3
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
		end
	}
	_M.__all__.Skill_KXuan_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft4 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft4
				})

				if global.FriendMaster(_env) then
					_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.ONESELF(_env, _env.ACTOR) - global.SUMMONS - global.MARKED(_env, "DAGUN") - global.HASSTATUS(_env, "CANNOT_BACK_TO_CARD")), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

					if not _env.units[1] or global.MARKED(_env, "CANNOT_BACK_TO_CARD")(_env, _env.units[1]) then
						-- block empty
					else
						for _, friendunit in global.__iter__(_env.units) do
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, friendunit)
							local card = global.BackToCard_ResultIDCheck(_env, _env.ACTOR, friendunit, "card")

							if card then
								global.Kick(_env, friendunit)

								local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_EXACT(_env, card))

								for _, card in global.__iter__(cards) do
									local buffeft1 = global.MaxHpEffect(_env, -maxHp * (1 - this.MaxHpRateFactor))
									local buffeft2 = global.NumericEffect(_env, "-atkrate", {
										"+Normal",
										"+Normal"
									}, 1 - this.AtkRateFactor)

									global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
										timing = 0,
										duration = 99,
										display = "MaxHpDown",
										tags = {
											"CARDBUFF",
											"Skill_KXuan_Passive",
											"UNDISPELLABLE",
											"UNSTEALABLE"
										}
									}, {
										buffeft1,
										buffeft2
									})
								end
							end
						end
					end
				end
			end)

			return _env
		end
	}

	return _M
end
