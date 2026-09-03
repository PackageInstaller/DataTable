-- chunkname: @/tmp/or_skill/lua_compile/Skill_QBTe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_QBTe_Normal = {
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
				634
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
	_M.__all__.Skill_QBTe_Proud = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 200, "skill2"))
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ExDmgFactor = global.SpecialPropGetter(_env, "exfactor")(_env, _env.ACTOR)

				if #_env.units == 2 then
					global.LoveDaze(_env, _env.units[1], _env.units[2])
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #_env.units == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local animarray = global.GetAttackEffects(_env, _env.ACTOR)

					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_QBTe_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units_top = global.EnemyUnits(_env, global.TOP_COL)
				local units_mid = global.EnemyUnits(_env, global.MID_COL)
				local units_bottom = global.EnemyUnits(_env, global.BOTTOM_COL)
				local ExDmgFactor = global.SpecialPropGetter(_env, "exfactor")(_env, _env.ACTOR)

				if #units_top == 2 then
					global.LoveDaze(_env, units_top[1], units_top[2])
				end

				if #units_mid == 2 then
					global.LoveDaze(_env, units_mid[1], units_mid[2])
				end

				if #units_bottom == 2 then
					global.LoveDaze(_env, units_bottom[1], units_bottom[2])
				end

				local animarray = global.GetAttackEffects(_env, _env.ACTOR)

				for _, unit in global.__iter__(units_top) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_top == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_mid) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_mid == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_bottom) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_bottom == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_QBTe_Passive = {
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

				global.AddStatus(_env, _env.ACTOR, "Skill_QBTe_Passive")
			end)

			return _env
		end
	}

	function _M.__all__.LoveDaze(_env, unit1, unit2)
		local this, global = _env.this, _env.global
		local buffeft = global.Daze(_env)

		global.ApplyBuff_Debuff(_env, _env.ACTOR, unit1, {
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
			buffeft
		}, 1, 0)
		global.ApplyBuff_Debuff(_env, _env.ACTOR, unit2, {
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
			buffeft
		}, 1, 0)

		local animarray = global.GetAttackEffects(_env, _env.ACTOR)

		if global.CellRowLocation(_env, global.GetCell(_env, unit1)) == 1 and global.CellRowLocation(_env, global.GetCell(_env, unit2)) == 3 then
			global.AnimForTrgt(_env, unit1, {
				loop = 1,
				zOrder = "TopLayer",
				pos = {
					-0.6,
					0.5
				},
				anim = animarray[2]
			})
		else
			global.AnimForTrgt(_env, unit1, {
				loop = 1,
				zOrder = "TopLayer",
				pos = {
					-0.1,
					0.5
				},
				anim = animarray[2]
			})
		end
	end

	_M.__all__.Skill_QBTe_Proud_EX = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 200, "skill2"))
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ExDmgFactor = global.SpecialPropGetter(_env, "exfactor")(_env, _env.ACTOR)

				if #_env.units == 2 then
					global.LoveDaze(_env, _env.units[1], _env.units[2])
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #_env.units == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local animarray = global.GetAttackEffects(_env, _env.ACTOR)

					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_QBTe_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units_top = global.EnemyUnits(_env, global.TOP_COL)
				local units_mid = global.EnemyUnits(_env, global.MID_COL)
				local units_bottom = global.EnemyUnits(_env, global.BOTTOM_COL)
				local ExDmgFactor = global.SpecialPropGetter(_env, "exfactor")(_env, _env.ACTOR)

				if #units_top == 2 then
					global.LoveDaze(_env, units_top[1], units_top[2])
				end

				if #units_mid == 2 then
					global.LoveDaze(_env, units_mid[1], units_mid[2])
				end

				if #units_bottom == 2 then
					global.LoveDaze(_env, units_bottom[1], units_bottom[2])
				end

				local animarray = global.GetAttackEffects(_env, _env.ACTOR)

				for _, unit in global.__iter__(units_top) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_top == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_mid) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_mid == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_bottom) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_bottom == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_QBTe_Passive_EX = {
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

				global.AddStatus(_env, _env.ACTOR, "Skill_QBTe_Passive_EX")

				local buffeft1 = global.SpecialNumericEffect(_env, "+exfactor", {
					"?Normal"
				}, this.ExFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_QBTe_Passive_EX",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_QBTe_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_QBTe_Unique_Awaken = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units_top = global.EnemyUnits(_env, global.TOP_COL)
				local units_mid = global.EnemyUnits(_env, global.MID_COL)
				local units_bottom = global.EnemyUnits(_env, global.BOTTOM_COL)
				local ExDmgFactor = global.SpecialPropGetter(_env, "exfactor")(_env, _env.ACTOR)

				if #units_top == 2 then
					global.LoveDaze(_env, units_top[1], units_top[2])
				end

				if #units_mid == 2 then
					global.LoveDaze(_env, units_mid[1], units_mid[2])
				end

				if #units_bottom == 2 then
					global.LoveDaze(_env, units_bottom[1], units_bottom[2])
				end

				if #units_top == 1 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_top[1], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				if #units_mid == 1 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_mid[1], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				if #units_bottom == 1 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_bottom[1], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				if #units_top == 3 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_top[3], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				if #units_mid == 3 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_mid[3], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				if #units_mid == 3 then
					local buffeft1 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, units_mid[3], {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local animarray = global.GetAttackEffects(_env, _env.ACTOR)
				local units_sis = global.FriendDiedUnits(_env, global.MARKED(_env, "PSKe"))
				local units_alive = global.FriendUnits(_env, global.MARKED(_env, "PSKe"))

				for _, unit in global.__iter__(units_top) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_top == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					if units_sis[1] or units_alive[1] then
						damage.val = damage.val * (1 - this.RealDamageFactor) + global.EvalRealDamage(_env, _env.ACTOR, unit, 2, 1, this.dmgFactor[2], 0, 0, damage) * this.RealDamageFactor
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_mid) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_mid == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					if units_sis[1] or units_alive[1] then
						damage.val = damage.val * (1 - this.RealDamageFactor) + global.EvalRealDamage(_env, _env.ACTOR, unit, 2, 1, this.dmgFactor[2], 0, 0, damage) * this.RealDamageFactor
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end

				for _, unit in global.__iter__(units_bottom) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if #units_bottom == 2 and global.INSTATUS(_env, "Skill_QBTe_Passive_EX")(_env, _env.ACTOR) then
						damage.val = damage.val * (1 + ExDmgFactor)
					end

					if units_sis[1] or units_alive[1] then
						damage.val = damage.val * (1 - this.RealDamageFactor) + global.EvalRealDamage(_env, _env.ACTOR, unit, 2, 1, this.dmgFactor[2], 0, 0, damage) * this.RealDamageFactor
					end

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AddAnim(_env, {
						loop = 1,
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit),
						anim = animarray[1]
					})
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
