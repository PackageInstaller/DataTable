-- chunkname: @/tmp/or_skill/lua_compile/Skill_HSheng.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_HSheng_Normal = {
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
				634
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
	_M.__all__.Skill_HSheng_Proud = {
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
					-1.7,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				334
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
						"DEFWEAKENUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					267,
					533,
					767
				}, global.SplitValue(_env, damage, {
					0.25,
					0.25,
					0.25,
					0.25
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Unique = {
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
				2867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.Daze(_env)

				for _, unit in global.__iter__(global.RandomN(_env, this.LeastDazeNum, global.EnemyUnits(_env))) do
					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						duration = 1,
						display = "Daze",
						tags = {
							"STATUS",
							"DEBUFF",
							"DAZE",
							"ABNORMAL",
							"DISPELLABLE",
							"HSheng_Unique"
						}
					}, {
						buffeft
					}, 1, 0)
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, unit, "DEFENDER")

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "HSheng_Unique")) == 0 then
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
									"DISPELLABLE",
									"HSheng_Unique"
								}
							}, {
								buffeft
							}, 1, 0)
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3034
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Passive = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.ACTOR) - global.ONESELF(_env, _env.ACTOR))) do
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
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
				local flag = 0

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.unit ~= _env.ACTOR then
					for _, unit1 in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.unit))) do
						if unit1 == _env.ACTOR then
							flag = 1
						end
					end
				end

				if flag == 1 then
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, _env.unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
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
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNHURTRATEUP", "Skill_HSheng_Passive"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Proud_EX = {
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
					-1.7,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				334
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
						"DEFWEAKENUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					267,
					533,
					767
				}, global.SplitValue(_env, damage, {
					0.25,
					0.25,
					0.25,
					0.25
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Unique_EX = {
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
				2867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.Daze(_env)

				for _, unit in global.__iter__(global.RandomN(_env, this.LeastDazeNum, global.EnemyUnits(_env))) do
					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						duration = 1,
						display = "Daze",
						tags = {
							"STATUS",
							"DEBUFF",
							"DAZE",
							"ABNORMAL",
							"DISPELLABLE",
							"HSheng_Unique"
						}
					}, {
						buffeft
					}, 1, 0)
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, unit, "DEFENDER")

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "HSheng_Unique")) == 0 then
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
									"DISPELLABLE",
									"HSheng_Unique"
								}
							}, {
								buffeft
							}, 1, 0)
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3034
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Passive_EX = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.ACTOR) - global.ONESELF(_env, _env.ACTOR))) do
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
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
				local flag = 0

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.unit ~= _env.ACTOR then
					for _, unit1 in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.unit))) do
						if unit1 == _env.ACTOR then
							flag = 1
						end
					end
				end

				if flag == 1 then
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, _env.unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
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
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNHURTRATEUP", "Skill_HSheng_Passive"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HShengg_Passive_SelfAwaken = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.ACTOR) - global.ONESELF(_env, _env.ACTOR))) do
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1)
					end
				end

				global.SelfEX_Support_OneStage_treasury(_env, _env.ACTOR, 2)
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
				local flag = 0

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.unit ~= _env.ACTOR then
					for _, unit1 in global.__iter__(global.FriendUnits(_env, global.ROW_OF(_env, _env.unit))) do
						if unit1 == _env.ACTOR then
							flag = 1
						end
					end
				end

				if flag == 1 then
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buff_FEMSi = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor + this.ExUnHurtRateFactor)

					if global.MARKED(_env, "FEMSi")(_env, _env.unit) then
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_FEMSi
						}, 1)
					else
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"Skill_HSheng_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
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
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNHURTRATEUP", "Skill_HSheng_Passive"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HSheng_Unique_Awaken = {
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
				2867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.Daze(_env)

				for _, unit in global.__iter__(global.RandomN(_env, this.LeastDazeNum, global.EnemyUnits(_env))) do
					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						duration = 1,
						display = "Daze",
						tags = {
							"STATUS",
							"DEBUFF",
							"DAZE",
							"ABNORMAL",
							"DISPELLABLE",
							"HSheng_Unique"
						}
					}, {
						buffeft
					}, 1, 0)

					if global.MASTER(_env, unit) == false then
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
								"Skill_HSheng_Unique_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff_murder
						})

						local buff = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateDown",
							group = "Skill_HSheng_Unique_Awaken",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"DEBUFF",
								"UNHURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, unit, "DEFENDER")

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "HSheng_Unique")) == 0 then
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
									"DISPELLABLE",
									"HSheng_Unique"
								}
							}, {
								buffeft
							}, 1, 0)
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3034
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
