-- chunkname: @/tmp/or_skill/lua_compile/Skill_TJHDe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_TJHDe_Normal = {
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
					-2,
					0
				}, 200, "skill1"))
			end)
			exec["@time"]({
				300
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
	_M.__all__.Skill_TJHDe_Proud = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, -0.7, 2), 100, "skill2"))
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						134,
						200
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2.2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2.2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						134,
						200,
						267,
						334,
						400,
						467,
						534,
						600
					}, global.SplitValue(_env, global.CellColLocation(_env, global.GetCell(_env, unit)) == 2 and global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.MidDamage,
						0
					}) or global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor), {
						0.06,
						0.06,
						0.06,
						0.06,
						0.06,
						0.1,
						0.1,
						0.1,
						0.2,
						0.2
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.SpecialNumericEffect(_env, "+death_num", {
					"+Normal",
					"+Normal"
				}, 1)
				local death_num

				if (global.PETS(_env, _env.unit) or global.SUMMONS(_env, _env.unit) and global.MASTER(_env, _env.ACTOR)) and global.FriendMaster(_env) then
					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"DEATH_NUM"
						}
					}, {
						buff
					})
				end

				if ((global.FriendMaster(_env) or nil) and global.SpecialPropGetter(_env, "death_num")(_env, global.FriendMaster(_env))) == this.Num then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "TJHDe"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", global.GetCardCost(_env, card) - this.FinalNum, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_TJHDe_Passive"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Proud_EX = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0.7, 2), 100, "skill2"))
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						134,
						200
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2.2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2.2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						134,
						200,
						267,
						334,
						400,
						467,
						534,
						600
					}, global.SplitValue(_env, global.CellColLocation(_env, global.GetCell(_env, unit)) == 2 and global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.MidDamage,
						0
					}) or global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor), {
						0.06,
						0.06,
						0.06,
						0.06,
						0.06,
						0.1,
						0.1,
						0.1,
						0.2,
						0.2
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.SpecialNumericEffect(_env, "+death_num", {
					"+Normal",
					"+Normal"
				}, 1)
				local death_num

				if (global.PETS(_env, _env.unit) or global.SUMMONS(_env, _env.unit) and global.MASTER(_env, _env.ACTOR)) and global.FriendMaster(_env) then
					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"DEATH_NUM"
						}
					}, {
						buff
					})
				end

				if ((global.FriendMaster(_env) or nil) and global.SpecialPropGetter(_env, "death_num")(_env, global.FriendMaster(_env))) == this.Num then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "TJHDe"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", global.GetCardCost(_env, card) - this.FinalNum, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_TJHDe_Passive"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TJHDe_Unique_Awaken = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2.2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2.2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DISPELLABLE", "SHIELD"), 99)

					local biaoxian = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Dispel",
						tags = {
							"DISPEL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						biaoxian
					})

					local damage

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						134,
						200,
						267,
						334,
						400,
						467,
						534,
						600
					}, global.SplitValue(_env, global.CellColLocation(_env, global.GetCell(_env, unit)) == 2 and global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.MidDamage,
						0
					}) or global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor), {
						0.06,
						0.06,
						0.06,
						0.06,
						0.06,
						0.1,
						0.1,
						0.1,
						0.2,
						0.2
					}))

					if global.CellColLocation(_env, global.GetCell(_env, unit)) ~= 2 then
						local buffeft1 = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.DeUnHurtRateFactor)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 1,
							display = "UnHurtRateDown",
							group = "Skill_TJHDe_Unique_Awaken",
							duration = 2,
							limit = 1,
							tags = {
								"STATUS",
								"DEBUFF",
								"UNHURTRATEDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					end
				end
			end)

			return _env
		end
	}

	return _M
end
