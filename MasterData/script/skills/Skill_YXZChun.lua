-- chunkname: @/tmp/or_skill/lua_compile/Skill_YXZChun.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YXZChun_Normal = {
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
	_M.__all__.Skill_YXZChun_Proud = {
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
					-1.4,
					0
				}, 100, "skill2"))
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
	_M.__all__.Skill_YXZChun_Unique = {
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
					-1.5,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

						global.ApplyHPRecovery(_env, unit, maxHp * this.RateFactor)
						global.ApplyRPRecovery(_env, unit, this.RageFactor)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Passive = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						num = num + 1
					end
				end

				if num < 2 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local deta_hp = global.max(_env, 0, maxHp * this.summonFactorHp - atk * 10)
					local SummonedYXZChun = global.Summon(_env, _env.ACTOR, "SummonedYXZChun", this.summonFactor, {
						-deta_hp,
						0,
						0
					}, {
						5,
						4,
						6,
						8,
						7,
						9,
						2,
						1,
						3
					})

					if SummonedYXZChun then
						global.AddStatus(_env, SummonedYXZChun, "SummonedYXZChun")

						local buffeft1 = global.SpecialNumericEffect(_env, "+TigerDamageRate", {
							"?Normal"
						}, this.DmgRateFactor)

						global.ApplyBuff(_env, SummonedYXZChun, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YXZChun_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SummonedYXZChun")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.RageFactor)

					if global.SelectBuffCount(_env, _env.unit, "Skill_YXZChun_Passive") == 0 then
						global.ApplyRPDamage(_env, _env.unit, this.RageFactor)

						local buffeft1 = global.SpecialNumericEffect(_env, "+TigerDamageRate", {
							"?Normal"
						}, this.DmgRateFactor)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YXZChun_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YXZChun_Passive_Key", {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "Skill_YXZChun_Passive_Key_Flag",
						timing = 0,
						limit = 1,
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_YXZChun_Passive_Key"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Tiger_Normal = {
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
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						local buff = global.Diligent(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YXZChun_Unique",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
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

				global.AddStatus(_env, _env.ACTOR, "SummonedYXZChun")
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Tiger_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectHalfBlack", 1850, false)
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end

				global.DelayCall(_env, 1200, global.ShakeScreen, {
					Id = 4,
					duration = 60,
					enhance = 5
				})
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local MyMaster = global.GetSummoner(_env, _env.ACTOR)
				local DamageFactor = global.SpecialPropGetter(_env, "TigerDamageRate")(_env, _env.ACTOR)

				if DamageFactor == 0 then
					DamageFactor = global.SpecialPropGetter(_env, "TigerDamageRate")(_env, MyMaster)
				end

				global.print(_env, DamageFactor, "DamageFactor======")

				if global.FriendMaster(_env) then
					if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_YXZChun_Passive_Key")) > 0 then
						for _, unit in global.__iter__(global.EnemyUnits(_env)) do
							global.ApplyStatusEffect(_env, _env.ACTOR, unit)
							global.ApplyRPEffect(_env, _env.ACTOR, unit)
							global.ApplyRealDamage(_env, _env.ACTOR, unit, 2, 1, DamageFactor)
						end
					else
						for _, unit in global.__iter__(global.EnemyUnits(_env)) do
							global.ApplyStatusEffect(_env, _env.ACTOR, unit)
							global.ApplyRPEffect(_env, _env.ACTOR, unit)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
								1,
								DamageFactor,
								0
							})

							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						end
					end
				else
					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							DamageFactor,
							0
						})

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Proud_EX = {
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
					-1.4,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						local buff = global.Diligent(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YXZChun_Unique",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end
				end

				global.DiligentRound(_env, 100)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Unique_EX = {
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
					-1.5,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

						global.ApplyHPRecovery(_env, unit, maxHp * this.RateFactor)
						global.ApplyRPRecovery(_env, unit, this.RageFactor)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YXZChun_Passive_EX = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedYXZChun")(_env, unit) then
						num = num + 1
					end
				end

				if num < 2 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local deta_hp = global.max(_env, 0, maxHp * this.summonFactorHp - atk * 10)
					local SummonedYXZChun = global.Summon(_env, _env.ACTOR, "SummonedYXZChun", this.summonFactor, {
						-deta_hp,
						0,
						0
					}, {
						5,
						4,
						6,
						8,
						7,
						9,
						2,
						1,
						3
					})

					if SummonedYXZChun then
						global.AddStatus(_env, SummonedYXZChun, "SummonedYXZChun")

						local buffeft1 = global.SpecialNumericEffect(_env, "+TigerDamageRate", {
							"?Normal"
						}, this.DmgRateFactor)

						global.ApplyBuff(_env, SummonedYXZChun, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YXZChun_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SummonedYXZChun")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.RageFactor)
					global.CloneBuff(_env, _env.unit, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "BUFF"))

					if global.SelectBuffCount(_env, _env.unit, "Skill_YXZChun_Passive") == 0 then
						global.ApplyRPDamage(_env, _env.unit, this.RageFactor)

						local buffeft1 = global.SpecialNumericEffect(_env, "+TigerDamageRate", {
							"?Normal"
						}, this.DmgRateFactor)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YXZChun_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}

	return _M
end
