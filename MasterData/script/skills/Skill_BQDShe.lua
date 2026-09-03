-- chunkname: @/tmp/or_skill/lua_compile/Skill_BQDShe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BQDShe_Normal = {
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
					-1.3,
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
	_M.__all__.Skill_BQDShe_Proud = {
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
	_M.__all__.Skill_BQDShe_Proud_EX = {
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
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 1,
					display = "CritRateUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"CRITRATEUP",
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
	_M.__all__.Skill_BQDShe_Unique = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

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
				global.HarmTargetView(_env, _env.units)

				if global.ProbTest(_env, 0.6) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
					global.AddStatus(_env, _env.ACTOR, "Drunk")
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					for _, unit in global.__iter__(_env.units) do
						local buffeft2 = global.Daze(_env)

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
							buffeft2
						}, 1, 0)
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local buffeft3 = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						display = "UnHurtRateDown",
						group = "Skill_SSQXin_Unique",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"UNHURTRATE",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft4 = global.Daze(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.ACTOR, {
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
						buffeft4
					}, 1, 0)
				end

				global.RemoveStatus(_env, _env.ACTOR, "Drunk")
			end)

			return _env
		end
	}
	_M.__all__.Skill_BQDShe_Unique_EX = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

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
				global.HarmTargetView(_env, _env.units)

				if global.ProbTest(_env, 0.6) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
					global.AddStatus(_env, _env.ACTOR, "Drunk")
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					for _, unit in global.__iter__(_env.units) do
						local buffeft2 = global.Daze(_env)

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
							buffeft2
						}, 1, 0)
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local buffeft3 = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						display = "UnHurtRateDown",
						group = "Skill_SSQXin_Unique",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"UNHURTRATE",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft4 = global.Daze(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.ACTOR, {
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
						buffeft4
					}, 1, 0)
				end

				global.RemoveStatus(_env, _env.ACTOR, "Drunk")
			end)

			return _env
		end
	}
	_M.__all__.Skill_BQDShe_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "DAZE") then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.3)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						display = "UnHurtRateUp",
						group = "Skill_BQDShe_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_BQDShe_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
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
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ANY(_env, "DAZE"))
				local count2 = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_BQDShe_Passive"))

				if count == 0 and count2 ~= 0 and global.ProbTest(_env, 1) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_BQDShe_Passive"))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BQDShe_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "DAZE") then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.3)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						display = "UnHurtRateUp",
						group = "Skill_BQDShe_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_BQDShe_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
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
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ANY(_env, "DAZE"))
				local count2 = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_BQDShe_Passive_EX"))

				if count == 0 and count2 ~= 0 and global.ProbTest(_env, 1) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_BQDShe_Passive_EX"))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BQDShe_Passive_Key = {
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
				local Window = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SSQXin"))
				local Hero = global.FriendUnits(_env, global.MARKED(_env, "SSQXin"))

				if Window[1] ~= nil then
					for _, unit in global.__iter__(Window) do
						local buffeft1 = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, 0.8)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), unit, {
							timing = 0,
							display = "UnHurtRateDown",
							group = "Skill_BQDShe_Passive_Key_1",
							duration = 99,
							limit = 1,
							tags = {
								"CARDBUFF",
								"Skill_BQDShe_Passive_Key"
							}
						}, {
							buffeft1
						})

						local buffeft2 = global.NumericEffect(_env, "-hurtrate", {
							"+Normal",
							"+Normal"
						}, 0.8)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), unit, {
							timing = 0,
							display = "HurtRateDown",
							group = "Skill_BQDShe_Passive_Key_2",
							duration = 99,
							limit = 1,
							tags = {
								"CARDBUFF",
								"Skill_BQDShe_Passive_Key"
							}
						}, {
							buffeft2
						})
					end
				end

				if Hero[1] ~= nil then
					for _, unit2 in global.__iter__(Hero) do
						local buffeft3 = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, 0.8)
						local buffeft4 = global.NumericEffect(_env, "-hurtrate", {
							"+Normal",
							"+Normal"
						}, 0.8)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit2, {
							timing = 2,
							display = "UnHurtRateDown",
							group = "Skill_BQDShe_Passive_Key_1",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"Skill_BQDShe_Passive_Key"
							}
						}, {
							buffeft3
						}, 1)
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit2, {
							timing = 2,
							display = "HurtRateDown",
							group = "Skill_BQDShe_Passive_Key_2",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"Skill_BQDShe_Passive_Key"
							}
						}, {
							buffeft4
						}, 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BQDShe_Unique_Awaken = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

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
				global.HarmTargetView(_env, _env.units)

				if global.ProbTest(_env, 0.6) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
					global.AddStatus(_env, _env.ACTOR, "Drunk")
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					for _, unit in global.__iter__(_env.units) do
						local buffeft2 = global.Daze(_env)

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
							buffeft2
						}, 1, 0)
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local buffeft3 = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.3)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 2,
						display = "UnHurtRateDown",
						group = "Skill_SSQXin_Unique",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"UNHURTRATE",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.INSTATUS(_env, "Drunk")(_env, _env.ACTOR) then
					local buffeft4 = global.Daze(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.ACTOR, {
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
						buffeft4
					}, 1, 0)
				end

				global.RemoveStatus(_env, _env.ACTOR, "Drunk")
			end)

			return _env
		end
	}

	return _M
end
