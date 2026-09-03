-- chunkname: @/tmp/or_skill/lua_compile/Skill_FLBDSi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_FLBDSi_Normal = {
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
	_M.__all__.Skill_FLBDSi_Proud = {
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
					-1.9,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.SUMMONS), ">", global.UnitPropGetter(_env, "atk")), 1, 1)) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Proud",
						duration = 99,
						limit = 3,
						tags = {
							"Skill_FLBDSi_Proud",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLBDSi_Unique = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				3067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local buffeft2 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.HpRateFactor, atk * 2))

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Unique_AtkRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_FLBDSi_Unique_MaxHpRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end

				for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local maxHp = global.GetHeroCardAttr(_env, card, "maxHp")
					local buffeft2 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.HpRateFactor, atk * 2))

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Unique_AtkRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_FLBDSi_Unique_MaxHpRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.FlyBallEffect(_env, _env.ACTOR, card)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLBDSi_Passive = {
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

				for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "FLBDSi"))) do
					global.addHeroCardSeatRules(_env, global.GetOwner(_env, _env.ACTOR), card, {
						"HEALER",
						"MAGE",
						"SUMMONER"
					}, {
						"kick",
						"kick",
						"kick"
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.newunit = externs.newunit

			assert(_env.newunit ~= nil, "External variable `newunit` is not provided.")

			_env.dierule = externs.dierule

			assert(_env.dierule ~= nil, "External variable `dierule` is not provided.")

			_env.UnKickTag = externs.UnKickTag

			assert(_env.UnKickTag ~= nil, "External variable `UnKickTag` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "FLBDSi")(_env, _env.newunit) and _env.dierule == "kick" and global.MASTER(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					if _env.UnKickTag > 0 then
						return
					end

					local cardlocation = global.GetCardWindowIndex(_env, _env.newunit)

					if cardlocation == 0 then
						cardlocation = global.Random(_env, 1, 4)
					end

					local card = global.BackToCard_ResultCheck(_env, _env.unit, "window", cardlocation)
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_FLBDSi_Passive"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "FLBDSi")(_env, _env.unit) and global.MASTER(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_FLBDSi_Passive")) > 0 then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "FLBDSi"))) do
						global.clearHeroCardSeatRules(_env, global.GetOwner(_env, _env.ACTOR), card, {
							"LIGHT",
							"MAGE",
							"SUMMONER"
						}, {
							"kick",
							"kick",
							"kick"
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLBDSi_Proud_EX = {
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
					-1.9,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				for _, unit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.SUMMONS), ">", global.UnitPropGetter(_env, "atk")), 1, 1)) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Proud",
						duration = 99,
						limit = 3,
						tags = {
							"Skill_FLBDSi_Proud",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLBDSi_Unique_EX = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				3067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local buffeft2 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.HpRateFactor, atk * 2))

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Unique_AtkRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_FLBDSi_Unique_MaxHpRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end

				for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local maxHp = global.GetHeroCardAttr(_env, card, "maxHp")
					local buffeft2 = global.MaxHpEffect(_env, global.min(_env, maxHp * this.HpRateFactor, atk * 2))

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLBDSi_Unique_AtkRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						display = "MaxHpUp",
						group = "Skill_FLBDSi_Unique_MaxHpRate",
						duration = 99,
						limit = 2,
						tags = {
							"Skill_FLBDSi_Unique",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.FlyBallEffect(_env, _env.ACTOR, card)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLBDSi_Passive_EX = {
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

				for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "FLBDSi"))) do
					global.addHeroCardSeatRules(_env, global.GetOwner(_env, _env.ACTOR), card, {
						"HEALER",
						"MAGE",
						"SUMMONER"
					}, {
						"kick",
						"kick",
						"kick"
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.newunit = externs.newunit

			assert(_env.newunit ~= nil, "External variable `newunit` is not provided.")

			_env.dierule = externs.dierule

			assert(_env.dierule ~= nil, "External variable `dierule` is not provided.")

			_env.UnKickTag = externs.UnKickTag

			assert(_env.UnKickTag ~= nil, "External variable `UnKickTag` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "FLBDSi")(_env, _env.newunit) and _env.dierule == "kick" and global.MASTER(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					if _env.UnKickTag > 0 then
						return
					end

					local cardlocation = global.GetCardWindowIndex(_env, _env.newunit)

					if cardlocation == 0 then
						cardlocation = global.Random(_env, 1, 4)
					end

					local card = global.BackToCard_ResultCheck(_env, _env.unit, "window", cardlocation)
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_FLBDSi_Passive"
						}
					}, {
						buff
					})

					local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

					if card then
						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_FLBDSi_Passive_EX"
							}
						}, {
							cardvaluechange
						})
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "FLBDSi")(_env, _env.unit) and global.MASTER(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_FLBDSi_Passive")) > 0 then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "FLBDSi"))) do
						global.clearHeroCardSeatRules(_env, global.GetOwner(_env, _env.ACTOR), card, {
							"LIGHT",
							"MAGE",
							"SUMMONER"
						}, {
							"kick",
							"kick",
							"kick"
						})
					end
				end
			end)

			return _env
		end
	}

	return _M
end
