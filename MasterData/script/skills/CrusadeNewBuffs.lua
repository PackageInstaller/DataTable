-- chunkname: @/tmp/or_skill/lua_compile/CrusadeNewBuffs.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.CrusadeNewBuffs_AOEBasisAttackUp = {
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
					-- block empty
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					local buffeft2 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.AOEBasisAttUpFactor2)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_AOEBasisAttackUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOE",
							"ATKRATE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_ATTBasisAttackUp = {
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
					-- block empty
				elseif global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ATTBasisAttUpFactor1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_ATTBasisAttackUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKRATE",
							"ATTACK"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_DEFEnterShield = {
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
					-- block empty
				elseif global.MARKED(_env, "WARRIOR")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.DEFEnterShieldFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						display = "Shield",
						group = "CrusadeNewBuffs_DEFEnterShield",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_DEFReboundUp = {
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
					-- block empty
				elseif global.MARKED(_env, "WARRIOR")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.DEFReboundUpFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Reflect",
						group = "CrusadeNewBuffs_DEFReboundUp",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"REFLECTION",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_CUREEffevtimprove = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_RatioCheck", {
						"+Normal",
						"+Normal"
					}, this.CURETreatedTriFactor)
					local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_ExtraRate", {
						"+Normal",
						"+Normal"
					}, this.CUREEffevtFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						display = "BeCureRateUp",
						group = "CrusadeNewBuffs_CUREEffevtimprove",
						duration = 1,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_CUREEnterSpend = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
						if global.MARKED(_env, "HEALER")(_env, card) then
							local cardvaluechange = global.CardCostEnchant(_env, "-", this.CUREEnterSpendFactor, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE"
								}
							}, {
								cardvaluechange
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_BasisSuppress = {
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
					-- block empty
				elseif global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_hurtrate", {
						"?Normal"
					}, this.BasisSuppressFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_BasisSuppress",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Warrior_DmgExtra_hurtrate", {
						"?Normal"
					}, this.BasisSuppressFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_BasisSuppress",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				elseif global.MARKED(_env, "WARRIOR")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
						"?Normal"
					}, this.BasisSuppressFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_BasisSuppress",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_SpecialSuppress = {
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
					-- block empty
				elseif global.MARKED(_env, "HEALER")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft2 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft3 = global.SpecialNumericEffect(_env, "+Warrior_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft4 = global.SpecialNumericEffect(_env, "+Summoner_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft5 = global.SpecialNumericEffect(_env, "+Healer_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_BasisSuppress",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5
					})
				elseif global.MARKED(_env, "SUMMONER")(_env, _env.ACTOR) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft2 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft3 = global.SpecialNumericEffect(_env, "+Warrior_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft4 = global.SpecialNumericEffect(_env, "+Summoner_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)
					local buffeft5 = global.SpecialNumericEffect(_env, "+Healer_DmgExtra_hurtrate", {
						"?Normal"
					}, this.SpecialSuppressFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_BasisSuppress",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_LowEnergyBasisUp = {
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
					-- block empty
				elseif global.GetCost(_env, _env.ACTOR) < this.LowEnergyFactor then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.LowEnergyAttFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.LowEnergyLifeFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_LowEnergyBasisUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeNewBuffs_LowEnergyBasisUp",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_HighEnergyBasisUp = {
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
					-- block empty
				elseif global.GetCost(_env, _env.ACTOR) > this.HighEnergyFactor then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.HighEnergyAttFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.HighEnergyLifeFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeNewBuffs_HighEnergyBasisUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeNewBuffs_HighEnergyBasisUp",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_TauntedWeaken = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "-PROVOKE_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.TauntedWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_DazedWeaken = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+DAZE_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DazedWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_CritHurtrateUp = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "-hurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnCritHurtrateFactor)
					local buffeft2 = global.NumericEffect(_env, "+critstrg", {
						"+Normal",
						"+Normal"
					}, this.CritHurtrateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.unit) then
					-- block empty
				else
					local buffeft3 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnCritHurtrateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 1,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft3
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_ProudSkillProUp = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
						"+Normal",
						"+Normal"
					}, this.ProudSkillProUpFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_CurseProudSkillProUp = {
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
					-- block empty
				elseif global.MARKED(_env, "HEALER")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
						"+Normal",
						"+Normal"
					}, this.CurseProudSkillProUpFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_SupProudSkillProUp = {
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
					-- block empty
				elseif global.MARKED(_env, "SUMMONER")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
						"+Normal",
						"+Normal"
					}, this.SupProudSkillProUpFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_PlayerWeaken = {
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
					-- block empty
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.PlayerWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "",
						group = "CrusadeNewBuffs_PlayerWeaken",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"MASTER"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_CureDefWeaken = {
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
					-- block empty
				elseif global.MARKED(_env, "HEALER")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.CureDefWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "",
						group = "CrusadeNewBuffs_CureDefWeaken",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_AttLowHPAttackUp = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR and global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
					if _env.prevHpPercent >= this.AttHPFactor and _env.curHpPercent < this.AttHPFactor then
						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.AttLowHPAttackUpFactor)
						local buffeft2 = global.NumericEffect(_env, "+absorption", {
							"+Normal",
							"+Normal"
						}, this.AttHPSuckUpFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "CrusadeNewBuffs_AttLowHPAttackUp",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						})
					end

					if _env.prevHpPercent < this.AttHPFactor and _env.curHpPercent >= this.AttHPFactor then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "CrusadeNewBuffs_AttLowHPAttackUp", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeNewBuffs_LowEnergyLower = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_COST_LE(_env, this.LowEnergyFactor - 1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.LowEnergyLowerFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_HigherThanX"
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
	_M.__all__.CrusadeNewBuffs_ATTAOEAttWeaken = {
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
					-- block empty
				elseif global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "-hurtrate", {
						"+Normal",
						"+Normal"
					}, this.ATTAOEWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "",
						group = "CrusadeNewBuffs_ATTAOEAttWeaken",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "-hurtrate", {
						"+Normal",
						"+Normal"
					}, this.ATTAOEWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "",
						group = "CrusadeNewBuffs_ATTAOEAttWeaken",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				else
					local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.OtherUpFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "",
						group = "CrusadeNewBuffs_ATTAOEAttWeaken",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}

	return _M
end
