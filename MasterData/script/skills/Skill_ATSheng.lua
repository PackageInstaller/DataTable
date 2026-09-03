-- chunkname: @/tmp/or_skill/lua_compile/Skill_ATSheng.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_ATSheng_Normal = {
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
					-1.7,
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
	_M.__all__.Skill_ATSheng_Proud = {
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
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				833
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
	_M.__all__.Skill_ATSheng_Unique = {
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
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedATSheng"))) do
					global.Kick(_env, summonunit)
				end
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.AddAnim(_env, {
					loop = 1,
					anim = "cisha_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.TARGET)
				})

				local MaxHpRateFactor = global.SpecialPropGetter(_env, "specialnum3")(_env, _env.ACTOR)
				local SummonedATShengA = global.Summon(_env, _env.ACTOR, "SummonedATSheng_Mermaid", this.summonFactorA, {
					0,
					1,
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

				if SummonedATShengA then
					global.AddStatus(_env, SummonedATShengA, "SummonedATSheng")

					if MaxHpRateFactor and MaxHpRateFactor ~= 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, SummonedATShengA)
						local buffeft1 = global.MaxHpEffect(_env, maxHp * MaxHpRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, SummonedATShengA, {
							duration = 99,
							group = "Skill_ATSheng_Passive_MaxhpUp",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"MAXHPUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end

					local UnHurtRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft2 = global.SpecialNumericEffect(_env, "+Skill_ATSheng_Passive_UnHurtRate", {
						"?Normal"
					}, UnHurtRateFactor)

					global.ApplyBuff(_env, SummonedATShengA, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"UNHURTRATEUP",
							"Skill_ATSheng_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end

				local SummonedATShengB = global.Summon(_env, _env.ACTOR, "SummonedATSheng_Queen", this.summonFactorB, {
					0,
					1,
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

				if SummonedATShengB then
					global.AddStatus(_env, SummonedATShengB, "SummonedATSheng")

					if MaxHpRateFactor and MaxHpRateFactor ~= 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, SummonedATShengB)
						local buffeft3 = global.MaxHpEffect(_env, maxHp * MaxHpRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, SummonedATShengB, {
							duration = 99,
							group = "Skill_ATSheng_Passive_MaxhpUp",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"MAXHPUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft3
						}, 1)
					end

					local HurtRateFactor = global.SpecialPropGetter(_env, "specialnum2")(_env, _env.ACTOR)
					local buffeft4 = global.SpecialNumericEffect(_env, "+Skill_ATSheng_Passive_HurtRate", {
						"?Normal"
					}, HurtRateFactor)

					global.ApplyBuff(_env, SummonedATShengB, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"HURTRATEUP",
							"Skill_ATSheng_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft4
					})
				end
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Passive = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, this.UnHurtRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+specialnum2", {
					"?Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_ATSheng_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, "ATSheng")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum3", {
						"?Normal"
					}, this.MaxHpRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_ATSheng_Passive_Key",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Mermaid_Normal = {
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
	_M.__all__.Skill_ATSheng_Mermaid_Passive = {
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
				local UnHurtRateFactor = global.SpecialPropGetter(_env, "Skill_ATSheng_Passive_UnHurtRate")(_env, _env.ACTOR)

				if UnHurtRateFactor and UnHurtRateFactor ~= 0 then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, UnHurtRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_ATSheng_Mermaid_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"Skill_ATSheng_Mermaid_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local UnHurtRateFactor = global.SpecialPropGetter(_env, "Skill_ATSheng_Passive_UnHurtRate")(_env, _env.ACTOR)

					if UnHurtRateFactor and UnHurtRateFactor ~= 0 then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, UnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_ATSheng_Mermaid_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"Skill_ATSheng_Mermaid_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_ATSheng_Mermaid_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Queen_Normal = {
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
	_M.__all__.Skill_ATSheng_Queen_Passive = {
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
				local MyMaste = global.GetSummoner(_env, _env.ACTOR)
				local HurtRateFactor = global.SpecialPropGetter(_env, "Skill_ATSheng_Passive_HurtRate")(_env, _env.ACTOR)

				if HurtRateFactor == 0 then
					HurtRateFactor = global.SpecialPropGetter(_env, "Skill_ATSheng_Passive_HurtRate")(_env, MyMaste)
				end

				if HurtRateFactor and HurtRateFactor ~= 0 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, HurtRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "HurtRateUp",
							group = "Skill_ATSheng_Queen_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"Skill_ATSheng_Queen_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local MyMaste = global.GetSummoner(_env, _env.ACTOR)
					local HurtRateFactor = global.SpecialPropGetter(_env, "Skill_ATSheng_Passive_HurtRate")(_env, _env.ACTOR)

					if HurtRateFactor and HurtRateFactor ~= 0 then
						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, HurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							display = "HurtRateUp",
							group = "Skill_ATSheng_Queen_Passive",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"Skill_ATSheng_Queen_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_ATSheng_Queen_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Proud_EX = {
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
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				833
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
	_M.__all__.Skill_ATSheng_Unique_EX = {
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
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedATSheng"))) do
					global.Kick(_env, summonunit)
				end
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.AddAnim(_env, {
					loop = 1,
					anim = "cisha_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.TARGET)
				})

				local MaxHpRateFactor = global.SpecialPropGetter(_env, "specialnum3")(_env, _env.ACTOR)
				local SummonedATShengA = global.Summon(_env, _env.ACTOR, "SummonedATSheng_Mermaid", this.summonFactorA, {
					0,
					1,
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

				if SummonedATShengA then
					global.AddStatus(_env, SummonedATShengA, "SummonedATSheng")

					if MaxHpRateFactor and MaxHpRateFactor ~= 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, SummonedATShengA)
						local buffeft1 = global.MaxHpEffect(_env, maxHp * MaxHpRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, SummonedATShengA, {
							duration = 99,
							group = "Skill_ATSheng_Passive_MaxhpUp",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"MAXHPUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1)
					end

					local UnHurtRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft2 = global.SpecialNumericEffect(_env, "+Skill_ATSheng_Passive_UnHurtRate", {
						"?Normal"
					}, UnHurtRateFactor)

					global.ApplyBuff(_env, SummonedATShengA, {
						duration = 99,
						group = "Skill_ATSheng_Passive_UnHurtRate",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"UNHURTRATEUP",
							"Skill_ATSheng_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end

				local SummonedATShengB = global.Summon(_env, _env.ACTOR, "SummonedATSheng_Queen", this.summonFactorB, {
					0,
					1,
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

				if SummonedATShengB then
					global.AddStatus(_env, SummonedATShengB, "SummonedATSheng")

					if MaxHpRateFactor and MaxHpRateFactor ~= 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, SummonedATShengB)
						local buffeft3 = global.MaxHpEffect(_env, maxHp * MaxHpRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, SummonedATShengB, {
							duration = 99,
							group = "Skill_ATSheng_Passive_MaxhpUp",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"MAXHPUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft3
						}, 1)
					end

					local HurtRateFactor = global.SpecialPropGetter(_env, "specialnum2")(_env, _env.ACTOR)
					local buffeft4 = global.SpecialNumericEffect(_env, "+Skill_ATSheng_Passive_HurtRate", {
						"?Normal"
					}, HurtRateFactor)

					global.ApplyBuff(_env, SummonedATShengB, {
						duration = 99,
						group = "Skill_ATSheng_Passive_HurtRate",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"HURTRATEUP",
							"Skill_ATSheng_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft4
					})
				end
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_ATSheng_Passive_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, this.UnHurtRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+specialnum2", {
					"?Normal"
				}, this.HurtRateFactor)
				local buffeft3 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.EXHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_ATSheng_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}

	return _M
end
