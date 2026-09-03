-- chunkname: @/tmp/or_skill/lua_compile/Skill_MZu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MZu_Normal = {
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
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				467
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
	_M.__all__.Skill_MZu_Proud = {
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
					-2.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				900
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
	_M.__all__.Skill_MZu_Unique = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0.5,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, global.EnemyUnits(_env))
				global.HealTargetView(_env, global.FriendUnits(_env))
			end)
			exec["@time"]({
				2233
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_show = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				if #global.AllUnits(_env) >= 4 then
					_env.units = global.Slice(_env, global.SortBy(_env, global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR)), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 3)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")

						if global.GetSide(_env, unit) ~= global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot_2"
							}, {
								buff_show
							})
							global.ApplyRPEffect(_env, _env.ACTOR, unit)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						end

						if global.GetSide(_env, unit) == global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot"
							}, {
								buff_show
							})

							local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

							global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				else
					_env.units = global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")

						if global.GetSide(_env, unit) ~= global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot_2"
							}, {
								buff_show
							})
							global.ApplyRPEffect(_env, _env.ACTOR, unit)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						end

						if global.GetSide(_env, unit) == global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot"
							}, {
								buff_show
							})

							local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

							global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local prob = global.SpecialPropGetter(_env, "Skill_MZu_probFactor")(_env, _env.ACTOR)

				if global.ProbTest(_env, prob) then
					global.Sound(_env, "Se_Skill_MZu_Water_Hit_2", 1)

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "MZu_Shoot_2"
						}, {
							global.buff_show
						})

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							global.SpecialPropGetter(_env, "Skill_MZu_dmgFactor")(_env, _env.ACTOR),
							0
						})

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "MZu_Shoot"
						}, {
							global.buff_show
						})
						global.ApplyRPRecovery(_env, unit, global.SpecialPropGetter(_env, "Skill_MZu_RageFactor")(_env, _env.ACTOR))

						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, global.SpecialPropGetter(_env, "Skill_MZu_HealRateFactor")(_env, _env.ACTOR), 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					end
				end
			end)
			exec["@time"]({
				3250
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZu_Passive = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_MZu_probFactor", {
					"?Normal"
				}, this.probRate)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Skill_MZu_dmgFactor", {
					"?Normal"
				}, this.dmgFactor[2])
				local buffeft3 = global.SpecialNumericEffect(_env, "+Skill_MZu_HealRateFactor", {
					"?Normal"
				}, this.HealRateFactor)
				local buffeft4 = global.SpecialNumericEffect(_env, "+Skill_MZu_RageFactor", {
					"?Normal"
				}, this.RageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_MZu_Passive_Parameter",
					timing = 0,
					limit = 1,
					tags = {
						"Skill_MZu_Passive_Parameter",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZu_Proud_EX = {
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
					-2.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZu_Unique_EX = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0.5,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, global.EnemyUnits(_env))
				global.HealTargetView(_env, global.FriendUnits(_env))
			end)
			exec["@time"]({
				2233
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_show = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				if #global.AllUnits(_env) >= 4 then
					_env.units = global.Slice(_env, global.SortBy(_env, global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR)), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 3)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")

						if global.GetSide(_env, unit) ~= global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot_2"
							}, {
								buff_show
							})
							global.ApplyRPEffect(_env, _env.ACTOR, unit)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						end

						if global.GetSide(_env, unit) == global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot"
							}, {
								buff_show
							})

							local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

							global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				else
					_env.units = global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")

						if global.GetSide(_env, unit) ~= global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot_2"
							}, {
								buff_show
							})
							global.ApplyRPEffect(_env, _env.ACTOR, unit)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						end

						if global.GetSide(_env, unit) == global.GetSide(_env, _env.ACTOR) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								display = "MZu_Shoot"
							}, {
								buff_show
							})

							local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

							global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local prob = global.SpecialPropGetter(_env, "Skill_MZu_probFactor")(_env, _env.ACTOR)

				if global.ProbTest(_env, prob) then
					global.Sound(_env, "Se_Skill_MZu_Water_Hit_2", 1)

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "MZu_Shoot_2"
						}, {
							global.buff_show
						})

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							global.SpecialPropGetter(_env, "Skill_MZu_dmgFactor")(_env, _env.ACTOR),
							0
						})

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "MZu_Shoot"
						}, {
							global.buff_show
						})
						global.ApplyRPRecovery(_env, unit, global.SpecialPropGetter(_env, "Skill_MZu_RageFactor")(_env, _env.ACTOR))

						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, global.SpecialPropGetter(_env, "Skill_MZu_HealRateFactor")(_env, _env.ACTOR), 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					end
				end
			end)
			exec["@time"]({
				3250
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MZu_Passive_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_MZu_probFactor", {
					"?Normal"
				}, this.probRate)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Skill_MZu_dmgFactor", {
					"?Normal"
				}, this.dmgFactor[2])
				local buffeft3 = global.SpecialNumericEffect(_env, "+Skill_MZu_HealRateFactor", {
					"?Normal"
				}, this.HealRateFactor)
				local buffeft4 = global.SpecialNumericEffect(_env, "+Skill_MZu_RageFactor", {
					"?Normal"
				}, this.RageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_MZu_Passive_Parameter",
					timing = 0,
					limit = 1,
					tags = {
						"Skill_MZu_Passive_Parameter",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				}, 1)
			end)

			return _env
		end
	}

	return _M
end
