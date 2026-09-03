-- chunkname: @/tmp/or_skill/lua_compile/Skill_JNLong.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_JNLong_Normal = {
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
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
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
	_M.__all__.Skill_JNLong_Proud = {
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
	_M.__all__.Skill_JNLong_Unique = {
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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.MaxHpRateFactor, atk * 1.2))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "MaxHpUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"MAXHPUP",
						"UNDEAD",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Passive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
			end)
			exec["@time"]({
				300
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedJNLong1 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})
				local SummonedJNLong2 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})
				local SummonedJNLong3 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
					if SummonedJNLong1 then
						global.zhuomu(_env, SummonedJNLong1, _env.ACTOR)
					end

					if SummonedJNLong2 then
						global.zhuomu(_env, SummonedJNLong2, _env.ACTOR)
					end

					if SummonedJNLong3 then
						global.zhuomu(_env, SummonedJNLong3, _env.ACTOR)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Phantom_Normal = {
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
				}, 200, "skill1"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AssignRoles(_env, _env.TARGET, "target")
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Phantom_Proud = {
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
				}, 200, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AssignRoles(_env, _env.TARGET, "target")
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Phantom_Unique = {
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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.MaxHpRateFactor, atk * 1.2))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "MaxHpUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"MAXHPUP",
						"UNDEAD",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Phantom_Passive = {
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

				if global.SelectHeroPassiveCount(_env, global.GetSummoner(_env, _env.ACTOR), "EquipSkill_Boots_15108_2") > 0 then
					global.AddStatus(_env, _env.ACTOR, "EquipSkill_Boots_15108_2")

					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15108_2_Passive", {
						RateFactor = 0.8
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectHeroPassiveCount(_env, global.GetSummoner(_env, _env.ACTOR), "Hero_PBattle_JNLong_SelfAwaken") > 0 then
					local BeCureRateFactor = global.SpecialPropGetter(_env, "Skill_JNLong_Passive_SelfAwaken_BeCureRateFactor")(_env, global.FriendField(_env)) or 0.1
					local RageSpdactor = global.SpecialPropGetter(_env, "Skill_JNLong_Passive_SelfAwaken_RageSpdactor")(_env, global.FriendField(_env)) or 0.1
					local buffeft1 = global.NumericEffect(_env, "-becuredrate", {
						"+Normal",
						"+Normal"
					}, BeCureRateFactor)
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, RageSpdactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.primTrgt, {
						timing = 4,
						display = "BeCuredRateDown",
						group = "Skill_JNLong_Passive_SelfAwaken",
						duration = 15,
						limit = 3,
						tags = {
							"STATUS",
							"DEBUFF",
							"BECUREDRATEDOWN",
							"DISPELLABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	function _M.__all__.zhuomu(_env, unit, master)
		local this, global = _env.this, _env.global

		global.AddStatus(_env, unit, "EquipSkill_Boots_15108_2")

		local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15108_2_Passive", {
			RateFactor = 0.8,
			cid = global.GetUnitCid(_env, master)
		})

		global.ApplyBuff(_env, unit, {
			timing = 0,
			duration = 99,
			tags = {
				"NUMERIC",
				"BUFF",
				"UNDISPELLABLE",
				"UNSTEALABLE",
				"UR_EQUIPMENT"
			}
		}, {
			buff
		})
	end

	_M.__all__.Skill_JNLong_Proud_EX = {
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
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "DefWeakenUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Unique_EX = {
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
				local selfAtk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local selfDef = global.UnitPropGetter(_env, "def")(_env, _env.ACTOR)

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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.MaxHpRateFactor, atk * 1.2))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "MaxHpUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"MAXHPUP",
						"UNDEAD",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Passive_Death_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedJNLong1 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong1 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong1, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff(_env, SummonedJNLong1, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedJNLong2 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong2 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong2, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff(_env, SummonedJNLong2, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedJNLong3 = global.Summon(_env, _env.ACTOR, "SummonedJNLong", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong3 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong3, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff(_env, SummonedJNLong3, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
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
				local buffeft1 = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_JNLong_Passive_Death",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"AOEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Passive_Death_Awaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedJNLong1 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong1 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong1, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong1, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong1, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedJNLong2 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong2 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong2, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong2, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong2, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedJNLong3 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong3 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong3, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong3, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong3, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
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
				local buffeft1 = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_JNLong_Passive_Death_Awaken",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"AOEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedJNLong")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.FactorRP)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Passive_SelfAwaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff1 = global.Diligent(_env)
				local buff2 = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)
				local SummonedJNLong1 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong1 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong1, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong1, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong1, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedJNLong1, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_JNLong_Passive_SelfAwaken",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2
					})
				end

				local SummonedJNLong2 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong2 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong2, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong2, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong2, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedJNLong2, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_JNLong_Passive_SelfAwaken",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2
					})
				end

				local SummonedJNLong3 = global.Summon(_env, _env.ACTOR, "SummonedJNLong_Awaken", this.summonFactor, nil, {
					global.Random(_env, 2, 1, 3, 5, 4, 6, 7, 8, 9)
				})

				if SummonedJNLong3 then
					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Boots_15108_2") > 0 or global.INSTATUS(_env, "zhuomu")(_env, _env.ACTOR) then
						global.zhuomu(_env, SummonedJNLong3, _env.ACTOR)
					end

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.AddStatus(_env, SummonedJNLong3, "SummonedJNLong")
					global.ApplyBuff(_env, SummonedJNLong3, {
						duration = 99,
						group = "Skill_JNLong_Passive_Death_Awaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedJNLong3, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_JNLong_Passive_SelfAwaken",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2
					})
				end
			end)

			return _env
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
				local buffeft3 = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_JNLong_Passive_Death_Awaken",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"AOEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft3
				})

				local buff = global.PassiveFunEffectBuff(_env, "Skill_JNLong_Passive_SelfAwaken_DiligentRound")

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Skill_JNLong_Passive_SelfAwaken_DiligentRound"
					}
				}, {
					buff
				})

				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_JNLong_Passive_SelfAwaken_BeCureRateFactor", {
					"+Normal",
					"+Normal"
				}, this.BeCureRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Skill_JNLong_Passive_SelfAwaken_RageSpdactor", {
					"+Normal",
					"+Normal"
				}, this.RageSpdactor)

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 99,
					group = "Skill_JNLong_Passive_SelfAwaken_debuff",
					timing = 0,
					limit = 1,
					tags = {
						"Skill_JNLong_Passive_SelfAwaken"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedJNLong")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.FactorRP)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "-becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCureRateFactor)
				local buffeft2 = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, this.RageSpdactor)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.primTrgt, {
					timing = 4,
					display = "BeCuredRateDown",
					group = "Skill_JNLong_Passive_SelfAwaken",
					duration = 15,
					limit = 3,
					tags = {
						"STATUS",
						"DEBUFF",
						"BECUREDRATEDOWN",
						"DISPELLABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JNLong_Passive_SelfAwaken_DiligentRound = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedJNLong")(_env, _env.unit) then
					global.DiligentRound(_env, 100)
				end
			end)

			return _env
		end
	}

	return _M
end
