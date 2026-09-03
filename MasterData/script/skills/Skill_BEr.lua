-- chunkname: @/tmp/or_skill/lua_compile/Skill_BEr.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BEr_Normal = {
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
	_M.__all__.Skill_BEr_Proud = {
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
				1100
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
	_M.__all__.Skill_BEr_Unique = {
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

			_env.count = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.MID_CROSS)

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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					_env.count = _env.count + 1
				end

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor * _env.count)
				local buffeft2 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor * _env.count)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_BEr_Unique",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DEFUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end
			end)
			exec["@time"]({
				3433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BEr_Passive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.maxHp = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))

				_env.maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
			end)
			exec["@time"]({
				650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.FriendMaster(_env) or global.INSTATUS(_env, "Skill_BEr_Passive_Death_SecondTime")(_env, global.FriendMaster(_env)) then
					-- block empty
				else
					global.AddStatus(_env, global.FriendMaster(_env), "Skill_BEr_Passive_Death_SecondTime")

					local card = global.BackToCard_ResultIDCheck(_env, _env.ACTOR, _env.ACTOR, "card")

					if card then
						global.Kick(_env, _env.ACTOR)

						local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_EXACT(_env, card))

						for _, card in global.__iter__(cards) do
							local buffeft1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkRateFactor - 1)
							local buffeft2 = global.MaxHpEffect(_env, -_env.maxHp * (1 - this.MaxHpRateFactor))

							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								timing = 0,
								duration = 99,
								tags = {
									"CARDBUFF",
									"Skill_BEr_Passive_Death",
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
			end)

			return _env
		end
	}
	_M.__all__.Skill_BEr_SoulStone_Normal = {
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
	_M.__all__.Skill_BEr_SoulStone_Passive = {
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

				if global.INSTATUS(_env, "Transform2")(_env, _env.ACTOR) then
					global.Transform(_env, _env.ACTOR, 1)
				elseif global.INSTATUS(_env, "Transform1")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "Transform2")
				else
					global.AddStatus(_env, _env.ACTOR, "Transform1")
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

				global.Transform(_env, _env.ACTOR, 1)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BEr_Proud_EX = {
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
				1100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"ABSORPTIONUP",
						"CRITRATEUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				}, 1)

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
	_M.__all__.Skill_BEr_Unique_EX = {
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

			_env.count = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.MID_CROSS)

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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					_env.count = _env.count + 1
				end

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor * _env.count)
				local buffeft2 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor * _env.count)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_BEr_Unique",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DEFUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end
			end)
			exec["@time"]({
				3433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BEr_Passive_Death_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"Skill_BEr_Passive_Death",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
			end)

			return _env
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.maxHp = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))

				_env.maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
			end)
			exec["@time"]({
				650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.FriendMaster(_env) or global.INSTATUS(_env, "Skill_BEr_Passive_Death_SecondTime")(_env, global.FriendMaster(_env)) then
					-- block empty
				else
					global.AddStatus(_env, global.FriendMaster(_env), "Skill_BEr_Passive_Death_SecondTime")

					local card = global.BackToCard_ResultIDCheck(_env, _env.ACTOR, _env.ACTOR, "card")

					if card then
						global.Kick(_env, _env.ACTOR)

						local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_EXACT(_env, card))

						for _, card in global.__iter__(cards) do
							local buffeft1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkRateFactor - 1)
							local buffeft2 = global.MaxHpEffect(_env, -_env.maxHp * (1 - this.MaxHpRateFactor))

							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								timing = 0,
								duration = 99,
								tags = {
									"CARDBUFF",
									"Skill_BEr_Passive_Death",
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
			end)

			return _env
		end
	}
	_M.__all__.Skill_BEr_Passive_Key = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.maxHp = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))

				_env.maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
			end)
			exec["@time"]({
				650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.FriendMaster(_env) or global.INSTATUS(_env, "Skill_BEr_Passive_Death_SecondTime")(_env, global.FriendMaster(_env)) then
					-- block empty
				else
					global.AddStatus(_env, global.FriendMaster(_env), "Skill_BEr_Passive_Death_SecondTime")

					local card = global.BackToCard_ResultIDCheck(_env, _env.ACTOR, _env.ACTOR, "card")

					if card then
						global.Kick(_env, _env.ACTOR)

						local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_EXACT(_env, card))

						for _, card in global.__iter__(cards) do
							local buffeft1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkRateFactor - 1)
							local buffeft2 = global.MaxHpEffect(_env, -_env.maxHp * (1 - this.MaxHpRateFactor))

							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								timing = 0,
								duration = 99,
								tags = {
									"CARDBUFF",
									"Skill_BEr_Passive_Death",
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
			end)

			return _env
		end
	}

	return _M
end
