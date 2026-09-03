-- chunkname: @/tmp/or_skill/lua_compile/Skill_SRen.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SRen_Normal = {
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
				}, 200, "skill1"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				damage = global.CheckCtrlExDmg(_env, _env.ACTOR, _env.TARGET, damage)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.3,
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

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					500
				}, global.SplitValue(_env, damage, {
					0.25,
					0.25,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.3,
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

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					500
				}, global.SplitValue(_env, damage, {
					0.25,
					0.25,
					0.5
				}))

				_env.friendunits = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if _env.friendunits[1] then
					for _, Funit in global.__iter__(_env.friendunits) do
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, Funit)
						local heal1 = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, Funit, 1.2, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, Funit, heal1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Unique = {
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
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

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
				1533
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					_env.num = global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD"))

					if _env.num > 1 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 2)
					end

					if _env.num == 1 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 1)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 1)
					end

					if _env.num == 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 2)
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Unique_EX = {
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
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

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
				1533
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)
				end

				for _, unit in global.__iter__(_env.units) do
					_env.num = global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD"))

					if _env.num > 1 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 2)
					end

					if _env.num == 1 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 1)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 1)
					end

					if _env.num == 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 2)
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Passive = {
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

				if this.count < 7 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.03)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"Skill_SRen_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					this.count = this.count + 1
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Passive_EX = {
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

				if this.count < 7 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.05)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"Skill_SRen_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					this.count = this.count + 1
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Unique_Awaken = {
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
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

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
				1533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 0.8

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local debuffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE")), 2)

					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)

					if debuffnum ~= 0 then
						global.ApplyHPRecovery(_env, unit, atk * debuffnum)
					end
				end

				for _, unit in global.__iter__(_env.units) do
					_env.num = global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD"))

					if _env.num > 1 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 2)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * 2)
						end
					end

					if _env.num == 1 then
						local buffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE")), 1)

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 1)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 1)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * (buffnum + 1))
						end
					end

					if _env.num == 0 then
						local buffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE")), 2)

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 2)

						if buffnum ~= 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * buffnum)
						end
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SRen_Unique_SelfAwaken = {
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
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

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
				1533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 0.8

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local debuffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE")), 2)

					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)

					if debuffnum ~= 0 then
						global.ApplyHPRecovery(_env, unit, atk * debuffnum)
					end
				end

				for _, unit in global.__iter__(_env.units) do
					_env.num = global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD"))

					if _env.num > 2 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 3)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * 2)
						end
					end

					if _env.num == 2 then
						local buffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE")), 1)

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 2)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 1)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * (buffnum + 1))
						end
					end

					if _env.num == 1 then
						local buffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE")), 2)

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "UNDEAD", "DISPELLABLE"), 1)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 2)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * (buffnum + 2))
						end
					end

					if _env.num == 0 then
						local buffnum = global.min(_env, global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE")), 3)

						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "DISPELLABLE"), 3)

						if buffnum ~= 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
							global.ApplyHPDamage(_env, unit, atk * buffnum)
						end
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
