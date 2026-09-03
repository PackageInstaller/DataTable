-- chunkname: @/tmp/or_skill/lua_compile/Skill_SMSNv.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SMSNv_Normal = {
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
	_M.__all__.skill_mengyanzhaoguai = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.dmgFactor = {
				1,
				3.6,
				0
			}
			_env.summonFactorHp = 0.5
			_env.summonFactorAtk = 0.5
			_env.summonFactorDef = 1
			_env.summonFactor = {
				_env.summonFactorHp,
				_env.summonFactorAtk,
				_env.summonFactorDef
			}

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.print(_env, "召唤========")

				local SummonedLDu1 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu2 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu3 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu4 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu5 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu6 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu7 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu8 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
				local SummonedLDu9 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Proud = {
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
			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Transfigure(_env, _env.ACTOR, "SSMSNv_DDing", {
					model = "Model_DDing"
				})
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.3,
					0
				}, 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				global.Transfigure(_env, _env.ACTOR, "SSMSNv", {
					model = "Model_SMSNv_SR"
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Unique = {
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

			_env.flag = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local Card = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SP_DDing"))

				if Card[1] ~= nil then
					global.Transfigure(_env, _env.ACTOR, "SSMSNv_SPDDing", {
						model = "Model_SP_DDing"
					})
				else
					_env.flag = 1
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
						0,
						0.2
					}, 100, "skill3"))

					_env.units = global.EnemyUnits(_env)

					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
						global.AssignRoles(_env, unit, "target1")
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
						global.AssignRoles(_env, unit, "target2")
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
						global.AssignRoles(_env, unit, "target3")
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.7,
						0
					}, 100, "skill1"))
					global.HarmTargetView(_env, _env.TARGET)
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 1 then
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

					local Hero = global.FriendUnits(_env, global.MARKED(_env, "SP_DDing"))

					if Hero[1] ~= nil then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * this.AtkFactor / global.UnitPropGetter(_env, "atk")(_env, Hero[1]))

						global.ApplyBuff_Buff(_env, _env.ACTOR, Hero[1], {
							timing = 0,
							display = "AtkUp",
							group = "Buff_SMSNv",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"BUFF",
								"ATKUP",
								"Buff_SMSNv",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1
						})
					end

					local shieldValue = damage.val

					if shieldValue > 0 and Hero[1] ~= nil then
						local buffeft1 = global.ShieldEffect(_env, shieldValue)

						global.ApplyBuff_Buff(_env, _env.ACTOR, Hero[1], {
							timing = 0,
							duration = 99,
							display = "Shield",
							tags = {
								"NUMERIC",
								"BUFF",
								"SHIELD",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end

					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.SetDisplayZorder(_env, _env.ACTOR, 1000)
					global.DelayCall(_env, 167, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})
					global.DelayCall(_env, 300, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})
					global.DelayCall(_env, 434, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							167
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							300
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							434
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					for _, unit in global.__iter__(_env.units) do
						local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

						if rage > 600 then
							global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
							global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
						end
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.ResetDisplayZorder(_env, _env.ACTOR)
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Transfigure(_env, _env.ACTOR, "SSMSNv", {
						model = "Model_SMSNv_SR"
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Passive = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SMSNv"))) do
						local buff = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"CARDBUFF",
								"INBORN",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.RefreshCardPool(_env, "INBORN")
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

				if not global.MASTER(_env, _env.ACTOR) and global.GetUnitCid(_env, _env.ACTOR) == "SMSNv" and global.SpecialPropGetter(_env, "SMSNv_Passive")(_env, global.FriendField(_env)) < this.Count then
					if global.EnemyMaster(_env) ~= nil then
						for i = 1, this.Quantity do
							local RoleModel = {
								"Model_SMSNv_BOTu"
							}
							local num = global.GetSufaceIndex(_env, _env.ACTOR)
							local card = global.InheritCardByConfig(_env, {
								ignorePassive = true,
								card = _env.ACTOR,
								modelId = RoleModel[num + 1],
								cost = this.Cost
							}, global.GetOwner(_env, global.EnemyMaster(_env)))

							if card then
								local buff = global.PassiveFunEffectBuff(_env, "SMSNv_BOTu_Passive", {
									master = _env.ACTOR
								})

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, global.EnemyMaster(_env)), card, {
									duration = 99,
									group = "SMSNv_BOTu_Passive",
									timing = 0,
									limit = 1,
									tags = {
										"CARDBUFF",
										"SMSNv_BOTu_Passive",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
								global.ClearCardFlags(_env, card, {
									"DARK"
								})
								global.AddCardFlags(_env, card, {
									"SMSNv_BOTu_Check"
								})
								global.AddCardFlags(_env, card, {
									"SUMMONED"
								})
							end
						end

						global.RefreshCardPool(_env, "LOCK_ALSi", global.GetOwner(_env, global.EnemyMaster(_env)))
					end

					if global.FriendMaster(_env) ~= nil then
						for i = 1, this.Quantity do
							local RoleModel = {
								"Model_SMSNv_BOTu"
							}
							local num = global.GetSufaceIndex(_env, _env.ACTOR)
							local card = global.InheritCardByConfig(_env, {
								ignorePassive = true,
								card = _env.ACTOR,
								modelId = RoleModel[num + 1],
								cost = this.Cost
							})

							if card then
								local buff = global.PassiveFunEffectBuff(_env, "SMSNv_BOTu_Passive", {
									master = _env.ACTOR
								})

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
									duration = 99,
									group = "SMSNv_BOTu_Passive",
									timing = 0,
									limit = 1,
									tags = {
										"CARDBUFF",
										"SMSNv_BOTu_Passive",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
								global.ClearCardFlags(_env, card, {
									"DARK"
								})
								global.AddCardFlags(_env, card, {
									"SMSNv_BOTu_Check"
								})
								global.AddCardFlags(_env, card, {
									"SUMMONED"
								})
							end
						end

						global.RefreshCardPool(_env, "LOCK_ALSi")
					end

					local buffeft3 = global.PassiveFunEffectBuff(_env, "Skill_SMSNv_BOTu_For_Field", {
						Energy = this.Energy,
						DazeRateFactor = this.DazeRateFactor
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_SMSNv_BOTu_For_Field",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})

					local buff_check = global.SpecialNumericEffect(_env, "+SMSNv_Passive", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"SMSNv_Passive_Check"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_BOTu_For_Field = {
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

				if global.MARKED(_env, "SMSNv_BOTu_Check")(_env, _env.unit) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

					local one = global.EnemyMaster(_env) and global.RandomN(_env, 1, global.EnemyUnits(_env, global.MASTER + global.PETS - global.SUMMONS)) or global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS - global.SUMMONS))
					local buffeft1 = global.Daze(_env)
					local attacker = global.LoadUnit(_env, _env.unit, "ATTACKER")
					local defender = global.LoadUnit(_env, one[1], "DEFENDER")
					local prob = global.EvalProb1(_env, attacker, defender, this.DazeRateFactor, 0)

					global.print(_env, "运行1====")

					if global.ProbTest(_env, prob) then
						global.print(_env, "运行2====")
						global.ApplyBuff_Debuff(_env, _env.unit, one[1], {
							timing = 2,
							duration = 1,
							display = "Daze",
							tags = {
								"STATUS",
								"DEBUFF",
								"DAZE",
								"ABNORMAL",
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
	_M.__all__.SMSNv_BOTu_Passive = {
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

				global.MarkSummoned(_env, _env.ACTOR, true)
				global.SetSummoner(_env, _env.ACTOR, this.master)
				global.ForceFlee(_env, 600)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Passive_EX = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SMSNv"))) do
						local buff = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"CARDBUFF",
								"INBORN",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.RefreshCardPool(_env, "INBORN")
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

				if not global.MASTER(_env, _env.ACTOR) and global.GetUnitCid(_env, _env.ACTOR) == "SMSNv" and global.SpecialPropGetter(_env, "SMSNv_Passive")(_env, global.FriendField(_env)) < this.Count then
					if global.EnemyMaster(_env) ~= nil then
						for i = 1, this.Quantity do
							local RoleModel = {
								"Model_SMSNv_BOTu"
							}
							local num = global.GetSufaceIndex(_env, _env.ACTOR)
							local card = global.InheritCardByConfig(_env, {
								ignorePassive = true,
								card = _env.ACTOR,
								modelId = RoleModel[num + 1],
								cost = this.Cost
							}, global.GetOwner(_env, global.EnemyMaster(_env)))

							if card then
								local buff = global.PassiveFunEffectBuff(_env, "SMSNv_BOTu_Passive", {
									master = _env.ACTOR
								})

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, global.EnemyMaster(_env)), card, {
									duration = 99,
									group = "SMSNv_BOTu_Passive",
									timing = 0,
									limit = 1,
									tags = {
										"CARDBUFF",
										"SMSNv_BOTu_Passive",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
								global.ClearCardFlags(_env, card, {
									"DARK"
								})
								global.AddCardFlags(_env, card, {
									"SMSNv_BOTu_Check"
								})
								global.AddCardFlags(_env, card, {
									"SUMMONED"
								})
							end
						end

						global.RefreshCardPool(_env, "LOCK_ALSi", global.GetOwner(_env, global.EnemyMaster(_env)))
					end

					if global.FriendMaster(_env) ~= nil then
						for i = 1, this.Quantity do
							local RoleModel = {
								"Model_SMSNv_BOTu"
							}
							local num = global.GetSufaceIndex(_env, _env.ACTOR)
							local card = global.InheritCardByConfig(_env, {
								ignorePassive = true,
								card = _env.ACTOR,
								modelId = RoleModel[num + 1],
								cost = this.Cost
							})

							if card then
								local buff = global.PassiveFunEffectBuff(_env, "SMSNv_BOTu_Passive", {
									master = _env.ACTOR
								})

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
									duration = 99,
									group = "SMSNv_BOTu_Passive",
									timing = 0,
									limit = 1,
									tags = {
										"CARDBUFF",
										"SMSNv_BOTu_Passive",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
								global.ClearCardFlags(_env, card, {
									"DARK"
								})
								global.AddCardFlags(_env, card, {
									"SMSNv_BOTu_Check"
								})
								global.AddCardFlags(_env, card, {
									"SUMMONED"
								})
							end
						end

						global.RefreshCardPool(_env, "LOCK_ALSi")
					end

					local buffeft3 = global.PassiveFunEffectBuff(_env, "Skill_SMSNv_BOTu_For_Field", {
						Energy = this.Energy,
						DazeRateFactor = this.DazeRateFactor
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_SMSNv_BOTu_For_Field",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})

					local buff_check = global.SpecialNumericEffect(_env, "+SMSNv_Passive", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"SMSNv_Passive_Check"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Proud_EX = {
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
			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Transfigure(_env, _env.ACTOR, "SSMSNv_DDing", {
					model = "Model_DDing"
				})
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.3,
					0
				}, 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local buffeft1 = global.Daze(_env)
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, unit, "DEFENDER")
					local prob = global.EvalProb1(_env, attacker, defender, this.DazeRateFactor, 0)

					if global.ProbTest(_env, prob) then
						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Daze",
							tags = {
								"STATUS",
								"DEBUFF",
								"DAZE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					end
				end

				global.Transfigure(_env, _env.ACTOR, "SSMSNv", {
					model = "Model_SMSNv_SR"
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Unique_EX = {
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

			_env.flag = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local Card = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SP_DDing"))

				if Card[1] ~= nil then
					global.Transfigure(_env, _env.ACTOR, "SSMSNv_SPDDing", {
						model = "Model_SP_DDing"
					})
				else
					_env.flag = 1
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
						0,
						0.2
					}, 100, "skill3"))

					_env.units = global.EnemyUnits(_env)

					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
						global.AssignRoles(_env, unit, "target1")
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
						global.AssignRoles(_env, unit, "target2")
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
						global.AssignRoles(_env, unit, "target3")
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.7,
						0
					}, 100, "skill1"))
					global.HarmTargetView(_env, _env.TARGET)
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 1 then
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

					local Hero = global.FriendUnits(_env, global.MARKED(_env, "SP_DDing"))

					if Hero[1] ~= nil then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * this.AtkFactor / global.UnitPropGetter(_env, "atk")(_env, Hero[1]))

						global.ApplyBuff_Buff(_env, _env.ACTOR, Hero[1], {
							timing = 0,
							display = "AtkUp",
							group = "Buff_SMSNv",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"BUFF",
								"ATKUP",
								"Buff_SMSNv",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1
						})
					end

					local shieldValue = damage.val

					if shieldValue > 0 and Hero[1] ~= nil then
						local buffeft1 = global.ShieldEffect(_env, shieldValue)

						global.ApplyBuff_Buff(_env, _env.ACTOR, Hero[1], {
							timing = 0,
							duration = 99,
							display = "Shield",
							tags = {
								"NUMERIC",
								"BUFF",
								"SHIELD",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end

					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.SetDisplayZorder(_env, _env.ACTOR, 1000)
					global.DelayCall(_env, 167, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})
					global.DelayCall(_env, 300, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})
					global.DelayCall(_env, 434, global.ShakeScreen, {
						Id = 4,
						duration = 80,
						enhance = 3
					})

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							167
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							300
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.SPdmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							434
						}, global.SplitValue(_env, damage, {
							0.3,
							0.7
						}))
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					for _, unit in global.__iter__(_env.units) do
						local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

						if rage > 600 then
							global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
							global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
						end
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.flag == 0 then
					global.ResetDisplayZorder(_env, _env.ACTOR)
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Transfigure(_env, _env.ACTOR, "SSMSNv", {
						model = "Model_SMSNv_SR"
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SMSNv_Passive_Key = {
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

				if global.MARKED(_env, "MoNvJiHui")(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_SMSNv_Key_HurtRate",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_SMSNv_Key",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)

			return _env
		end
	}

	return _M
end
