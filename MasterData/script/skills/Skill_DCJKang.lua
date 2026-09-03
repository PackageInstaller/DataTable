-- chunkname: @/tmp/or_skill/lua_compile/Skill_DCJKang.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_DCJKang_Normal = {
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
				600
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
	_M.__all__.Skill_DCJKang_Proud = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				890
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if units[1] ~= nil then
					for _, unit in global.__iter__(units) do
						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage * this.DmgMinHp)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Proud_EX = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				890
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if units[1] ~= nil then
					for _, unit in global.__iter__(units) do
						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage * this.DmgMinHp)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Unique = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.8,
					0
				}, 100, "skill3"))
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friend in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS - global.ONESELF(_env, _env.ACTOR))) do
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft3 = global.Diligent(_env)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
						timing = 2,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2,
						buffeft3
					}, 1)
				end

				global.DiligentRound(_env)

				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR"))

				if cards[1] ~= nil then
					for _, card in global.__iter__(global.RandomN(_env, 1, cards)) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 1,
							tags = {
								"CARDBUFF",
								"skill Skill_DCJKang_Passive",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
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
	_M.__all__.Skill_DCJKang_Unique_EX = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.8,
					0
				}, 100, "skill3"))
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friend in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS)) do
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft3 = global.Diligent(_env)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
						timing = 2,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2,
						buffeft3
					}, 1)
				end

				global.DiligentRound(_env)

				for _, friend in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft5 = global.Taunt(_env)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
						timing = 2,
						duration = 3,
						display = "Taunt",
						tags = {
							"NUMERIC",
							"BUFF",
							"TAUNT",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft5
					}, 1)
				end

				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR"))

				if cards[1] ~= nil then
					for _, card in global.__iter__(global.RandomN(_env, 1, cards)) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 1,
							tags = {
								"CARDBUFF",
								"skill Skill_DCJKang_Passive",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
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
	_M.__all__.DCJKang_Kick = {
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

				if global.MARKED(_env, "DCJKang")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, unit_one in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive"), 99)
					end

					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "DCJKang_Kick"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Passive = {
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
				local buff = global.PassiveFunEffectBuff(_env, "DCJKang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"DCJKang_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft2 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft2
					}, 1)
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive")) > 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Passive_EX = {
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
				local buff = global.PassiveFunEffectBuff(_env, "DCJKang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"DCJKang_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft2 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft2
					}, 1)
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive")) > 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Passive_Awaken = {
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
				local buff = global.PassiveFunEffectBuff(_env, "DCJKang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"DCJKang_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
					local buffeft2 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft2
					}, 1)
				end

				if global.FriendMaster(_env) and global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "DCJKang_Passive_Awaken_Count")) < 5 and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
					local buffeft1 = global.DeathImmuneEffect(_env, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "Undead",
						group = "Skill_DCJKang_Passive2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDEAD",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft3 = global.SpecialNumericEffect(_env, "+DCJKang_Passive_Count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"DCJKang_Passive_Awaken_Count"
						}
					}, {
						buffeft3
					}, 1)
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive")) > 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Passive_Key = {
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

				for _, friend in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.MARKED(_env, "WARRIOR") - global.ONESELF(_env, _env.ACTOR)))) do
					global.ApplyRPRecovery(_env, friend, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_DCJKang_Passive_SelfAwaken = {
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
				local buff = global.PassiveFunEffectBuff(_env, "DCJKang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"DCJKang_Kick"
					}
				}, {
					buff
				})

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive_SelfAwaken",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft1
					}, 1)
				end

				for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS + global.MARKED(_env, "SUMMONER"))) do
					local buffeft = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor2)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive_SelfAwaken",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft
					}, 1)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS + global.MARKED(_env, "SUMMONER"))) do
					local buffeft = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor2)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive_SelfAwaken",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft
					}, 1)
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
					local buffeft2 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectionFactor1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_DCJKang_Passive1",
						timing = 0,
						limit = 1,
						tags = {
							"Skill_DCJKang_Passive_SelfAwaken",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE",
							"REFLECT1"
						}
					}, {
						buffeft2
					}, 1)
				end

				if global.FriendMaster(_env) and global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "DCJKang_Passive_Awaken_Count")) < 5 and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
					local buffeft1 = global.DeathImmuneEffect(_env, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "Undead",
						group = "Skill_DCJKang_Passive_SelfAwaken2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDEAD",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft3 = global.SpecialNumericEffect(_env, "+DCJKang_Passive_Count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"DCJKang_Passive_Awaken_Count"
						}
					}, {
						buffeft3
					}, 1)
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive_SelfAwaken")) > 0 then
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_DCJKang_Passive_SelfAwaken"), 1)
					end
				end
			end)

			return _env
		end
	}

	return _M
end
