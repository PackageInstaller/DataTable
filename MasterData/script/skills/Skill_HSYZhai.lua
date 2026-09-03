-- chunkname: @/tmp/or_skill/lua_compile/Skill_HSYZhai.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_HSYZhai_Normal = {
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
					-1,
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
	_M.__all__.Skill_HSYZhai_Proud = {
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
					-1.3,
					0
				}, 100, "skill2"))
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
	_M.__all__.Skill_HSYZhai_Unique = {
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
			_env.target = nil

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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 and global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							_env.target = _env.TARGET or global.RandomN(_env, 1, global.EnemyUnits(_env, -global.HASBUFFTAG(_env, global.BUFF_MARKED(_env, "STEALTH"))))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, _env.target))

							break
						end
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							_env.target = unit
						end
					end
				else
					_env.target = _env.TARGET
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.target, "target")
				global.HarmTargetView(_env, {
					_env.target
				})
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.target)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local unhurtrate = global.UnitPropGetter(_env, "unhurtrate")(_env, _env.target)
				local buff = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, unhurtrate / 2)

				global.ApplyBuff(_env, _env.target, {
					timing = 1,
					duration = 1,
					tags = {
						"HSYZhai_Unique"
					}
				}, {
					buff
				})

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 then
					damage.val = damage.val * (1 + this.exdamagerate)

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "HSYZhai_First_Unique"), 1)
				end

				global.DispelBuff(_env, _env.target, global.BUFF_MARKED_ALL(_env, "HSYZhai_Unique"), 1)
				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
			end)
			exec["@time"]({
				2450
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"HSYZhai_First_Unique"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSYZhai_Passive = {
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
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "HSYZhai_Passive_Count"))

				if (global.PETS - global.SUMMONS)(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and count < this.Times and global.abs(_env, global.GetCellId(_env, _env.ACTOR)) - global.abs(_env, global.GetCellId(_env, _env.unit)) == 3 then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

					local cardlocation = global.GetCardWindowIndex(_env, _env.unit)

					if cardlocation == 0 then
						cardlocation = global.Random(_env, 1, 4)
					end

					local card = global.BackToCard_ResultCheck(_env, _env.ACTOR, "window", cardlocation)

					if card then
						global.Kick(_env, _env.ACTOR)

						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"HSYZhai_Passive_Count"
							}
						}, {
							buff
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSYZhai_Proud_EX = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "HSYZhai_Unique_Target")) > 0 then
						_env.target = unit

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "HSYZhai_Unique_Target"), 1)
					end
				end

				if _env.target then
					-- block empty
				else
					_env.target = _env.TARGET
				end

				global.AssignRoles(_env, _env.target, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-1.3,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
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
				local buffeft = global.NumericEffect(_env, "+exskillrate", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"Skill_HSYZhai_Proud_EX_EXSKILLRATE"
					}
				}, {
					buffeft
				})

				local buffeft2 = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft3 = global.Diligent(_env)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2,
					buffeft3
				})
				global.DiligentRound(_env, 100)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSYZhai_Unique_EX = {
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
			_env.target = nil
			_env.flag = 0

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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 and global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							_env.target = _env.TARGET or global.RandomN(_env, 1, global.EnemyUnits(_env, -global.HASBUFFTAG(_env, global.BUFF_MARKED(_env, "STEALTH"))))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, _env.target))

							break
						end
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							_env.target = unit

							if not global.MASTER(_env, _env.target) and not global.MARKED(_env, "DAGUN")(_env, _env.target) and not global.MARKED(_env, "SummonedNian")(_env, _env.target) then
								_env.flag = 1
							end
						end
					end
				else
					_env.target = _env.TARGET

					if global.SelectBuffCount(_env, _env.target, global.BUFF_MARKED(_env, "TAUNT")) > 0 and not global.MASTER(_env, _env.target) and not global.MARKED(_env, "DAGUN")(_env, _env.target) and not global.MARKED(_env, "SummonedNian")(_env, _env.target) then
						_env.flag = 1
					end
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.target, "target")
				global.HarmTargetView(_env, {
					_env.target
				})
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.target)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local unhurtrate = global.UnitPropGetter(_env, "unhurtrate")(_env, _env.target)
				local buff = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, unhurtrate / 2)

				global.ApplyBuff(_env, _env.target, {
					timing = 1,
					duration = 1,
					tags = {
						"HSYZhai_Unique"
					}
				}, {
					buff
				})

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local buffeft = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.target, {
					timing = 0,
					duration = 99,
					tags = {
						"HSYZhai_Unique_Target"
					}
				}, {
					buffeft
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 then
					damage.val = damage.val * (1 + this.exdamagerate)

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "HSYZhai_First_Unique"), 1)
				end

				if _env.flag == 1 then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.target)
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

					global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.target, 1, 1, 0, 0, 0, nil, global.min(_env, maxHp * this.maxhprate, atk * 2.5))
				end

				global.DispelBuff(_env, _env.target, global.BUFF_MARKED_ALL(_env, "HSYZhai_Unique"), 1)
				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
			end)
			exec["@time"]({
				2450
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"HSYZhai_First_Unique"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSYZhai_Passive_EX = {
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
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "HSYZhai_Passive_Count"))

				if (global.PETS - global.SUMMONS)(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and count < this.Times and global.abs(_env, global.GetCellId(_env, _env.ACTOR)) - global.abs(_env, global.GetCellId(_env, _env.unit)) == 3 then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

					local cardlocation = global.GetCardWindowIndex(_env, _env.unit)

					if cardlocation == 0 then
						cardlocation = global.Random(_env, 1, 4)
					end

					local card = global.BackToCard_ResultCheck(_env, _env.ACTOR, "window", cardlocation)

					if card then
						global.Kick(_env, _env.ACTOR)

						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"HSYZhai_Passive_Count"
							}
						}, {
							buff
						})

						count = count + 1

						local buffeft = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.atkrate * count)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_HSYZhai_Passive_EX"
							}
						}, {
							buffeft
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSYZhai_Unique_Awaken = {
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
			_env.target = nil
			_env.flag = 0

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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 and global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							_env.target = _env.TARGET or global.RandomN(_env, 1, global.EnemyUnits(_env))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, _env.target))

							break
						end
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							_env.target = unit

							if not global.MASTER(_env, _env.target) and not global.MARKED(_env, "DAGUN")(_env, _env.target) and not global.MARKED(_env, "SummonedNian")(_env, _env.target) then
								_env.flag = 1
							end
						end
					end
				else
					_env.target = _env.TARGET

					if global.SelectBuffCount(_env, _env.target, global.BUFF_MARKED(_env, "TAUNT")) > 0 and not global.MASTER(_env, _env.target) and not global.MARKED(_env, "DAGUN")(_env, _env.target) and not global.MARKED(_env, "SummonedNian")(_env, _env.target) then
						_env.flag = 1
					end
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.target, "target")
				global.HarmTargetView(_env, {
					_env.target
				})
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.target)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local unhurtrate = global.UnitPropGetter(_env, "unhurtrate")(_env, _env.target)
				local enemyfront = global.EnemyUnits(_env, global.FRONT_OF(_env, _env.target, true) * global.COL_OF(_env, _env.target))

				if #enemyfront > 0 then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), global.min(_env, #enemyfront, global.GetPlayerEnergy(_env, _env.target)))
					global.ApplyEnergyDamage(_env, global.GetOwner(_env, _env.target), #enemyfront)

					local buff = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, unhurtrate / 2)

					global.ApplyBuff(_env, _env.target, {
						timing = 1,
						duration = 1,
						tags = {
							"HSYZhai_Unique"
						}
					}, {
						buff
					})
				else
					local buff = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, unhurtrate)

					global.ApplyBuff(_env, _env.target, {
						timing = 1,
						duration = 1,
						tags = {
							"HSYZhai_Unique"
						}
					}, {
						buff
					})
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local buffeft = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.target, {
					timing = 0,
					duration = 99,
					tags = {
						"HSYZhai_Unique_Target"
					}
				}, {
					buffeft
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "HSYZhai_First_Unique")) > 0 then
					damage.val = damage.val * (1 + this.exdamagerate)

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "HSYZhai_First_Unique"), 1)
				end

				if _env.flag == 1 then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.target)
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

					global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.target, 1, 1, 0, 0, 0, nil, global.min(_env, maxHp * this.maxhprate, atk * 2.5))
				end

				global.DispelBuff(_env, _env.target, global.BUFF_MARKED_ALL(_env, "HSYZhai_Unique"), 1)
				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
			end)
			exec["@time"]({
				2450
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"HSYZhai_First_Unique"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}

	return _M
end
