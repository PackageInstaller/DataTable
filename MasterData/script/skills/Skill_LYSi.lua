-- chunkname: @/tmp/or_skill/lua_compile/Skill_LYSi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LYSi_Normal = {
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
					-1.3,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				730
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
	_M.__all__.Skill_LYSi_Proud = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				930
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
	_M.__all__.Skill_LYSi_Unique = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				local SummonLYSi1 = global.Summon(_env, _env.ACTOR, "SummonedLYSi", this.summonFactor, {
					1,
					0,
					0
				}, {
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

				if SummonLYSi1 then
					global.AddStatus(_env, SummonLYSi1, "SummonLYSi")

					local buffeft1 = global.SpecialNumericEffect(_env, "+Normal_Summon_LYSi", {
						"?Normal"
					}, this.DmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+Extra_Summon_LYSi", {
						"?Normal"
					}, this.ExtraDmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end

				local SummonLYSi2 = global.Summon(_env, _env.ACTOR, "SummonedLYSi", this.summonFactor, {
					1,
					0,
					0
				}, {
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

				if SummonLYSi2 then
					global.AddStatus(_env, SummonLYSi2, "SummonLYSi")

					local buffeft1 = global.SpecialNumericEffect(_env, "+Normal_Summon_LYSi", {
						"?Normal"
					}, this.DmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+Extra_Summon_LYSi", {
						"?Normal"
					}, this.ExtraDmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYSi_Passive = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					if global.MARKED(_env, "ATSheng")(_env, unit) or global.MARKED(_env, "XLai")(_env, unit) or global.MARKED(_env, "ALSi")(_env, unit) then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_LYSi_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
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
	_M.__all__.Skill_LYSi_Proud_EX = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				930
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				940
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					if global.MARKED(_env, "ALSi")(_env, unit) then
						local buffeft1 = global.Immune(_env)
						local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "DEBUFF"))

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 5,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYSi_Unique_EX = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				local SummonLYSi1 = global.Summon(_env, _env.ACTOR, "SummonedLYSi", this.summonFactor, {
					1,
					0,
					0
				}, {
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

				if SummonLYSi1 then
					global.AddStatus(_env, SummonLYSi1, "SummonLYSi")

					local buffeft1 = global.SpecialNumericEffect(_env, "+Normal_Summon_LYSi", {
						"?Normal"
					}, this.DmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+Extra_Summon_LYSi", {
						"?Normal"
					}, this.ExtraDmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end

				local SummonLYSi2 = global.Summon(_env, _env.ACTOR, "SummonedLYSi", this.summonFactor, {
					1,
					0,
					0
				}, {
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

				if SummonLYSi2 then
					global.AddStatus(_env, SummonLYSi2, "SummonLYSi")

					local buffeft1 = global.SpecialNumericEffect(_env, "+Normal_Summon_LYSi", {
						"?Normal"
					}, this.DmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+Extra_Summon_LYSi", {
						"?Normal"
					}, this.ExtraDmgRateFactor)

					global.ApplyBuff(_env, SummonLYSi2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LYSi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYSi_Passive_EX = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					if global.MARKED(_env, "ATSheng")(_env, unit) or global.MARKED(_env, "XLai")(_env, unit) then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_LYSi_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					elseif global.MARKED(_env, "ALSi")(_env, unit) then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)
						local buffeft2 = global.Immune(_env)
						local buffeft3 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "DEBUFF"))

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_LYSi_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 15,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1, 0)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYSi_Hat_Passive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local DmgRateFactor = global.SpecialPropGetter(_env, "Normal_Summon_LYSi")(_env, _env.ACTOR)
					local ExtraRateFactor = global.SpecialPropGetter(_env, "Extra_Summon_LYSi")(_env, _env.ACTOR)

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						DmgRateFactor,
						0
					})

					if global.MARKED(_env, "MAGE")(_env, unit) then
						damage.val = damage.val * (1 + ExtraRateFactor)
					end

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}

	return _M
end
