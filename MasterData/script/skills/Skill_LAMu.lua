-- chunkname: @/tmp/or_skill/lua_compile/Skill_LAMu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LAMu_Normal = {
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
					-2,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				667
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
	_M.__all__.Skill_LAMu_Proud = {
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

			_env.units = global.EnemyUnits(_env)

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				967
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local unitsCount = #_env.units
				local allDamage = 0

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					allDamage = allDamage + damage.val

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local avgDmg = allDamage / unitsCount * global.SpecialPropGetter(_env, "Skill_LAMu_Passive_dmgPst")(_env, global.FriendField(_env))
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_val", {
					"+Normal",
					"+Normal"
				}, avgDmg)
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.TARGET))

				for _, card in global.__iter__(cards) do
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"BUFF",
							"Skill_LAMu_Dmg",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, "week_shoupaitishi")
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Proud_EX = {
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

			_env.units = global.EnemyUnits(_env)

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				967
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local unitsCount = #_env.units
				local allDamage = 0
				local i = 1

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					allDamage = allDamage + damage.val

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))[1] then
						damage.val = this.dmgPst * damage.val

						for _, unit2 in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))) do
							global.DelayCall(_env, i * 40, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit2, damage)
							global.DelayCall(_env, i * 40, global.AnimForTrgt, unit2, {
								loop = 1,
								anim = "main_lamufengxian",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.45
								}
							})
						end
					end

					i = i + 1
				end

				local avgDmg = allDamage / unitsCount * global.SpecialPropGetter(_env, "Skill_LAMu_Passive_dmgPst")(_env, global.FriendField(_env))
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_val", {
					"+Normal",
					"+Normal"
				}, avgDmg)
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.TARGET))

				for _, card in global.__iter__(cards) do
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.TARGET), card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"BUFF",
							"Skill_LAMu_Dmg",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, "week_shoupaitishi")
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local unitsCount = #_env.units
				local allDamage = 0
				local i = 1

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					allDamage = allDamage + damage.val

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))[1] then
						damage.val = this.dmgPst * damage.val

						for _, unit2 in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))) do
							global.DelayCall(_env, i * 40, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit2, damage)
							global.DelayCall(_env, i * 40, global.AnimForTrgt, unit2, {
								loop = 1,
								anim = "main_lamufengxian",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.45
								}
							})
						end
					end

					i = i + 1
				end

				local avgDmg = allDamage / unitsCount * global.SpecialPropGetter(_env, "Skill_LAMu_Passive_dmgPst")(_env, global.FriendField(_env))
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_val", {
					"+Normal",
					"+Normal"
				}, avgDmg)
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.TARGET))

				for _, card in global.__iter__(cards) do
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.TARGET), card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"BUFF",
							"Skill_LAMu_Dmg",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, "week_shoupaitishi")
				end
			end)
			exec["@time"]({
				2650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local unitsCount = #_env.units
				local allDamage = 0
				local i = 1

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					allDamage = allDamage + damage.val

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))[1] then
						damage.val = this.dmgPst * damage.val

						for _, unit2 in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, unit))) do
							global.DelayCall(_env, i * 40, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit2, damage)
							global.DelayCall(_env, i * 40, global.AnimForTrgt, unit2, {
								loop = 1,
								anim = "main_lamufengxian",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.45
								}
							})
						end
					end

					i = i + 1
				end

				local avgDmg = allDamage / unitsCount * global.SpecialPropGetter(_env, "Skill_LAMu_Passive_dmgPst")(_env, global.FriendField(_env))
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_val", {
					"+Normal",
					"+Normal"
				}, avgDmg)
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.TARGET))

				for _, card in global.__iter__(cards) do
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.TARGET), card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"BUFF",
							"Skill_LAMu_Dmg",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, "week_shoupaitishi")
				end
			end)
			exec["@time"]({
				2650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Passive = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_dmgPst", {
					"?Normal"
				}, this.dmgPst)

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 99,
					group = "Skill_LAMu_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"Skill_LAMu_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
				global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "Skill_LAMu_Passive_Skill", "UNDISPELLABLE", "UNSTEALABLE"), 99)
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
				local buffeft1 = global.PassiveFunEffectBuff(_env, "Skill_LAMu_Dmg", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_LAMu_Passive_Skill",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffCount = global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Skill_LAMu_Dmg"))

					if buffCount > 0 then
						global.ApplyHPReduce(_env, _env.unit, global.SpecialPropGetter(_env, "Skill_LAMu_Passive_val")(_env, _env.unit))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Passive_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LAMu_Passive_dmgPst", {
					"?Normal"
				}, this.dmgPst)

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 99,
					group = "Skill_LAMu_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"Skill_LAMu_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
				global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "Skill_LAMu_Passive_Skill", "UNDISPELLABLE", "UNSTEALABLE"), 99)
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
				local buffeft1 = global.PassiveFunEffectBuff(_env, "Skill_LAMu_Dmg", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_LAMu_Passive_Skill",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffCount = global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Skill_LAMu_Dmg"))

					if buffCount > 0 then
						global.ApplyHPReduce(_env, _env.unit, global.SpecialPropGetter(_env, "Skill_LAMu_Passive_val")(_env, _env.unit))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Dmg = {
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffCount = global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Skill_LAMu_Dmg"))

					if buffCount > 0 then
						global.ApplyHPReduce(_env, _env.unit, global.SpecialPropGetter(_env, "Skill_LAMu_Passive_val")(_env, _env.unit))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LAMu_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
						if (global.MARKED(_env, "LAMu")(_env, _env.unit) or global.MARKED(_env, "LEIMu")(_env, _env.unit)) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
							local units1 = global.FriendUnits(_env, global.MARKED(_env, "LEIMu"))
							local units2 = global.FriendUnits(_env, global.MARKED(_env, "LAMu"))

							if global.MARKED(_env, "LAMu")(_env, _env.unit) and units1[1] then
								global.ApplyRPRecovery(_env, units1[1], this.RPFactor)
							end

							if global.MARKED(_env, "LEIMu")(_env, _env.unit) and units2[1] then
								global.ApplyRPRecovery(_env, units2[1], this.RPFactor)
							end
						end
					end
				end
			end)

			return _env
		end
	}

	return _M
end
