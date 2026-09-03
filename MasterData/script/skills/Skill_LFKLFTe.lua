-- chunkname: @/tmp/or_skill/lua_compile/Skill_LFKLFTe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LFKLFTe_Normal = {
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
				633
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
	_M.__all__.Skill_LFKLFTe_Proud = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				933
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
	_M.__all__.Skill_LFKLFTe_Unique = {
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
				2433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedLFKLFTe")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HpFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

						local buff = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "AtkUp",
							group = "Skill_LFKLFTe_Unique",
							duration = 99,
							limit = 3,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"DISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						200,
						333,
						633,
						733,
						933
					}, global.SplitValue(_env, damage, {
						0.16,
						0.16,
						0.16,
						0.17,
						0.17,
						0.18
					}))
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
	_M.__all__.Skill_LFKLFTe_Passive = {
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
					local buff_hp = global.SpecialNumericEffect(_env, "+Ini_Hp", {
						"+Normal",
						"+Normal"
					}, master_maxhp)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99
					}, {
						buff_hp
					})

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "LFKLFTe"))) do
						global.setEnterPauseTime(_env, global.GetOwner(_env, _env.ACTOR), card, 1500)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "LFKLFTe")(_env, _env.ACTOR) and global.FriendMaster(_env) and global.SpecialPropGetter(_env, "DaGun")(_env, global.FriendField(_env)) == 0 then
					global.DelayCall(_env, 500, global.AddAnimWithFlip, {
						loop = 1,
						anim = "ws_shuiruchang",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.FriendMaster(_env)) + {
							1,
							-1.4
						}
					})
					global.SummonDaGun(_env, _env.ACTOR, this.summonFactor, this.masterFactor, this.dmgFactor, this.YiyuFactor, this.HpFactor, this.GongpingFactor, this.abFactor, 0)
				end
			end)

			return _env
		end
	}

	function _M.__all__.RecertMaster(_env, actor)
		local this, global = _env.this, _env.global

		global.DispelBuff(_env, actor, global.BUFF_MARKED(_env, "DAGUN_SPE"), 99)
		global.ExertUniqueSkill(_env, actor)
	end

	function _M.__all__.SummonDaGun(_env, actor, snya_factors, master_factors, normal, skill1, skillhp, skill2, skillex, ex_flag)
		local this, global = _env.this, _env.global
		local buff_mute = global.Mute(_env)

		global.ApplyBuff(_env, actor, {
			timing = 0,
			duration = 99,
			tags = {
				"DAGUN_SPE"
			}
		}, {
			buff_mute
		})
		global.DelayCall(_env, 800, global.RecertMaster, actor)

		if global.SpecialPropGetter(_env, "DaGun")(_env, global.FriendField(_env)) == 0 and global.FriendMaster(_env) then
			for _, cell in global.__iter__(global.FriendCells(_env, global.CELL_IN_POS(_env, 7) + global.CELL_IN_POS(_env, 9))) do
				if global.GetCellUnit(_env, cell) then
					global.Kick(_env, global.GetCellUnit(_env, cell), true)
				end
			end

			for i = 1, 2 do
				local SummonedLFKLFTeFoot = global.Summon(_env, actor, "SummonedLFKLFTeFoot", snya_factors, nil, {
					7,
					9
				})

				if SummonedLFKLFTeFoot then
					if global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, SummonedLFKLFTeFoot))) == 7 then
						global.AddStatus(_env, SummonedLFKLFTeFoot, "SummonedLFKLFTeLeftFoot")

						local buff_left = global.SpecialNumericEffect(_env, "+DaGun_Left", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"DAGUN_LEFT"
							}
						}, {
							buff_left
						})
					elseif global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, SummonedLFKLFTeFoot))) == 9 then
						global.AddStatus(_env, SummonedLFKLFTeFoot, "SummonedLFKLFTeRightFoot")

						local buff_right = global.SpecialNumericEffect(_env, "+DaGun_Right", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"DAGUN_RIGHT"
							}
						}, {
							buff_right
						})
					end

					global.MarkSummoned(_env, SummonedLFKLFTeFoot, false)
					global.NoMove(_env, SummonedLFKLFTeFoot)

					local buffeft1 = global.SpecialNumericEffect(_env, "+FootDamageRate", {
						"?Normal"
					}, normal)

					global.ApplyBuff(_env, SummonedLFKLFTeFoot, {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_LFKLFTe_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end

			local ini_maxhp = global.SpecialPropGetter(_env, "Ini_Hp")(_env, global.FriendMaster(_env))
			local master_maxhp = global.UnitPropGetter(_env, "maxHp")(_env, global.FriendMaster(_env))
			local master_hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, global.FriendMaster(_env))
			local deta_hp = global.max(_env, master_maxhp - ini_maxhp, 0)
			local rp = global.UnitPropGetter(_env, "rp")(_env, global.FriendMaster(_env))

			global.GroundEft(_env, _env.ACTOR, "Ground_Dagun", 1000, false)

			local name = "SummonedLFKLFTe"

			if ex_flag == 1 then
				name = "SummonedLFKLFTe_Ex"
			elseif ex_flag == 2 then
				name = "SummonedLFKLFTe_Activity"
			end

			local SummonedLFKLFTe = global.SummonMaster(_env, global.FriendMaster(_env), name, master_factors, {
				-deta_hp,
				0,
				0
			}, nil, master_hpRatio)

			if SummonedLFKLFTe then
				global.AddStatus(_env, SummonedLFKLFTe, "SummonedLFKLFTe")

				local buffeft0 = global.SpecialNumericEffect(_env, "+FootDamageRate", {
					"?Normal"
				}, 1)
				local buffeft1 = global.SpecialNumericEffect(_env, "+YiyuFactor", {
					"?Normal"
				}, skill1)
				local buffeft2 = global.SpecialNumericEffect(_env, "+GongpingFactor", {
					"?Normal"
				}, skill2)
				local buffeft3 = global.SpecialNumericEffect(_env, "+abFactor", {
					"?Normal"
				}, skillex)
				local buffeft4 = global.SpecialNumericEffect(_env, "+HpFactor", {
					"?Normal"
				}, skillhp)

				global.ApplyBuff(_env, SummonedLFKLFTe, {
					timing = 0,
					duration = 99,
					tags = {}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				})

				local buff_rp = global.SpecialNumericEffect(_env, "+DaGun_Rp", {
					"+Normal",
					"+Normal"
				}, rp)
				local buff_hp = global.SpecialNumericEffect(_env, "+DaGun_Hp", {
					"+Normal",
					"+Normal"
				}, master_maxhp)

				global.ApplyBuff(_env, SummonedLFKLFTe, {
					timing = 0,
					duration = 99
				}, {
					buff_rp,
					buff_hp
				})
				global.SetDisplayZorder(_env, SummonedLFKLFTe, 1000)
				global.MarkSummoned(_env, SummonedLFKLFTe, false)
			end

			local buff_check = global.SpecialNumericEffect(_env, "+DaGun", {
				"+Normal",
				"+Normal"
			}, 1)

			global.ApplyBuff(_env, global.FriendField(_env), {
				timing = 0,
				duration = 99,
				tags = {
					"DAGUN_SUMMONED"
				}
			}, {
				buff_check
			})
		end
	end

	function _M.__all__.DaGun(_env, dagun)
		local this, global = _env.this, _env.global
		local left = 0
		local right = 0

		for _, unit in global.__iter__(global.FriendUnits(_env)) do
			if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) then
				left = left + 1
			end

			if global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
				right = right + 1
			end
		end

		if left == 1 and right == 1 then
			global.AddStatus(_env, dagun, "HasBothFeet")
			global.SwitchActionTo(_env, "die", "die_6", dagun)
		elseif left == 1 and right == 0 then
			global.RemoveStatus(_env, dagun, "HasBothFeet")
			global.AddStatus(_env, dagun, "OnlyLeftFoot")
			global.SwitchActionTo(_env, "down", "down_2", dagun)
			global.SwitchActionTo(_env, "hurt1", "hurt1_2", dagun)
			global.SwitchActionTo(_env, "stand", "stand_2", dagun)
			global.SwitchActionTo(_env, "win", "win_2", dagun)
			global.SwitchActionTo(_env, "skill2", "skill2_2", dagun)
			global.SwitchActionTo(_env, "skill3", "skill3_2", dagun)
			global.SwitchActionTo(_env, "die", "die_8", dagun)
			global.Perform(_env, dagun, global.Animation(_env, "stand"))
		elseif left == 0 and right == 1 then
			global.RemoveStatus(_env, dagun, "HasBothFeet")
			global.AddStatus(_env, dagun, "OnlyRightFoot")
			global.SwitchActionTo(_env, "down", "down_3", dagun)
			global.SwitchActionTo(_env, "hurt1", "hurt1_3", dagun)
			global.SwitchActionTo(_env, "stand", "stand_3", dagun)
			global.SwitchActionTo(_env, "win", "win_3", dagun)
			global.SwitchActionTo(_env, "skill2", "skill2_3", dagun)
			global.SwitchActionTo(_env, "skill3", "skill3_3", dagun)
			global.SwitchActionTo(_env, "die", "die_7", dagun)
			global.Perform(_env, dagun, global.Animation(_env, "stand"))
		else
			global.RemoveStatus(_env, dagun, "OnlyLeftFoot")
			global.RemoveStatus(_env, dagun, "OnlyRightFoot")
			global.AddStatus(_env, dagun, "NoFeet")
			global.SwitchActionTo(_env, "down", "down_4", dagun)
			global.SwitchActionTo(_env, "hurt1", "hurt1_4", dagun)
			global.SwitchActionTo(_env, "stand", "stand_4", dagun)
			global.SwitchActionTo(_env, "win", "win_4", dagun)
			global.SwitchActionTo(_env, "skill2", "skill2_4", dagun)
			global.SwitchActionTo(_env, "skill3", "skill3_4", dagun)
			global.SwitchActionTo(_env, "die", "die_5", dagun)
			global.Perform(_env, dagun, global.Animation(_env, "stand"))
		end
	end

	_M.__all__.DaGunPassive = {
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

				local rp = global.SpecialPropGetter(_env, "DaGun_Rp")(_env, _env.ACTOR)

				global.ApplyRPRecovery(_env, _env.ACTOR, rp)

				local buff = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "SECTSKILL", "Skill_YSTLu_Passive_Key", "HURTRATEUP", "UNHURTRATEUP", "CRITRATEUP", "ATKUP", "DEFUP", "DEFRATEUP", "ATKRATEUP", "ABSORPTIONUP", "BLOCKRATEUP"))
				local buff2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "NUMERIC", "Fight_MaxCostBuff", "UNDISPELLABLE", "UNSTEALABLE"))

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"DAGUN_PREPARE"
					}
				}, {
					buff,
					buff2
				})
				global.Sound(_env, "Se_Skill_DGun_Squat", 1)
				global.DelayCall(_env, 300, global.ShakeScreen, {
					Id = 3,
					duration = 50,
					enhance = 8
				})
				global.DelayCall(_env, 600, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 9
				})
				global.DelayCall(_env, 1550, global.ResetDisplayZorder, _env.ACTOR)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "DEBUFF"), 99)

				if global.SpecialPropGetter(_env, "AMLBLTe_Exist")(_env, global.FriendField(_env)) == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Cross_Buff_AMLBLTe"), 99)
				end

				if global.SpecialPropGetter(_env, "XLDBLTe_Exist")(_env, global.FriendField(_env)) == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Cross_Buff_XLDBLTe"), 99)
				end

				local count_ystlu = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "YSTLu"))) do
					count_ystlu = count_ystlu + 1
				end

				if count_ystlu == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_YSTLu_Passive_Key"), 99)
				end

				global.DelayCall(_env, 1580, global.DispelBuff, _env.ACTOR, global.BUFF_MARKED(_env, "DAGUN_PREPARE"), 99)
				global.DaGun(_env, _env.ACTOR)
			end)

			return _env
		end
	}
	_M.__all__.DaGunFootPassive = {
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

				if global.FriendMaster(_env) then
					global.setRootVisible(_env, global.FriendMaster(_env), true)

					if global.INSTATUS(_env, "HasBothFeet")(_env, global.FriendMaster(_env)) then
						global.SwitchActionTo(_env, "hurt1", "hurt1", global.FriendMaster(_env))
					elseif global.INSTATUS(_env, "OnlyLeftFoot")(_env, global.FriendMaster(_env)) then
						global.SwitchActionTo(_env, "hurt1", "hurt1_2", global.FriendMaster(_env))
					elseif global.INSTATUS(_env, "OnlyRightFoot")(_env, global.FriendMaster(_env)) then
						global.SwitchActionTo(_env, "hurt1", "hurt1_3", global.FriendMaster(_env))
					end

					if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Dagun_Unique")) == 0 then
						global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "hurt1"))
						global.ResetDisplayZorder(_env, global.FriendMaster(_env))
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, _env.ACTOR))) ~= 7 and global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, _env.ACTOR))) ~= 9 then
					global.Kick(_env, _env.ACTOR)

					if global.FriendMaster(_env) then
						global.ResetDisplayZorder(_env, global.FriendMaster(_env))
						global.DaGun(_env, global.FriendMaster(_env))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.DaGunFootPassive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.MarkSummoned(_env, _env.ACTOR, true)

				local left = 0
				local right = 0

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) then
						left = left + 1
					end

					if global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
						right = right + 1
					end
				end

				local leftcheck = global.SpecialPropGetter(_env, "DaGun_Left")(_env, global.FriendField(_env))
				local rightcheck = global.SpecialPropGetter(_env, "DaGun_Right")(_env, global.FriendField(_env))

				if global.FriendMaster(_env) then
					if left == 0 and right == 0 and leftcheck ~= 0 and rightcheck ~= 0 then
						local buff_double = global.SpecialNumericEffect(_env, "+DaGun_Left", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"DAGUN_DOUBLE"
							}
						}, {
							buff_double
						})
						global.SwitchActionTo(_env, "die", "die_9", global.FriendMaster(_env))
						global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "die"))
					elseif global.SpecialPropGetter(_env, "DaGun_DoubleFeet")(_env, global.FriendField(_env)) == 0 then
						if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, _env.ACTOR) then
							if global.INSTATUS(_env, "HasBothFeet")(_env, global.FriendMaster(_env)) then
								global.SwitchActionTo(_env, "die", "die", global.FriendMaster(_env))
							elseif global.INSTATUS(_env, "OnlyLeftFoot")(_env, global.FriendMaster(_env)) then
								global.SwitchActionTo(_env, "die", "die_3", global.FriendMaster(_env))
							end

							global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "DAGUN_LEFT"), 99)
						end

						if global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, _env.ACTOR) then
							if global.INSTATUS(_env, "HasBothFeet")(_env, global.FriendMaster(_env)) then
								global.SwitchActionTo(_env, "die", "die_2", global.FriendMaster(_env))
							elseif global.INSTATUS(_env, "OnlyRightFoot")(_env, global.FriendMaster(_env)) then
								global.SwitchActionTo(_env, "die", "die_4", global.FriendMaster(_env))
							end

							global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "DAGUN_RIGHT"), 99)
						end

						global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "die"))
					end
				end
			end)
			exec["@time"]({
				1100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) then
					global.ResetDisplayZorder(_env, global.FriendMaster(_env))
					global.DaGun(_env, global.FriendMaster(_env))
				end

				global.Kick(_env, _env.ACTOR)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Foot_Normal = {
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

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end

				if global.FriendMaster(_env) then
					global.SetDisplayZorder(_env, global.FriendMaster(_env), 1000)

					if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, _env.ACTOR) then
						if global.INSTATUS(_env, "HasBothFeet")(_env, global.FriendMaster(_env)) then
							global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "skill1_2"))
						elseif global.INSTATUS(_env, "OnlyLeftFoot")(_env, global.FriendMaster(_env)) then
							global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "skill1_4"))
						end
					elseif global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, _env.ACTOR) then
						if global.INSTATUS(_env, "HasBothFeet")(_env, global.FriendMaster(_env)) then
							global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "skill1"))
						elseif global.INSTATUS(_env, "OnlyRightFoot")(_env, global.FriendMaster(_env)) then
							global.Perform(_env, global.FriendMaster(_env), global.Animation(_env, "skill1_3"))
						end
					end
				end
			end)
			exec["@time"]({
				367
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagefactor = global.SpecialPropGetter(_env, "FootDamageRate")(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						damagefactor,
						0
					})

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, _env.ACTOR) then
						global.AddAnimWithFlip(_env, {
							loop = 1,
							zOrder = "TopLayer",
							isFlipX = true,
							isFlipY = false,
							anim = "zuo_dagunzhuahen",
							pos = global.UnitPos(_env, _env.TARGET, nil, 2) + {
								0.3,
								-1.8
							}
						})
					elseif global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, _env.ACTOR) then
						global.AddAnimWithFlip(_env, {
							loop = 1,
							zOrder = "TopLayer",
							isFlipX = true,
							isFlipY = true,
							anim = "you_dagunzhuahen",
							pos = global.UnitPos(_env, _env.TARGET, nil, 2) + {
								-1.5,
								0
							}
						})
					end
				end
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) then
					global.ResetDisplayZorder(_env, global.FriendMaster(_env))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Dagun_Normal = {
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

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)

				if global.INSTATUS(_env, "NoFeet")(_env, _env.ACTOR) then
					global.AssignRoles(_env, _env.TARGET, "target")
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill1_5"))
				else
					global.ResetDisplayZorder(_env, _env.ACTOR)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				367
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagefactor = 1

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					damagefactor,
					0
				})

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.AnimForTrgt(_env, _env.TARGET, {
					loop = 1,
					anim = "pugong_dagunpugong",
					zOrder = "TopLayer",
					pos = {
						-1.4,
						0.5
					}
				})
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Dagun_Unique_Yiyu = {
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

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill2"))

				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Dagun_Unique"
					}
				}, {
					buff
				})
			end)
			exec["@time"]({
				833
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local YiyuFactor = global.SpecialPropGetter(_env, "YiyuFactor")(_env, _env.ACTOR)
				local atk_master = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buff1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, atk_master * YiyuFactor)
				local buff2 = global.Diligent(_env)
				local buff3 = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					local buffeft1 = global.SpecialNumericEffect(_env, "+yiyu_special_atk", {
						"?Normal"
					}, 2)
					local buffeft2 = global.SpecialNumericEffect(_env, "+yiyu_special_maxhp", {
						"?Normal"
					}, global.SpecialPropGetter(_env, "HpFactor")(_env, _env.ACTOR))

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1
					}, 1)
					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"DAGUNKILL",
							"YIYU"
						}
					}, {
						buff2,
						buff3,
						buffeft1,
						buffeft2
					})
				end

				global.DiligentRound(_env)
			end)
			exec["@time"]({
				1100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Dagun_Unique"), 99)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Dagun_Unique_Gongping = {
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

				global.SetDisplayZorder(_env, _env.ACTOR, 1000)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill3"))

				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Dagun_Unique"
					}
				}, {
					buff
				})
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local GongpingFactor = global.SpecialPropGetter(_env, "GongpingFactor")(_env, _env.ACTOR)
				local abFactor = global.SpecialPropGetter(_env, "abFactor")(_env, _env.ACTOR)
				local buff = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, abFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_LFKLFTe_Dagun_Unique_Gongping"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyRealDamage(_env, _env.ACTOR, unit, 2, 2, GongpingFactor, {
						0,
						433
					}, {
						0.5,
						0.5
					})
				end
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ResetDisplayZorder(_env, _env.ACTOR)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_LFKLFTe_Dagun_Unique_Gongping"), 99)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Dagun_Unique"), 99)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Proud_EX = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				933
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
	_M.__all__.Skill_LFKLFTe_Unique_EX = {
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
				2433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedLFKLFTe")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HpFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

						local buff = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "AtkUp",
							group = "Skill_LFKLFTe_Unique",
							duration = 99,
							limit = 3,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"DISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						200,
						333,
						633,
						733,
						933
					}, global.SplitValue(_env, damage, {
						0.16,
						0.16,
						0.16,
						0.17,
						0.17,
						0.18
					}))
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
	_M.__all__.Skill_LFKLFTe_Passive_EX = {
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
					local master_maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buff_hp = global.SpecialNumericEffect(_env, "+Ini_Hp", {
						"+Normal",
						"+Normal"
					}, master_maxhp)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99
					}, {
						buff_hp
					})

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "LFKLFTe"))) do
						global.setEnterPauseTime(_env, global.GetOwner(_env, _env.ACTOR), card, 1500)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "LFKLFTe")(_env, _env.ACTOR) and global.FriendMaster(_env) and global.SpecialPropGetter(_env, "DaGun")(_env, global.FriendField(_env)) == 0 then
					global.DelayCall(_env, 500, global.AddAnimWithFlip, {
						loop = 1,
						anim = "ws_shuiruchang",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.FriendMaster(_env)) + {
							1,
							-1.4
						}
					})
					global.SummonDaGun(_env, _env.ACTOR, this.summonFactor, this.masterFactor, this.dmgFactor, this.YiyuFactor, this.HpFactor, this.GongpingFactor, this.abFactor, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Passive_Activity = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.FriendMaster(_env) and global.SpecialPropGetter(_env, "DaGun")(_env, global.FriendField(_env)) == 0 then
					global.SummonDaGun(_env, _env.ACTOR, this.summonFactor, this.masterFactor, this.dmgFactor, this.YiyuFactor, this.HpFactor, this.GongpingFactor, this.abFactor, 2)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LFKLFTe_Unique_Awaken = {
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

				if global.FriendMaster(_env) then
					global.ApplyRPRecovery(_env, global.FriendMaster(_env), this.RateFactor)
				end
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
				2433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.INSTATUS(_env, "SummonedLFKLFTe")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HpFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

						local buff = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "AtkUp",
							group = "Skill_LFKLFTe_Unique",
							duration = 99,
							limit = 3,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"DISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						200,
						333,
						633,
						733,
						933
					}, global.SplitValue(_env, damage, {
						0.16,
						0.16,
						0.16,
						0.17,
						0.17,
						0.18
					}))
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
	_M.__all__.Skill_LFKLFTe_Passive_SelfAwaken = {
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
					local master_maxhp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buff_hp = global.SpecialNumericEffect(_env, "+Ini_Hp", {
						"+Normal",
						"+Normal"
					}, master_maxhp)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99
					}, {
						buff_hp
					})

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "LFKLFTe"))) do
						global.setEnterPauseTime(_env, global.GetOwner(_env, _env.ACTOR), card, 1500)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "LFKLFTe")(_env, _env.ACTOR) and global.FriendMaster(_env) and global.SpecialPropGetter(_env, "DaGun")(_env, global.FriendField(_env)) == 0 then
					global.DelayCall(_env, 500, global.AddAnimWithFlip, {
						loop = 1,
						anim = "ws_shuiruchang",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.FriendMaster(_env)) + {
							1,
							-1.4
						}
					})
					global.SummonDaGun(_env, _env.ACTOR, this.summonFactor, this.masterFactor, this.dmgFactor, this.YiyuFactor, this.HpFactor, this.GongpingFactor, this.abFactor, 1)
				end
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "LFKLFTe")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.INSTATUS(_env, "SummonedLFKLFTe")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
							local atkBuff = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, this.AtkFactor)

							global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
								timing = 0,
								display = "AtkUp",
								group = "Skill_LFKLFTe_Passive",
								duration = 99,
								limit = 1,
								tags = {
									"NUMERIC",
									"BUFF",
									"ATKUP",
									"DISPELLABLE",
									"UNSTEALABLE",
									"ATKUP_LFKLFTe"
								}
							}, {
								atkBuff
							}, 1)
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
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "LFKLFTe")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.INSTATUS(_env, "SummonedLFKLFTe")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeLeftFoot")(_env, unit) or global.INSTATUS(_env, "SummonedLFKLFTeRightFoot")(_env, unit) then
							global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_LFKLFTe_Passive", "DISPELLABLE"), 1)
						end
					end
				end
			end)

			return _env
		end
	}

	return _M
end
