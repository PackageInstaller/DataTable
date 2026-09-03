-- chunkname: @/tmp/or_skill/lua_compile/Skill_GLFu_L.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_GLFu_L_Normal = {
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
	_M.__all__.Skill_GLFu_L_Proud = {
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
				834
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
	_M.__all__.Skill_GLFu_L_Unique = {
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
					-1.8,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2967
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if global.INSTATUS(_env, "BIG")(_env, _env.ACTOR) then
					global.print(_env, "斯威夫特--必杀技转换真伤前伤害", damage.val)

					damage.val = (1 - this.RealDamageFactor) * damage.val + global.EvalRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2], 0, 0, damage) * this.RealDamageFactor

					global.print(_env, "斯威夫特--转换真伤后伤害", damage.val)
				end

				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.DeRageFactor)
				global.ShakeScreen(_env, {
					Id = 3,
					duration = 20,
					enhance = 5
				})

				if global.INSTATUS(_env, "SMALL")(_env, _env.ACTOR) then
					if global.FriendMaster(_env) then
						global.DelayCall(_env, 200, global.ApplyRPRecovery, global.FriendMaster(_env), this.RageFactor)
					end

					if #global.FriendUnits(_env, global.PETS - global.SUMMONS - global.MASTER) > 1 then
						global.DelayCall(_env, 200, global.ApplyRPRecovery, global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.SUMMONS - global.ONESELF(_env, _env.ACTOR)))[1], this.RageFactor)
					end
				end

				local count = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Stealth")) > 0 then
						count = count + 1
					end
				end

				if result and result.deadly ~= true and ((#global.EnemyUnits(_env) > 5 and count < 2 or nil) and 0) == 0 then
					local target = _env.TARGET

					if target and (global.SUMMONS(_env, target) or global.MASTER(_env, target) or global.MARKED(_env, "DAGUN")(_env, target) or global.MARKED(_env, "SummonedNian")(_env, target)) then
						target = nil
					end

					if target ~= nil then
						global.DispelBuff(_env, target, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

						local buffeft1 = global.Daze(_env)
						local buffeft2 = global.Stealth(_env, 0.4)
						local buffeft3 = global.HPRecoverRatioEffect(_env, -1)
						local buffeft4 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 99999)
						local buffeft5 = global.Immune(_env)
						local buffeft6 = global.ImmuneBuff(_env, "BUFF")
						local buffeft7 = global.ImmuneBuff(_env, "DEBUFF")

						global.ApplyBuff_Debuff(_env, _env.ACTOR, target, {
							timing = 2,
							display = "Daze",
							group = "Skill_GLFu_L_Unique_Daze",
							limit = 1,
							duration = this.TimeFactor,
							tags = {
								"Skill_GLFu_L_Unique_Daze",
								"DAZE",
								"STATUS",
								"ABNORMAL",
								"UNDISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.ApplyBuff_Debuff(_env, _env.ACTOR, target, {
							timing = 2,
							display = "Immune",
							group = "Skill_GLFu_L_Unique_Stealth",
							limit = 1,
							duration = this.TimeFactor,
							tags = {
								"Skill_GLFu_L_Unique_Stealth",
								"STATUS",
								"ABNORMAL",
								"UNDISPELLABLE",
								"STEALTH"
							}
						}, {
							buffeft2,
							buffeft3,
							buffeft4,
							buffeft5,
							buffeft6,
							buffeft7
						}, 1, 0)
					end
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_GLFu_L_Passive = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) and ((global.PETS - global.SUMMONS)(_env, _env.unit) or global.MARKED(_env, "SummonedCBJun_Check")(_env, _env.unit) or global.MARKED(_env, "King_Check")(_env, _env.unit) or global.MARKED(_env, "SMSNv_BOTu_Check")(_env, _env.unit)) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "GLFu_L"))) do
						if global.SpecialPropGetter(_env, "Skill_GLFu_L_Passive_Count")(_env, global.FriendField(_env)) < 10 then
							local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE",
									"Skill_GLFu_L_Passive"
								}
							}, {
								cardvaluechange
							})

							local buffeft1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkRateFactor)
							local maxHp = global.GetHeroCardAttr(_env, card, "maxHp")
							local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpFactor)

							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								duration = 99,
								group = "Skill_GLFu_L_Passive_AtkRate",
								timing = 0,
								limit = 10,
								tags = {
									"Skill_GLFu_L_Passive",
									"STATUS",
									"NUMERIC",
									"BUFF",
									"ATKUP",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft1
							})
							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								duration = 99,
								group = "Skill_GLFu_L_Passive_MaxHpRate",
								timing = 0,
								limit = 10,
								tags = {
									"Skill_GLFu_L_Passive",
									"STATUS",
									"NUMERIC",
									"BUFF",
									"MAXHPUP",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft2
							})

							local buffeft_count = global.SpecialNumericEffect(_env, "+Skill_GLFu_L_Passive_Count", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"Skill_GLFu_L_Passive_Count"
								}
							}, {
								buffeft_count
							})
						end
					end
				end

				if global.INSTATUS(_env, "SMALL")(_env, _env.ACTOR) and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.ACTOR ~= _env.unit and (global.PETS - global.SUMMONS - global.MASTER)(_env, _env.unit) then
					local buffeft = global.RageGainEffect(_env, "+", {
						"+Normal",
						"+Normal"
					}, this.RageSpdactor)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "Skill_GLFu_L_Passive_s2",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"NUMERIC",
							"BUFF",
							"RAGESPEEDUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
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

				if global.GetActualCost(_env, _env.ACTOR) < 16 and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "SMALL")

					local buffeft_s1 = global.EnergyEffect(_env, 1 + this.EnergyRecoveryFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "EnergyEffectUp",
						group = "Skill_GLFu_L_Passive_s1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"ENERGYEFFECTUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"GLFU_L_ENERGYEFFECTUP"
						}
					}, {
						buffeft_s1
					})

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						local buffeft = global.RageGainEffect(_env, "+", {
							"+Normal",
							"+Normal"
						}, this.RageSpdactor)

						global.ApplyBuff(_env, unit, {
							duration = 99,
							group = "Skill_GLFu_L_Passive_s2",
							timing = 0,
							limit = 1,
							tags = {
								"Skill_GLFu_L_Passive",
								"NUMERIC",
								"BUFF",
								"RAGESPEEDUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						})
					end
				end

				if global.GetActualCost(_env, _env.ACTOR) > 15 and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "BIG")
					global.setRoleScale(_env, _env.ACTOR, 1 + (global.GetActualCost(_env, _env.ACTOR) - 10) * 0.03)

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ExtraAtkRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.ExtraMaxHpFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_GLFu_L_Passive_AtkRate_1",
						duration = 99,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_GLFu_L_Passive_MaxHpRate_1",
						duration = 99,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end

				if global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_GLFu_L_Passive_Count"), 99)
					global.print(_env, "斯威夫特-登场时攻击加成", global.UnitPropGetter(_env, "atkrate")(_env, _env.ACTOR))
					global.print(_env, "斯威夫特-登场时最大生命值", global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR))
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.MARKED(_env, "GLFu_L")(_env, _env.unit) then
					for _, unit1 in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Passive"), 99)
					end

					for _, unit1 in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Stealth"), 99)
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Daze"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_GLFu_L_Proud_EX = {
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
				834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if global.INSTATUS(_env, "SMALL")(_env, _env.ACTOR) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end

				if global.INSTATUS(_env, "BIG")(_env, _env.ACTOR) then
					global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.DeRageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_GLFu_L_Unique_EX = {
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
					-1.8,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2967
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if global.INSTATUS(_env, "BIG")(_env, _env.ACTOR) then
					global.print(_env, "斯威夫特--必杀技转换真伤前伤害", damage.val)

					damage.val = (1 - this.RealDamageFactor) * damage.val + global.EvalRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2], 0, 0, damage) * this.RealDamageFactor

					global.print(_env, "斯威夫特--转换真伤后伤害", damage.val)
				end

				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.DeRageFactor)
				global.ShakeScreen(_env, {
					Id = 3,
					duration = 20,
					enhance = 5
				})

				if global.INSTATUS(_env, "SMALL")(_env, _env.ACTOR) then
					if global.FriendMaster(_env) then
						global.DelayCall(_env, 200, global.ApplyRPRecovery, global.FriendMaster(_env), this.RageFactor)
					end

					if #global.FriendUnits(_env, global.PETS - global.SUMMONS - global.MASTER) > 1 then
						global.DelayCall(_env, 200, global.ApplyRPRecovery, global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.SUMMONS - global.ONESELF(_env, _env.ACTOR)))[1], this.RageFactor)
					end
				end

				local count = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Stealth")) > 0 then
						count = count + 1
					end
				end

				if result and result.deadly ~= true and ((#global.EnemyUnits(_env) > 5 and count < 2 or nil) and 0) == 0 then
					local target = _env.TARGET

					if target and (global.SUMMONS(_env, target) or global.MASTER(_env, target) or global.MARKED(_env, "DAGUN")(_env, target) or global.MARKED(_env, "SummonedNian")(_env, target)) then
						target = nil
					end

					if target ~= nil then
						global.DispelBuff(_env, target, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

						local buffeft1 = global.Daze(_env)
						local buffeft2 = global.Stealth(_env, 0.4)
						local buffeft3 = global.HPRecoverRatioEffect(_env, -1)
						local buffeft4 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 99999)
						local buffeft5 = global.Immune(_env)
						local buffeft6 = global.ImmuneBuff(_env, "BUFF")
						local buffeft7 = global.ImmuneBuff(_env, "DEBUFF")

						global.ApplyBuff_Debuff(_env, _env.ACTOR, target, {
							timing = 2,
							display = "Daze",
							group = "Skill_GLFu_L_Unique_Daze",
							limit = 1,
							duration = this.TimeFactor,
							tags = {
								"Skill_GLFu_L_Unique_Daze",
								"STATUS",
								"DAZE",
								"ABNORMAL",
								"UNDISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.ApplyBuff_Debuff(_env, _env.ACTOR, target, {
							timing = 2,
							display = "Immune",
							group = "Skill_GLFu_L_Unique_Stealth",
							limit = 1,
							duration = this.TimeFactor,
							tags = {
								"Skill_GLFu_L_Unique_Stealth",
								"STATUS",
								"ABNORMAL",
								"UNDISPELLABLE",
								"STEALTH"
							}
						}, {
							buffeft2,
							buffeft3,
							buffeft4,
							buffeft5,
							buffeft6,
							buffeft7
						}, 1, 0)
					end
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_GLFu_L_Passive_EX = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) and ((global.PETS - global.SUMMONS)(_env, _env.unit) or global.MARKED(_env, "SummonedCBJun_Check")(_env, _env.unit) or global.MARKED(_env, "King_Check")(_env, _env.unit) or global.MARKED(_env, "SMSNv_BOTu_Check")(_env, _env.unit)) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "GLFu_L"))) do
						if global.SpecialPropGetter(_env, "Skill_GLFu_L_Passive_Count")(_env, global.FriendField(_env)) < 10 then
							local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE",
									"Skill_GLFu_L_Passive"
								}
							}, {
								cardvaluechange
							})

							local buffeft1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkRateFactor)
							local maxHp = global.GetHeroCardAttr(_env, card, "maxHp")
							local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpFactor)

							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								duration = 99,
								group = "Skill_GLFu_L_Passive_AtkRate",
								timing = 0,
								limit = 10,
								tags = {
									"Skill_GLFu_L_Passive",
									"STATUS",
									"NUMERIC",
									"BUFF",
									"ATKUP",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft1
							})
							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
								duration = 99,
								group = "Skill_GLFu_L_Passive_MaxHpRate",
								timing = 0,
								limit = 10,
								tags = {
									"Skill_GLFu_L_Passive",
									"STATUS",
									"NUMERIC",
									"BUFF",
									"MAXHPUP",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft2
							})

							local buffeft_count = global.SpecialNumericEffect(_env, "+Skill_GLFu_L_Passive_Count", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"Skill_GLFu_L_Passive_Count"
								}
							}, {
								buffeft_count
							})
						end
					end
				end

				if global.INSTATUS(_env, "SMALL")(_env, _env.ACTOR) and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.ACTOR ~= _env.unit and (global.PETS - global.SUMMONS - global.MASTER)(_env, _env.unit) then
					local buffeft = global.RageGainEffect(_env, "+", {
						"+Normal",
						"+Normal"
					}, this.RageSpdactor)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "Skill_GLFu_L_Passive_s2",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"NUMERIC",
							"BUFF",
							"RAGESPEEDUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
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

				if global.GetActualCost(_env, _env.ACTOR) < 16 and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "SMALL")

					local buffeft_s1 = global.EnergyEffect(_env, 1 + this.EnergyRecoveryFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "EnergyEffectUp",
						group = "Skill_GLFu_L_Passive_s1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"ENERGYEFFECTUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"GLFU_L_ENERGYEFFECTUP"
						}
					}, {
						buffeft_s1
					})

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						local buffeft = global.RageGainEffect(_env, "+", {
							"+Normal",
							"+Normal"
						}, this.RageSpdactor)

						global.ApplyBuff(_env, unit, {
							duration = 99,
							group = "Skill_GLFu_L_Passive_s2",
							timing = 0,
							limit = 1,
							tags = {
								"Skill_GLFu_L_Passive",
								"NUMERIC",
								"BUFF",
								"RAGESPEEDUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						})
					end
				end

				if global.GetActualCost(_env, _env.ACTOR) > 15 and global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "BIG")
					global.setRoleScale(_env, _env.ACTOR, 1 + (global.GetActualCost(_env, _env.ACTOR) - 10) * 0.03)

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ExtraAtkRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.ExtraMaxHpFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_GLFu_L_Passive_AtkRate_1",
						duration = 99,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_GLFu_L_Passive_MaxHpRate_1",
						duration = 99,
						limit = 1,
						tags = {
							"Skill_GLFu_L_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end

				if global.MARKED(_env, "GLFu_L")(_env, _env.ACTOR) then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_GLFu_L_Passive_Count"), 99)
					global.print(_env, "斯威夫特-登场时攻击加成", global.UnitPropGetter(_env, "atkrate")(_env, _env.ACTOR))
					global.print(_env, "斯威夫特-登场时最大生命值", global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR))
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.MARKED(_env, "GLFu_L")(_env, _env.unit) then
					for _, unit1 in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Passive"), 99)
					end

					for _, unit1 in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Stealth"), 99)
						global.DispelBuff(_env, unit1, global.BUFF_MARKED(_env, "Skill_GLFu_L_Unique_Daze"), 99)
					end
				end
			end)

			return _env
		end
	}

	return _M
end
