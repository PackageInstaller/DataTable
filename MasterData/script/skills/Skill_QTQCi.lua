-- chunkname: @/tmp/or_skill/lua_compile/Skill_QTQCi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_QTQCi_Normal = {
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
					-1.9,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local animarray = global.GetAttackEffects(_env, _env.ACTOR)

				global.AnimForTrgt(_env, _env.TARGET, {
					loop = 1,
					zOrder = "TopLayer",
					pos = {
						0.5,
						0.5
					},
					anim = animarray[1]
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill2"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local animarray = global.GetAttackEffects(_env, _env.ACTOR)

					global.AnimForTrgt(_env, unit, {
						loop = 1,
						zOrder = "TopLayer",
						pos = {
							0.5,
							0.5
						},
						anim = animarray[1]
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Unique = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill3"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end

				global.HarmTargetView(_env, _env.units)
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local animarray = global.GetAttackEffects(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.CellRowLocation(_env, global.GetCell(_env, unit)) == 1 then
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[1]
						})
					elseif global.CellRowLocation(_env, global.GetCell(_env, unit)) == 2 then
						global.DelayCall(_env, 67, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 67, global.AnimForTrgt, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[1]
						})
					elseif global.CellRowLocation(_env, global.GetCell(_env, unit)) == 3 then
						damage.val = damage.val * (1 + this.DamageFactor)

						global.DelayCall(_env, 134, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 134, global.AnimForTrgt, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[2]
						})
					end
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Passive = {
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
				local buff_rp = global.SpecialNumericEffect(_env, "+Skill_QTQCi_Passive_RP", {
					"+Normal",
					"+Normal"
				}, this.RpFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_QTQCi_Passive"
					}
				}, {
					buff_rp
				})

				local buff1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 2,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"CRITRATEUP"
					}
				}, {
					buff1
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Passive_Key = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "ZTXChang")(_env, _env.unit) then
					for _, unit in global.__iter__(global.FriendDiedUnits(_env)) do
						if global.MARKED(_env, "QTQCi")(_env, unit) then
							local reviveunit = global.ReviveByUnit(_env, unit, this.HpFactor, this.RpFactor * 1000, {
								global.abs(_env, global.GetCellId(_env, _env.unit))
							})

							if reviveunit then
								global.AddStatus(_env, reviveunit, "Skill_QTQCi_Passive_Key")
							end
						end
					end

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "QTQCi"))) do
						local Aibo = global.RecruitCard(_env, card, {
							global.abs(_env, global.GetCellId(_env, _env.unit))
						})

						if Aibo then
							global.AddStatus(_env, Aibo, "Skill_QTQCi_Passive_Key")
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill2"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local animarray = global.GetAttackEffects(_env, _env.ACTOR)

					if global.CellRowLocation(_env, global.GetCell(_env, unit)) == 3 then
						damage.val = damage.val * (1 + this.DamageFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[2]
						})
					else
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[1]
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Unique_EX = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill3"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end

				global.HarmTargetView(_env, _env.units)
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local animarray = global.GetAttackEffects(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.CellRowLocation(_env, global.GetCell(_env, unit)) == 1 then
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[1]
						})
					elseif global.CellRowLocation(_env, global.GetCell(_env, unit)) == 2 then
						global.DelayCall(_env, 67, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 67, global.AnimForTrgt, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[1]
						})
					elseif global.CellRowLocation(_env, global.GetCell(_env, unit)) == 3 then
						damage.val = damage.val * (1 + this.DamageFactor)

						global.DelayCall(_env, 134, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 134, global.AnimForTrgt, unit, {
							loop = 1,
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							},
							anim = animarray[2]
						})
					end
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_QTQCi_Passive_EX = {
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
				local buff_rp = global.SpecialNumericEffect(_env, "+Skill_QTQCi_Passive_RP", {
					"+Normal",
					"+Normal"
				}, this.RpFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_QTQCi_Passive"
					}
				}, {
					buff_rp
				})

				local buff1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 2,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"CRITRATEUP"
					}
				}, {
					buff1
				}, 1, 0)
			end)

			return _env
		end
	}

	return _M
end
