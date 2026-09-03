-- chunkname: @/tmp/or_skill/lua_compile/Skill_XBKLDi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_XBKLDi_Normal = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill1"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Proud = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)
					local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, unit)

					if hpRatio < this.LessHp then
						heal = heal * 2
					end

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_Yiasong")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.3, 200)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.DelayCall(_env, 700, global.FocusCamera, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1, 400)
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.FriendDiedUnits(_env)
				local num = #units

				if units[num] then
					if global.MARKED(_env, "WARRIOR")(_env, units[num]) then
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							2,
							5,
							1,
							3,
							4,
							6,
							7,
							8,
							9
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					else
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							7,
							8,
							9,
							4,
							6,
							5,
							1,
							3,
							2
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					end
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
	_M.__all__.Skill_XBKLDi_Passive = {
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

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RpDamageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Proud_EX = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)
					local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, unit)

					if hpRatio < this.LessHp then
						heal = heal * 2
					end

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Unique_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_Yiasong")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.3, 200)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.FriendDiedUnits(_env)
				local num = #units

				if units[num] then
					if global.MARKED(_env, "WARRIOR")(_env, units[num]) then
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							2,
							5,
							1,
							3,
							4,
							6,
							7,
							8,
							9
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					else
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							7,
							8,
							9,
							4,
							6,
							5,
							1,
							3,
							2
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "Skill_XBKLDi_Unique")(_env, _env.unit) then
					local buffeft = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_XBKLDi_Unique",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_XBKLDi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Passive_EX = {
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

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RpDamageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "XBKLDi"))) do
						local cost = global.GetCardCost(_env, card)
						local cardvaluechange = global.CardCostEnchant(_env, "-", 4, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"Skill_BLTu_PGNNi",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Passive_Awaken = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DISPELLABLE", "CURSE"), 99)
				end

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, this.RpDamageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Unique_Awaken = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_Yiasong")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.3, 200)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				this.XBKLDi_Unique_func_HPRecovery_ALll(_env, _env.ACTOR)

				local units = global.FriendDiedUnits(_env)
				local num = #units

				if units[num] then
					if global.MARKED(_env, "WARRIOR")(_env, units[num]) then
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							2,
							5,
							1,
							3,
							4,
							6,
							7,
							8,
							9
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					else
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							7,
							8,
							9,
							4,
							6,
							5,
							1,
							3,
							2
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end,
		XBKLDi_Unique_func_HPRecovery_ALll = function(_env, actor)
			local this, global = _env.this, _env.global

			for _, unit in global.__iter__(global.AllUnits(_env)) do
				local heal = global.EvalRecovery_FlagCheck(_env, actor, unit, this.hp_recovery, 0)

				global.ApplyHPRecovery_ResultCheck(_env, actor, unit, heal)
			end
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "Skill_XBKLDi_Unique")(_env, _env.unit) then
					local buffeft = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_XBKLDi_Unique",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_XBKLDi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XBKLDi_Unique_SelfAwaken = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_Yiasong")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.3, 200)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				this.XBKLDi_Unique_func_HPRecovery_ALll(_env, _env.ACTOR)

				local units = global.FriendDiedUnits(_env)
				local num = #units

				if units[num] then
					if global.MARKED(_env, "WARRIOR")(_env, units[num]) then
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							2,
							5,
							1,
							3,
							4,
							6,
							7,
							8,
							9
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					else
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							7,
							8,
							9,
							4,
							6,
							5,
							1,
							3,
							2
						}, units[num])

						if reviveunit then
							global.AddStatus(_env, reviveunit, "Skill_XBKLDi_Unique")
						end
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end,
		XBKLDi_Unique_func_HPRecovery_ALll = function(_env, actor)
			local this, global = _env.this, _env.global

			for _, unit in global.__iter__(global.AllUnits(_env)) do
				global.print(_env, "宋阿姨觉醒大招加血角色==", global.GetUnitCid(_env, unit))
				global.SelfEX_Cure_OneStage_Choice(_env, actor, unit, false)

				local heal = global.EvalRecovery_FlagCheck(_env, actor, unit, this.hp_recovery, 0)

				global.ApplyHPRecovery_ResultCheck(_env, actor, unit, heal)
			end
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "Skill_XBKLDi_Unique")(_env, _env.unit) then
					local buffeft = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_XBKLDi_Unique",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"Skill_XBKLDi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	return _M
end
