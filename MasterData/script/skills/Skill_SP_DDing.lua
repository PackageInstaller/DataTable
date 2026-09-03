-- chunkname: @/tmp/or_skill/lua_compile/Skill_SP_DDing.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SP_DDing_Normal = {
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
				}, 100, "skill1"))
			end)
			exec["@time"]({
				567
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
	_M.__all__.Skill_SP_DDing_Proud = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						134,
						267
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_DDing")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0,
					0.2
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.AssignRoles(_env, unit, "target1")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.AssignRoles(_env, unit, "target2")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.AssignRoles(_env, unit, "target3")
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.DelayCall(_env, 167, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 300, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 434, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						434
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

					if rage > 600 then
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
						global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Passive = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.unit) and global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) and (global.MARKED(_env, "ASSASSIN")(_env, _env.unit) or global.MARKED(_env, "MAGE")(_env, _env.unit)) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local master_maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buff_hp = global.SpecialNumericEffect(_env, "+SP_DDing_Ini_Hp", {
						"+Normal",
						"+Normal"
					}, master_maxhp)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99
					}, {
						buff_hp
					})
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
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) and global.MASTER(_env, _env.ACTOR) then
					local buff_master = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"Player_Master"
						}
					}, {
						buff_master
					})

					local rp = global.SpecialPropGetter(_env, "SP_DDing_Rp")(_env, _env.ACTOR)

					global.ApplyRPRecovery(_env, _env.ACTOR, rp)

					local buff = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "SECTSKILL", "Skill_YSTLu_Passive_Key", "HURTRATEUP", "UNHURTRATEUP", "CRITRATEUP", "ATKUP", "DEFUP", "DEFRATEUP", "ATKRATEUP", "ABSORPTIONUP", "BLOCKRATEUP"))
					local buff2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "NUMERIC", "Fight_MaxCostBuff", "UNDISPELLABLE", "UNSTEALABLE"))

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"SP_DDing_PREPARE"
						}
					}, {
						buff,
						buff2
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "DEBUFF"), 99)

					if global.SpecialPropGetter(_env, "AMLBLTe_Exist")(_env, global.FriendField(_env)) == 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Cross_Buff_AMLBLTe"), 99)
					end

					if global.SpecialPropGetter(_env, "XLDBLTe_Exist")(_env, global.FriendField(_env)) == 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Cross_Buff_XLDBLTe"), 99)
					end

					global.DelayCall(_env, 1580, global.DispelBuff, _env.ACTOR, global.BUFF_MARKED(_env, "SP_DDing_PREPARE"), 99)

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) then
							global.Kick(_env, unit)
						end

						if global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
							global.Kick(_env, unit)
						end
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
				3500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) and not global.MASTER(_env, _env.ACTOR) and global.FriendMaster(_env) then
					local ini_maxhp = global.SpecialPropGetter(_env, "SP_DDing_Ini_Hp")(_env, global.FriendMaster(_env))
					local master_maxhp = global.UnitPropGetter(_env, "maxHp")(_env, global.FriendMaster(_env))
					local master_hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, global.FriendMaster(_env))
					local deta_hp = global.max(_env, master_maxhp - ini_maxhp, 0)
					local rp = global.UnitPropGetter(_env, "rp")(_env, global.FriendMaster(_env))
					local star = global.UnitPropGetter(_env, "star")(_env, _env.ACTOR)
					local name = "SummonedSP_DDing"

					if star == 4 then
						name = "SummonedSP_DDing_4"
					elseif star == 5 then
						name = "SummonedSP_DDing_5"
					elseif star == 6 then
						name = "SummonedSP_DDing_6"
					end

					global.AddAnim(_env, {
						loop = 1,
						anim = "qian_SPbeiyatesiheian",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.FriendMaster(_env)) + {
							0,
							-0.5
						}
					})

					local SummonedSP_DDing = global.SummonMaster(_env, global.FriendMaster(_env), name, this.master_factors, {
						-deta_hp,
						0,
						0
					}, nil, master_hpRatio)

					if SummonedSP_DDing then
						global.AddStatus(_env, SummonedSP_DDing, "SummonedSP_DDing")

						local buff_rp = global.SpecialNumericEffect(_env, "+SP_DDing_Rp", {
							"+Normal",
							"+Normal"
						}, rp)

						global.ApplyBuff(_env, SummonedSP_DDing, {
							timing = 0,
							duration = 99
						}, {
							buff_rp
						})
						global.MarkSummoned(_env, SummonedSP_DDing, false)
					end
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) and not global.MASTER(_env, _env.ACTOR) then
					global.Kick(_env, _env.ACTOR)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Proud_EX = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						134,
						267
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
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
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+exskillrate", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_SP_DDing_Proud_EX"
						}
					}, {
						buffeft
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Unique_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_DDing")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0,
					0.2
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.AssignRoles(_env, unit, "target1")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.AssignRoles(_env, unit, "target2")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.AssignRoles(_env, unit, "target3")
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.DelayCall(_env, 167, global.ShakeScreen, {
					Id = 1,
					duration = 50,
					enhance = 3
				})
				global.DelayCall(_env, 300, global.ShakeScreen, {
					Id = 1,
					duration = 50,
					enhance = 3
				})
				global.DelayCall(_env, 434, global.ShakeScreen, {
					Id = 1,
					duration = 50,
					enhance = 3
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						434
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

					if rage > 600 then
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
						global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Passive_EX = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.unit) and global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) and (global.MARKED(_env, "ASSASSIN")(_env, _env.unit) or global.MARKED(_env, "MAGE")(_env, _env.unit)) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
					global.ApplyRPRecovery(_env, _env.unit, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Unique_Summoned = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_DDing")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0,
					0.2
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.AssignRoles(_env, unit, "target1")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.AssignRoles(_env, unit, "target2")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.AssignRoles(_env, unit, "target3")
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.DelayCall(_env, 167, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 300, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 434, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						434
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

					if rage > 600 then
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
						global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_DDing_Unique_Summoned_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_DDing")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					0,
					0.2
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.AssignRoles(_env, unit, "target1")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.AssignRoles(_env, unit, "target2")
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.AssignRoles(_env, unit, "target3")
				end
			end)
			exec["@time"]({
				2234
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.DelayCall(_env, 167, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 300, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})
				global.DelayCall(_env, 434, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 3
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.FRONT_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						434
					}, global.SplitValue(_env, damage, {
						0.3,
						0.7
					}))
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local rage = global.UnitPropGetter(_env, "rp")(_env, unit)

					if rage > 600 then
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RageFactor)
						global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
					end
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
