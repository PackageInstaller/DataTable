-- chunkname: @/tmp/or_skill/lua_compile/Skill_HLa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_HLa_Normal = {
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
					-1.15,
					0
				}, 200, "skill1"))
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
	_M.__all__.Skill_HLa_Proud = {
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
					-1.6,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				767
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
	_M.__all__.Skill_HLa_Unique = {
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
				2200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local buffeft = global.MaxHpEffect(_env, -damage.val)

					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"DAMAGERESULT",
							"Skill_HLa_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local enemy = global.EnemyUnits(_env)

				if #enemy > this.Num then
					local kill = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian")), "<", global.UnitPropGetter(_env, "hp")), 1, 1)

					if kill[1] then
						global.AnimForTrgt(_env, kill[1], {
							loop = 1,
							anim = "main_zhanshatexiao",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
						global.KillTarget(_env, kill[1])
						global.ActivateGlobalTrigger(_env, kill[1], "UNIT_BEKILLED", {
							hurt = {
								val = 0,
								deadly = true,
								eft = 0
							},
							actor = _env.ACTOR
						})
					end
				end
			end)
			exec["@time"]({
				2850
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLa_Passive = {
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

			_env.card = externs.card

			assert(_env.card ~= nil, "External variable `card` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buff = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.unit), _env.card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"Skill_HLa_Passive_Check"
						}
					}, {
						buff
					}, "week_shoupaitishi")
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and (_env.isRevive == true or global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "CARDBUFF", "Skill_HLa_Passive_Check")) > 0) then
					local buffeft = global.MaxHpEffect(_env, -maxhp * this.MaxhpReduce)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"Skill_HLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					if _env.isRevive == true then
						global.ApplyRPDamage(_env, _env.unit, this.RpReduce)
					end

					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "CARDBUFF", "Skill_HLa_Passive_Check"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.isTransform = externs.isTransform

			assert(_env.isTransform ~= nil, "External variable `isTransform` is not provided.")
			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

				if _env.isTransform == true and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.MaxHpEffect(_env, -maxhp * this.MaxhpReduce)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"Skill_HLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
					global.ApplyRPDamage(_env, _env.unit, this.RpReduce)
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.hurt.deadly and _env.actor == _env.ACTOR then
					local buffeft = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_HLa_Passive",
						duration = 99,
						limit = 10,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"DISPELLABLE",
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
	_M.__all__.Skill_HLa_Proud_EX = {
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
					-1.6,
					0
				}, 200, "skill2"))
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buffeft = global.MaxHpEffect(_env, -damage.val)

				global.ApplyBuff(_env, _env.TARGET, {
					timing = 0,
					duration = 99,
					display = "MaxHpDown",
					tags = {
						"DEBUFF",
						"MAXHPDOWN",
						"DAMAGERESULT",
						"Skill_HLa_Proud",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLa_Unique_EX = {
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

				local buff = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_HLa_Unique_EX"
					}
				}, {
					buff
				})
			end)
			exec["@time"]({
				2200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local buffeft = global.MaxHpEffect(_env, -damage.val)

					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"DAMAGERESULT",
							"Skill_HLa_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local enemy = global.EnemyUnits(_env)

				if #enemy > this.Num then
					local kill = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian")), "<", global.UnitPropGetter(_env, "hp")), 1, 1)

					if kill[1] then
						global.AnimForTrgt(_env, kill[1], {
							loop = 1,
							anim = "main_zhanshatexiao",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
						global.KillTarget(_env, kill[1])
						global.ActivateGlobalTrigger(_env, kill[1], "UNIT_BEKILLED", {
							hurt = {
								val = 0,
								deadly = true,
								eft = 0
							},
							actor = _env.ACTOR
						})
					end
				end
			end)
			exec["@time"]({
				2850
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_HLa_Unique_EX"), 99)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HLa_Passive_EX = {
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

			_env.card = externs.card

			assert(_env.card ~= nil, "External variable `card` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buff = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.unit), _env.card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"Skill_HLa_Passive_Check"
						}
					}, {
						buff
					}, "week_shoupaitishi")
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and (_env.isRevive == true or global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "CARDBUFF", "Skill_HLa_Passive_Check")) > 0) then
					local buffeft = global.MaxHpEffect(_env, -maxhp * this.MaxhpReduce)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"Skill_HLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					if _env.isRevive == true then
						global.ApplyRPDamage(_env, _env.unit, this.RpReduce)
					end

					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "CARDBUFF", "Skill_HLa_Passive_Check"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.isTransform = externs.isTransform

			assert(_env.isTransform ~= nil, "External variable `isTransform` is not provided.")
			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

				if _env.isTransform == true and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.MaxHpEffect(_env, -maxhp * this.MaxhpReduce)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"Skill_HLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
					global.ApplyRPDamage(_env, _env.unit, this.RpReduce)
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.hurt.deadly and _env.actor == _env.ACTOR then
					local buffeft = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_HLa_Passive",
						duration = 99,
						limit = 10,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"DISPELLABLE",
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
