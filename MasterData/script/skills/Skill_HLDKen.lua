-- chunkname: @/tmp/or_skill/lua_compile/Skill_HLDKen.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_HLDKen_Normal = {
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
					-2.1,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
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
	_M.__all__.Skill_HLDKen_Proud = {
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
					-2.1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				867
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
	_M.__all__.Skill_HLDKen_Unique = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS + global.SUMMONS - global.ONESELF(_env, _env.ACTOR))) do
					global.ApplyRPRecovery(_env, unit, this.RageFactor)
				end

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if (global.PETS + global.SUMMONS - global.MASTER)(_env, unit) then
						local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
							"+Normal",
							"+Normal"
						}, this.ExSkillRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							display = "SkillRateUp",
							group = "Skill_HLDKen_Unique",
							duration = 3,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"Skill_HLDKen_Unique",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})

						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft3 = global.Diligent(_env)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1)
					end
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DiligentRound(_env)
			end)
			exec["@time"]({
				3160
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLDKen_Passive = {
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
				local num = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.INSTATUS(_env, "SummonedHLDKen")(_env, unit) then
						num = num + 1
					end
				end

				if num < 1 then
					local SummonedHLDKen = global.SummonEnemy(_env, _env.ACTOR, "SummonedHLDKen", this.summonFactor, nil, {
						1,
						3,
						4,
						6,
						7,
						9,
						2,
						5
					})

					if SummonedHLDKen then
						global.ForbidenRevive(_env, SummonedHLDKen, true)
						global.AddStatus(_env, SummonedHLDKen, "SummonedHLDKen")

						local buff1 = global.SpecialNumericEffect(_env, "+Skill_HLDKen_xbai_Passive_fbihpradio", {
							"?Normal"
						}, global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * this.summonFactorHp)

						global.ApplyBuff(_env, global.FriendField(_env), {
							duration = 99,
							group = "Skill_HLDKen_xbai_Passive_fbihpradio",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"Skill_HLDKen_xbai_Passive_fbihpradio",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1
						})

						local buff2 = global.SpecialNumericEffect(_env, "+Skill_HLDKen_xbai_Passive_radio", {
							"?Normal"
						}, this.MaxDamageRadio)

						global.ApplyBuff(_env, global.FriendField(_env), {
							duration = 99,
							group = "Skill_HLDKen_xbai_Passive_radio",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"Skill_HLDKen_xbai_Passive_radio",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff2
						})

						local buff_skill = global.PassiveFunEffectBuff(_env, "HLDKen_xbai_Passive", {
							RageFactor = this.RageFactor
						})

						global.ApplyBuff(_env, SummonedHLDKen, {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_HLDKen_xbai_Passive"
							}
						}, {
							buff_skill
						})
					end
				end

				if num >= 1 then
					local buffeft3 = global.Stealth(_env, 0.8)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"HLDKen_xbai_Passive_STEALTH",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"STEALTH",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	function _M.__all__.SNGLSi_Damage_Copy(_env, copytarget, damage, ratio)
		local this, global = _env.this, _env.global
		local copydamage = damage
		local fbihpradio = global.SpecialPropGetter(_env, "Skill_HLDKen_xbai_Passive_fbihpradio")(_env, global.FriendField(_env))

		if damage.val > global.UnitPropGetter(_env, "maxHp")(_env, copytarget) * ratio then
			copydamage = global.UnitPropGetter(_env, "maxHp")(_env, copytarget) * ratio
		end

		global.ApplyHPDamage(_env, copytarget, (fbihpradio ~= nil and fbihpradio < damage.val or nil) and fbihpradio)
	end

	_M.__all__.HLDKen_xbai_Passive = {
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

				if global.INSTATUS(_env, "SummonedHLDKen")(_env, _env.ACTOR) then
					if global.FriendMaster(_env) then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							display = "HPLink",
							tags = {
								"HLDKen_xbai_Passive_HPlink",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})

						local buff2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendMaster(_env), {
							timing = 0,
							duration = 99,
							display = "HPLink",
							tags = {
								"HLDKen_xbai_Passive_HPlink",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff2
						})
					end

					global.ForbidenRevive(_env, _env.ACTOR, true)

					local buffeft1 = global.Daze(_env)
					local buffeft2 = global.HPRecoverRatioEffect(_env, -999)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"DAZE_HLDKen_xbai",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1,
						buffeft2
					})
					global.print(_env, "小白的召唤者===", global.GetSummoner(_env, _env.ACTOR))

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MARKED(_env, "HLDKen"))) do
						local buff = global.PassiveFunEffectBuff(_env, "HLDKen_xbai_Passive_Kick", {})

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_HLDKen_xbai_Passive_Kick"
							}
						}, {
							buff
						})

						local buffeft3 = global.Stealth(_env, 0.8)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"HLDKen_xbai_Passive_STEALTH",
								"STATUS",
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"STEALTH",
								"UNSTEALABLE"
							}
						}, {
							buffeft3
						}, 1, 0)
					end
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

				if global.EnemyMaster(_env) then
					global.ApplyRPRecovery(_env, global.EnemyMaster(_env), this.RageFactor)
				end

				if global.FriendMaster(_env) then
					global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_HPlink", "UNDISPELLABLE"), 99)
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_STEALTH", "UNDISPELLABLE"), 99)
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

				if global.INSTATUS(_env, "SummonedHLDKen")(_env, _env.unit) and _env.unit == _env.ACTOR then
					if global.FriendMaster(_env) then
						global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_HPlink", "UNDISPELLABLE"), 99)
					end

					for _, unit_one in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_STEALTH", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.HLDKen_xbai_Passive_Kick = {
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

				if global.INSTATUS(_env, "SummonedHLDKen")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					if global.FriendMaster(_env) then
						global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_HPlink", "UNDISPELLABLE"), 99)
					end

					for _, unit_one in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED_ALL(_env, "HLDKen_xbai_Passive_STEALTH", "UNDISPELLABLE"), 99)
					end

					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "HLDKen_xbai_Passive_Kick"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLDKen_Proud_EX = {
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
					-2.1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if not global.MARKED(_env, "SummonedNian")(_env, _env.TARGET) and (global.PETS + global.SUMMONS - global.MASTER)(_env, _env.TARGET) then
					local buffeft1 = global.MaxHpEffect(_env, -damage.val)

					global.ApplyBuff(_env, _env.TARGET, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"DEBUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLDKen_Unique_EX = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS + global.SUMMONS - global.ONESELF(_env, _env.ACTOR))) do
					global.ApplyRPRecovery(_env, unit, this.RageFactor)
				end

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if (global.PETS + global.SUMMONS - global.MASTER)(_env, unit) then
						local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
							"+Normal",
							"+Normal"
						}, this.ExSkillRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							display = "SkillRateUp",
							group = "Skill_HLDKen_Unique",
							duration = 3,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"Skill_HLDKen_Unique",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})

						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft3 = global.Diligent(_env)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1)
					end
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DiligentRound(_env)
			end)
			exec["@time"]({
				3160
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLDKen_Passive_EX = {
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
				local num = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.INSTATUS(_env, "SummonedHLDKen")(_env, unit) then
						num = num + 1
					end
				end

				if num < 1 then
					local SummonedHLDKen = global.SummonEnemy(_env, _env.ACTOR, "SummonedHLDKen", this.summonFactor, nil, {
						1,
						3,
						4,
						6,
						7,
						9,
						2,
						5
					})

					if SummonedHLDKen then
						global.ForbidenRevive(_env, SummonedHLDKen, true)
						global.AddStatus(_env, SummonedHLDKen, "SummonedHLDKen")

						local buff1 = global.SpecialNumericEffect(_env, "+Skill_HLDKen_xbai_Passive_fbihpradio", {
							"?Normal"
						}, global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * this.summonFactorHp)

						global.ApplyBuff(_env, global.FriendField(_env), {
							duration = 99,
							group = "Skill_HLDKen_xbai_Passive_fbihpradio",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"Skill_HLDKen_xbai_Passive_fbihpradio",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1
						})

						local buff2 = global.SpecialNumericEffect(_env, "+Skill_HLDKen_xbai_Passive_radio", {
							"?Normal"
						}, this.MaxDamageRadio)

						global.ApplyBuff(_env, global.FriendField(_env), {
							duration = 99,
							group = "Skill_HLDKen_xbai_Passive_radio",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"Skill_HLDKen_xbai_Passive_radio",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff2
						})

						local buff_skill = global.PassiveFunEffectBuff(_env, "HLDKen_xbai_Passive", {
							RageFactor = this.RageFactor
						})

						global.ApplyBuff(_env, SummonedHLDKen, {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_HLDKen_xbai_Passive"
							}
						}, {
							buff_skill
						})
					end
				end

				if num >= 1 then
					local buffeft3 = global.Stealth(_env, 0.8)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"HLDKen_xbai_Passive_STEALTH",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"STEALTH",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, global.FriendField(_env), "Skill_HLDKen_Passive_EX_Death") < 1 then
					if global.EnemyMaster(_env) then
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, global.EnemyMaster(_env), 1000)
					end

					global.ApplyEnergyDamage(_env, global.GetOwner(_env, global.EnemyField(_env)), 30)
				end

				local buff = global.SpecialNumericEffect(_env, "+Skill_HLDKen_Passive_EX_Death", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_HLDKen_Passive_EX_Death"
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
