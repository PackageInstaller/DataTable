-- chunkname: @/tmp/or_skill/lua_compile/Skill_Master_LieSha.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Sk_Master_LieSha_Attack = {
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
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_LieSha_Action1 = {
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

				_env.units = global.EnemyUnits(_env, global.MID_COL)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.8,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local target2 = global.EnemyUnits(_env, global.MID_COL * global.FRONT_ROW)[1]
				local target5 = global.EnemyUnits(_env, global.MID_COL * global.MID_ROW)[1]
				local target8 = global.EnemyUnits(_env, global.MID_COL * global.BACK_ROW)[1]

				for _, unit in global.__iter__(_env.units) do
					local buffeft1 = global.NumericEffect(_env, "-defrate", {
						"+Normal",
						"+Normal"
					}, this.DeDefRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 4,
						duration = 45,
						display = "DefDown",
						tags = {
							"NUMERIC",
							"DEBUFF",
							"DEFDOWN",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
				end

				if target2 then
					global.ApplyStatusEffect(_env, _env.ACTOR, target2)
					global.ApplyRPEffect(_env, _env.ACTOR, target2)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target2, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target2, {
						0,
						300,
						600
					}, global.SplitValue(_env, damage, {
						0.27,
						0.33,
						0.4
					}))

					if target5 then
						global.ApplyStatusEffect(_env, _env.ACTOR, target5)
						global.ApplyRPEffect(_env, _env.ACTOR, target5)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target5, this.dmgFactor)

						damage.val = damage.val * 0.7

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target5, {
							0,
							300,
							600
						}, global.SplitValue(_env, damage, {
							0.27,
							0.33,
							0.4
						}))

						if target8 then
							global.ApplyStatusEffect(_env, _env.ACTOR, target8)
							global.ApplyRPEffect(_env, _env.ACTOR, target8)

							local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target8, this.dmgFactor)

							damage.val = damage.val * 0.4

							global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target8, {
								0,
								300,
								600
							}, global.SplitValue(_env, damage, {
								0.27,
								0.33,
								0.4
							}))
						end
					elseif target8 then
						global.ApplyStatusEffect(_env, _env.ACTOR, target8)
						global.ApplyRPEffect(_env, _env.ACTOR, target8)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target8, this.dmgFactor)

						damage.val = damage.val * 0.7

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target8, {
							0,
							300,
							600
						}, global.SplitValue(_env, damage, {
							0.27,
							0.33,
							0.4
						}))
					end
				elseif target5 then
					global.ApplyStatusEffect(_env, _env.ACTOR, target5)
					global.ApplyRPEffect(_env, _env.ACTOR, target5)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target5, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target5, {
						0,
						300,
						600
					}, global.SplitValue(_env, damage, {
						0.27,
						0.33,
						0.4
					}))

					if target8 then
						global.ApplyStatusEffect(_env, _env.ACTOR, target8)
						global.ApplyRPEffect(_env, _env.ACTOR, target8)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target8, this.dmgFactor)

						damage.val = damage.val * 0.7

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target8, {
							0,
							300,
							600
						}, global.SplitValue(_env, damage, {
							0.27,
							0.33,
							0.4
						}))
					end
				elseif target8 then
					global.ApplyStatusEffect(_env, _env.ACTOR, target8)
					global.ApplyRPEffect(_env, _env.ACTOR, target8)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target8, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, target8, {
						0,
						300,
						600
					}, global.SplitValue(_env, damage, {
						0.27,
						0.33,
						0.4
					}))
				end
			end)
			exec["@time"]({
				3235
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_LieSha_Action2 = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")

				if global.EnemyMaster(_env) then
					global.RetainObject(_env, global.EnemyMaster(_env))
				else
					global.RetainObject(_env, _env.TARGET)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if global.EnemyMaster(_env) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, global.EnemyMaster(_env)) + {
						-1.8,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, global.EnemyMaster(_env), "target")
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.8,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) then
					local buffeft1 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, global.DeWeakenFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 2,
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
					global.ApplyStatusEffect(_env, _env.ACTOR, global.EnemyMaster(_env))
					global.ApplyRPEffect(_env, _env.ACTOR, global.EnemyMaster(_env))

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, global.EnemyMaster(_env), this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, global.EnemyMaster(_env), damage)
				else
					local buffeft1 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, global.DeWeakenFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 2,
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

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_LieSha_Action3 = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft2 = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				if global.EnemyMaster(_env) then
					global.ApplyBuff_Debuff(_env, _env.ACTOR, global.EnemyMaster(_env), {
						timing = 4,
						display = "UnHurtRateDown",
						group = "Sk_Master_LieSha_Action3",
						duration = 30,
						limit = 1,
						tags = {
							"NUMERIC",
							"DEBUFF",
							"UNHURTRATEDOWN",
							"UNDISPELLABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
