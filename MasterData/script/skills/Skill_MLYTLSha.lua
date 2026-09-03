-- chunkname: @/tmp/or_skill/lua_compile/Skill_MLYTLSha.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MLYTLSha_Normal = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill1"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
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
	_M.__all__.Skill_MLYTLSha_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				900
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
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Unique = {
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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
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
						buffeft2
					})
				end

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)
			exec["@time"]({
				3170
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.MLYTLSha_Kick = {
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

				if global.MARKED(_env, "MLYTLSha")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, unit_one in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED_ANY(_env, "Skill_MLYTLSha_Passive", "Skill_MLYTLSha_Passive_Key", "Skill_MLYTLSha_Passive_Key2"), 99)
					end

					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "MLYTLSha_Kick"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Passive = {
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

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local heal = maxHp * 0.2

						global.ApplyHPRecovery_ResultCheck(_env, unit, unit, heal)
					end
				end

				local buff = global.PassiveFunEffectBuff(_env, "MLYTLSha_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"MLYTLSha_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_MLYTLSha_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_MLYTLSha_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end

				local AnaFlag = global.SpecialNumericEffect(_env, "+anaflagcheck", {
					"?Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "AnaFlagCheck",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"CHECK",
						"AnaFlagCheck",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					AnaFlag
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local heal = maxHp * 0.2

					global.ApplyHPRecovery_ResultCheck(_env, _env.unit, _env.unit, heal)
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_MLYTLSha_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_MLYTLSha_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
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
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_MLYTLSha_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Passive_Key = {
		__new__ = function(prototype, externs, global)
			return
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
				local x = global.FriendUnits(_env, global.MARKED(_env, "MLYTLSha"))

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "MLYTLSha")(_env, _env.ACTOR) and x[1] ~= nil then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_MLYTLSha_Passive_Key",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_MLYTLSha_Passive_Key",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_MLYTLSha_Passive_Key2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_MLYTLSha_Passive_Key2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.AddAnim(_env, {
					loop = 1,
					anim = "cisha_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.TARGET)
				})
				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Unique_EX = {
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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
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
						buffeft2
					})
				end

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)
			exec["@time"]({
				3170
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Unique_Awaken = {
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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					this.shieldValue = heal.val + global.UnitPropGetter(_env, "hp")(_env, friendunit) - global.UnitPropGetter(_env, "maxHp")(_env, friendunit)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					if this.shieldValue > 0 and global.SelectBuffCount(_env, friendunit, global.BUFF_MARKED(_env, "CURSE")) == 0 then
						local buffeft1 = global.ShieldEffect(_env, global.min(_env, this.shieldValue, global.UnitPropGetter(_env, "maxHp")(_env, friendunit) * 0.3))

						global.ApplyBuff(_env, friendunit, {
							timing = 0,
							display = "Shield",
							group = "Skill_MLYTLSha_Unique_Awaken",
							duration = 99,
							limit = 1,
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
				end

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)
			exec["@time"]({
				3170
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Unique_SelfAwaken = {
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
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					global.SelfEX_Cure_OneStage_Choice(_env, _env.ACTOR, friendunit, false)

					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					this.shieldValue = heal.val + global.UnitPropGetter(_env, "hp")(_env, friendunit) - global.UnitPropGetter(_env, "maxHp")(_env, friendunit)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal, false, true)

					if this.shieldValue > 0 and global.SelectBuffCount(_env, friendunit, global.BUFF_MARKED(_env, "CURSE")) == 0 then
						local buffeft1 = global.ShieldEffect(_env, global.min(_env, this.shieldValue, global.UnitPropGetter(_env, "maxHp")(_env, friendunit) * 0.3))

						global.ApplyBuff(_env, friendunit, {
							timing = 0,
							display = "Shield",
							group = "Skill_MLYTLSha_Unique_Awaken",
							duration = 99,
							limit = 1,
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
				end

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)
			exec["@time"]({
				3170
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MLYTLSha_Passive_EX = {
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

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local heal = maxHp * 0.2

						global.ApplyHPRecovery_ResultCheck(_env, unit, unit, heal)
					end
				end

				local buff = global.PassiveFunEffectBuff(_env, "MLYTLSha_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"MLYTLSha_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_MLYTLSha_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_MLYTLSha_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_MLYTLSha_Passive2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_MLYTLSha_Passive2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1)

					if global.MASTER(_env, unit) then
						local buffeft3 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "AtkUp",
							group = "Skill_MLYTLSha_Passive_EX",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"SECTSKILL",
								"Skill_MLYTLSha_Passive_EX",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft3
						}, 1)
					end
				end

				local AnaFlag = global.SpecialNumericEffect(_env, "+anaflagcheck", {
					"?Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "AnaFlagCheck",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"CHECK",
						"AnaFlagCheck",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					AnaFlag
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local heal = maxHp * 0.2

					global.ApplyHPRecovery_ResultCheck(_env, _env.unit, _env.unit, heal)
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_MLYTLSha_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_MLYTLSha_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_MLYTLSha_Passive2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_MLYTLSha_Passive2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1)
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
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_MLYTLSha_Passive", "UNDISPELLABLE"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_MLYTLSha_Passive2", "UNDISPELLABLE"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_MLYTLSha_Passive_EX", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}

	return _M
end
