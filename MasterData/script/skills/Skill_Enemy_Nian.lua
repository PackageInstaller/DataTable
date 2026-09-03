-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_Nian.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_Enemy_Nian_Normal = {
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

			_env.TargetFactor = externs.TargetFactor

			if _env.TargetFactor == nil then
				_env.TargetFactor = global.Random(_env, 0, 100)
			end

			_env.count = externs.count

			if _env.count == nil then
				_env.count = 0
			end

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, enemyunit in global.__iter__(global.EnemyUnits(_env)) do
					if global.SelectBuffCount(_env, enemyunit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
						_env.count = _env.count + 1
					end
				end

				if _env.count == 0 then
					if _env.TargetFactor < 33 then
						_env.TargetFactor = 1
					elseif _env.TargetFactor > 33 and _env.TargetFactor < 66 then
						_env.TargetFactor = 2
					elseif _env.TargetFactor > 66 then
						_env.TargetFactor = 3
					end

					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill1"))

					if global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor)) or global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor + 3)) or global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor + 6)) then
						if _env.TargetFactor == 1 then
							_env.units = global.EnemyUnits(_env, global.TOP_COL)
						elseif _env.TargetFactor == 2 then
							_env.units = global.EnemyUnits(_env, global.MID_COL)
						elseif _env.TargetFactor == 3 then
							_env.units = global.EnemyUnits(_env, global.BOTTOM_COL)
						end
					else
						_env.TargetFactor = 2
						_env.units = global.EnemyUnits(_env, global.MID_COL)
					end
				elseif _env.count > 0 then
					for _, enemyunit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, enemyunit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
							global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill1"))

							_env.units = global.EnemyUnits(_env, global.COL_OF(_env, enemyunit))

							break
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.count > 0 then
					if global.abs(_env, global.GetCellId(_env, _env.units[1])) == 1 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 4 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 7 then
						_env.TargetFactor = 1
					elseif global.abs(_env, global.GetCellId(_env, _env.units[1])) == 2 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 5 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 8 then
						_env.TargetFactor = 2
					elseif global.abs(_env, global.GetCellId(_env, _env.units[1])) == 3 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 6 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 9 then
						_env.TargetFactor = 3
					end
				end

				if _env.TargetFactor == 1 then
					global.SetDisplayZorder(_env, _env.ACTOR, 100000)
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							-1.5
						}
					})
				elseif _env.TargetFactor == 2 then
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							-0.2
						}
					})
				elseif _env.TargetFactor == 3 then
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							1
						}
					})
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.TargetFactor == 1 then
					global.ResetDisplayZorder(_env, _env.ACTOR)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_Nian_Unique = {
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

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill2"))
				global.DelayCall(_env, 900, global.ShakeScreen, {
					Id = 3,
					duration = 50,
					enhance = 8
				})
				global.DelayCall(_env, 1200, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 9
				})

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				global.AddAnim(_env, {
					loop = 1,
					anim = "skill2_nianshoujineng",
					zOrder = "TopLayer",
					pos = global.FixedPos(_env, 0, 0, 2)
				})

				local buffeft1 = global.EnergyEffect(_env, 0)

				if global.EnemyMaster(_env) then
					global.ApplyBuff(_env, global.EnemyMaster(_env), {
						timing = 4,
						display = "EnergyEffectDown",
						group = "Nian_Dong",
						duration = 12,
						limit = 1,
						tags = {
							"UNSTEALABLE",
							"UNDISPELLABLE",
							"FREEZEENERGY"
						}
					}, {
						buffeft1
					})
					global.ShowFrazeEnergyEffect(_env, global.GetOwner(_env, global.EnemyMaster(_env)), true)

					local buff_anim = global.PassiveFunEffectBuff(_env, "Skill_Enemy_Nian_Unique_Anim")

					global.ApplyBuff(_env, global.EnemyMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"NIAN_ANIM"
						}
					}, {
						buff_anim
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_Nian_Unique_Anim = {
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

				if global.BuffIsMatched(_env, _env.buff, "FREEZEENERGY") then
					global.ShowFrazeEnergyEffect(_env, global.GetOwner(_env, global.FriendMaster(_env)), false)
					global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "NIAN_ANIM"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_Nian_Passive = {
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
				local NianFlag = global.SpecialNumericEffect(_env, "+nshoushou", {
					"?Normal"
				}, 1)
				local damage = this.HPDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

				global.ApplyHPDamage(_env, _env.ACTOR, damage)

				if this.MuteFactor == 1 then
					local buffeft1 = global.Mute(_env)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						duration = 2,
						display = "Mute",
						tags = {
							"Mute",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local Left = global.Summon(_env, _env.ACTOR, "SummonedNian", {
					0.5,
					1,
					1
				}, nil, {
					7
				})

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"NianShou",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					NianFlag
				})
				global.MarkSummoned(_env, Left, false)
				global.setRootVisible(_env, Left, false)
				global.AddStatus(_env, Left, "SummonedNian")

				local Right = global.Summon(_env, _env.ACTOR, "SummonedNian", {
					0.5,
					1,
					1
				}, nil, {
					9
				})

				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"NianShou",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					NianFlag
				})
				global.MarkSummoned(_env, Right, false)
				global.setRootVisible(_env, Right, false)
				global.AddStatus(_env, Right, "SummonedNian")

				local DazeBuff = global.Daze(_env)

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DazeBuff
				})
				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DazeBuff
				})

				local DmgTransfer = global.DamageTransferEffect(_env, _env.ACTOR, 1)

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DmgTransfer
				})
				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DmgTransfer
				})
			end)

			return _env
		end
	}

	return _M
end
