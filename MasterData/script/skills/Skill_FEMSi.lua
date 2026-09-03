-- chunkname: @/tmp/or_skill/lua_compile/Skill_FEMSi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_FEMSi_Normal = {
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
				534
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
	_M.__all__.Skill_FEMSi_Proud = {
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
					-1.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_OF(_env, _env.TARGET) * global.COL_OF(_env, _env.TARGET) * global.NEIGHBORS_OF(_env, _env.TARGET) - global.ONESELF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target1")
				end
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET) + global.BACK_OF(_env, _env.TARGET) * global.COL_OF(_env, _env.TARGET) * global.NEIGHBORS_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "MURDERER")) > 0 then
						damage.val = damage.val * this.murderer_rate
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Passive = {
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

			_env.hurt = externs.hurt

			assert(_env.hurt ~= nil, "External variable `hurt` is not provided.")

			_env.actor = externs.actor

			assert(_env.actor ~= nil, "External variable `actor` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.hurt.deadly and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.actor, {
						timing = 0,
						display = "Murderer",
						group = "FEMSi_MURDERER",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"MURDERER",
							"ABNORMAL",
							"Skill_FEMSi_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_murder
					})
					global.ApplyRPRecovery(_env, _env.ACTOR, this.Rage)
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

				if global.MARKED(_env, "KTSJKe")(_env, _env.unit) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "Murderer",
						group = "FEMSi_MURDERER",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"MURDERER",
							"ABNORMAL",
							"Skill_FEMSi_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_murder
					})
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.MARKED(_env, "KTSJKe")(_env, unit) then
						local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "Murderer",
							group = "FEMSi_MURDERER",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"MURDERER",
								"ABNORMAL",
								"Skill_FEMSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_murder
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Proud_EX = {
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
					-1.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_OF(_env, _env.TARGET) * global.COL_OF(_env, _env.TARGET) * global.NEIGHBORS_OF(_env, _env.TARGET) - global.ONESELF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target1")
				end
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET) + global.BACK_OF(_env, _env.TARGET) * global.COL_OF(_env, _env.TARGET) * global.NEIGHBORS_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					display = "Shield",
					group = "FEMSi_Proud_EX",
					duration = 2,
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
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "MURDERER")) > 0 then
						damage.val = damage.val * this.murderer_rate
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Passive_EX = {
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

			_env.hurt = externs.hurt

			assert(_env.hurt ~= nil, "External variable `hurt` is not provided.")

			_env.actor = externs.actor

			assert(_env.actor ~= nil, "External variable `actor` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.hurt.deadly and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.actor, {
						timing = 0,
						display = "Murderer",
						group = "FEMSi_MURDERER",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"MURDERER",
							"ABNORMAL",
							"Skill_FEMSi_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_murder
					})
					global.ApplyRPRecovery(_env, _env.ACTOR, this.Rage)
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

				if global.MARKED(_env, "KTSJKe")(_env, _env.unit) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "Murderer",
						group = "FEMSi_MURDERER",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"MURDERER",
							"ABNORMAL",
							"Skill_FEMSi_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_murder
					})
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					if global.MARKED(_env, "KTSJKe")(_env, unit) then
						local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "Murderer",
							group = "FEMSi_MURDERER",
							duration = 99,
							limit = 1,
							tags = {
								"STATUS",
								"MURDERER",
								"ABNORMAL",
								"Skill_FEMSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_murder
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FEMSi_Unique_Awaken = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "MURDERER")) == 0 then
						local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
						local buffeft1 = global.HPPeriodDamage(_env, "Burning", attacker.atk * this.BurningRateFactor)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 1,
							display = "Burning",
							group = "Burning",
							duration = 3,
							limit = 99,
							tags = {
								"STATUS",
								"DEBUFF",
								"BURNING",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "MURDERER")) > 0 then
						damage.val = damage.val * this.murderer_rate
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				for _, unit in global.__iter__(_env.units) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "MURDERER")) > 0 and global.IsAlive(_env, unit) then
						flag = 1
					end
				end

				if flag == 1 then
					local buff_murder = global.SpecialNumericEffect(_env, "+murder", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.EnemyMaster(_env), {
						timing = 0,
						display = "Murderer",
						group = "FEMSi_MURDERER",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"MURDERER",
							"ABNORMAL",
							"Skill_FEMSi_Unique_Awaken",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_murder
					})

					local buffeft = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.RageFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, global.EnemyMaster(_env), {
						timing = 1,
						display = "AngerRateDown",
						group = "FEMSi_MURDERER_ANGERRATEDOWN",
						duration = 3,
						limit = 3,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_FEMSi_Unique_RAGE",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
