-- chunkname: @/tmp/or_skill/lua_compile/Skill_MZGXiu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MZGXiu_Normal = {
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
				367
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
	_M.__all__.Skill_MZGXiu_Proud = {
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
					-1.85,
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

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					267
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Unique = {
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
			_env.master = nil

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
					-2,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15131_1") > 0 then
					local Atk1 = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local Atk2 = global.UnitPropGetter(_env, "atk")(_env, _env.TARGET)

					this.ProbRateFactor = this.ProbRateFactor + global.max(_env, 0, 0.05 * global.floor(_env, (Atk1 / Atk2 - 1) / 0.05))
				end

				if global.ProbTest(_env, this.ProbRateFactor) then
					_env.flag = 1
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if _env.flag == 1 then
					damage.val = damage.val * 2
				end

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					467
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.PETS(_env, _env.TARGET) and global.EnemyMaster(_env) then
					_env.master = global.EnemyMaster(_env)

					global.CancelTargetView(_env)
					global.HarmTargetView(_env, {
						_env.master
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.master) + {
						-2,
						0
					}, 100, "skill3"))
					global.UnassignRoles(_env, _env.TARGET, "target")
					global.AssignRoles(_env, _env.master, "target")
					global.RetainObject(_env, _env.master)
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				4300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.master)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.master)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.master, {
					1,
					this.SecondFactor,
					0
				})

				if _env.flag == 1 then
					damage.val = damage.val * 2
				end

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.master, {
					0,
					467
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				5500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and flag == 1 then
					global.Kamikakushi(_env, _env.ACTOR)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN"), 99)
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "down", "down")
				end
			end)

			return _env
		end
	}

	function _M.__all__.Kamikakushi(_env, unit)
		local this, global = _env.this, _env.global

		global.AnimForTrgt(_env, unit, {
			loop = 1,
			anim = "yindun_yingdun",
			zOrder = "TopLayer",
			pos = {
				0.5,
				0.4
			}
		})

		local buff = global.SpecialNumericEffect(_env, "+GUIDIE_SHENYIN", {
			"+Normal",
			"+Normal"
		}, 1)
		local buff2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "MAXHPDOWN", "DAMAGERESULT"))

		global.ApplyBuff(_env, unit, {
			timing = 0,
			duration = 99,
			display = "ShenYin",
			tags = {
				"GUIDIE_SHENYIN"
			}
		}, {
			buff,
			buff2
		})
		global.SwitchActionTo(_env, "hurt1", "stand")
		global.SwitchActionTo(_env, "down", "stand")
	end

	_M.__all__.Skill_MZGXiu_Passive_Key = {
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

				if global.MARKED(_env, "MZGXiu")(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "ZTXChang"))) do
						local Aibo = global.RecruitCard(_env, card, {
							7,
							9,
							8,
							4,
							6,
							5,
							1,
							3,
							2
						})

						if Aibo then
							global.AddStatus(_env, Aibo, "Skill_MZGXiu_Passive_Key")
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Proud_EX = {
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
					-1.85,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritStrgFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					display = "CritStrgUp",
					group = "Skill_ZTXChang_Proud_EX",
					duration = 2,
					limit = 3,
					tags = {
						"NUMERIC",
						"CRITSTRGUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					267
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Unique_EX = {
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
			_env.master = nil

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
					-2,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15131_1") > 0 then
					local Atk1 = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local Atk2 = global.UnitPropGetter(_env, "atk")(_env, _env.TARGET)

					this.ProbRateFactor = this.ProbRateFactor + global.max(_env, 0, 0.05 * global.floor(_env, Atk1 / Atk2 / 0.05))
				end

				if global.ProbTest(_env, this.ProbRateFactor) then
					_env.flag = 1
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if _env.flag == 1 then
					damage.val = damage.val * 2
				end

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					467
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.PETS(_env, _env.TARGET) and global.EnemyMaster(_env) then
					_env.master = global.EnemyMaster(_env)

					global.CancelTargetView(_env)
					global.HarmTargetView(_env, {
						_env.master
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.master) + {
						-2,
						0
					}, 100, "skill3"))
					global.UnassignRoles(_env, _env.TARGET, "target")
					global.AssignRoles(_env, _env.master, "target")
					global.RetainObject(_env, _env.master)
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				4300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.master)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.master)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.master, {
					1,
					this.SecondFactor,
					0
				})

				if _env.flag == 1 then
					damage.val = damage.val * 2
				end

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.master, {
					0,
					467
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				5500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and flag == 1 then
					global.Kamikakushi(_env, _env.ACTOR)

					local buff_crit = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRate)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "CritRateUp",
						group = "Skill_MZGXiu_Passive_Crit",
						duration = 99,
						limit = 6,
						tags = {
							"NUMERIC",
							"CRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_crit
					}, 1, 0)

					local buff_critstrg = global.NumericEffect(_env, "+critstrg", {
						"+Normal",
						"+Normal"
					}, this.CritStrg)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "CritStrgUp",
						group = "Skill_MZGXiu_Passive_Critstrg",
						duration = 99,
						limit = 6,
						tags = {
							"NUMERIC",
							"CRITSTRGUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_critstrg
					}, 1, 0)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN"), 99)
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "down", "down")
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZGXiu_Passive_Awaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and flag == 1 then
					global.Kamikakushi(_env, _env.ACTOR)

					local buff_crit = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRate)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "CritRateUp",
						group = "Skill_MZGXiu_Passive_Crit",
						duration = 99,
						limit = 6,
						tags = {
							"NUMERIC",
							"CRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_crit
					}, 1, 0)

					local buff_critstrg = global.NumericEffect(_env, "+critstrg", {
						"+Normal",
						"+Normal"
					}, this.CritStrg)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "CritStrgUp",
						group = "Skill_MZGXiu_Passive_Critstrg",
						duration = 99,
						limit = 6,
						tags = {
							"NUMERIC",
							"CRITSTRGUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_critstrg
					}, 1, 0)
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)

					local buffeft2 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "Skill_MZGXiu_Passive_Absorption",
						timing = 0,
						limit = 6,
						tags = {
							"NUMERIC",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN"), 99)
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "down", "down")
				end
			end)

			return _env
		end
	}

	return _M
end
