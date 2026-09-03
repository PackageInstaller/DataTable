-- chunkname: @/tmp/or_skill/lua_compile/SelfEXTemplate.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__

	function _M.__all__.SelfEX_Curse_OneStage_Reflex(_env, actor)
		local this, global = _env.this, _env.global
		local debuff_friend

		for _, unit in global.__iter__(global.FriendUnits(_env)) do
			if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF")) > 0 then
				debuff_friend = unit
			end
		end

		if debuff_friend and global.IsAlive(_env, debuff_friend) then
			local Eunit = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS - global.SUMMONS))[1]

			if Eunit then
				local PassiveBuff = global.PassiveFunEffectBuff(_env, "SelfEX_Curse_OneStage_Reflex_SubSkill", {
					unit = debuff_friend
				})

				global.ApplyBuff_Buff(_env, actor, Eunit, {
					timing = 0,
					duration = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					PassiveBuff
				})
				global.ActivateGlobalTrigger(_env, debuff_friend, "REFLEX_STEALBUFF", {
					unit = debuff_friend
				})
			end
		end
	end

	_M.__all__.SelfEX_Curse_OneStage_Reflex_SubSkill = {
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

				global.print(_env, "开始转移buff===")
				global.StealBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "DEBUFF"), 1)

				local nilBuff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"nil"
					}
				}, {
					nilBuff
				})
			end)

			return _env
		end
	}

	function _M.__all__.SelfEX_Curse_OneStage_AtkDown(_env, actor, AtkDownFactor, selfcost, rate)
		local this, global = _env.this, _env.global

		for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, global.EnemyField(_env)))) do
			if card then
				local value = global.GetCardCost(_env, card)

				if value < selfcost then
					local buff = global.NumericEffect(_env, "-atkrate", {
						"+Normal",
						"+Normal"
					}, global.UnitPropGetter(_env, "atk")(_env, actor) * AtkDownFactor / global.GetHeroCardAttr(_env, card, "atk") * rate)

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
						timing = 0,
						display = "AtkDown",
						duration = 99,
						limit = 1,
						tags = {
							"DEBUFF",
							"ATKDOWN",
							"CARDBUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buff
					}, "week_shoupaitishi")
				elseif selfcost <= value then
					local buff = global.NumericEffect(_env, "-atkrate", {
						"+Normal",
						"+Normal"
					}, global.UnitPropGetter(_env, "atk")(_env, actor) * AtkDownFactor / global.GetHeroCardAttr(_env, card, "atk"))

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
						timing = 0,
						display = "AtkDown",
						duration = 99,
						limit = 1,
						tags = {
							"DEBUFF",
							"ATKDOWN",
							"CARDBUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buff
					}, "week_shoupaitishi")
				end
			end
		end
	end

	function _M.__all__.SelfEX_Cure_OneStage_Choice(_env, actor, unit, allChoice)
		local this, global = _env.this, _env.global
		local buffFactor = {
			def = 0.11,
			atk = 0.033
		}
		local unit_hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, unit)
		local actor_atk = global.UnitPropGetter(_env, "atk")(_env, actor) * buffFactor.atk
		local actor_def = global.UnitPropGetter(_env, "def")(_env, actor) * buffFactor.def

		if allChoice then
			if global.MARKED(_env, "XBKLDi")(_env, actor) then
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff3(_env, actor, unit)
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff4(_env, actor, unit)
			else
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff1(_env, actor, unit, actor_atk)
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff2(_env, actor, unit, actor_def)
			end
		elseif ((global.MARKED(_env, "XBKLDi")(_env, actor) or nil) and global.UnitPropGetter(_env, "hpRatio")(_env, actor)) >= 0.5 then
			if global.MARKED(_env, "XBKLDi")(_env, actor) then
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff4(_env, actor, unit)
			else
				global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff1(_env, actor, unit, actor_atk)
			end
		elseif global.MARKED(_env, "XBKLDi")(_env, actor) then
			global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff3(_env, actor, unit)
		else
			global.SelfEX_Cure_OneStage_Choice_SubFunction_Buff2(_env, actor, unit, actor_def)
		end
	end

	function _M.__all__.SelfEX_Cure_OneStage_Choice_SubFunction_Buff1(_env, actor, unit, atk)
		local this, global = _env.this, _env.global
		local buff1 = global.NumericEffect(_env, "+atk", {
			"+Normal",
			"+Normal"
		}, atk)

		global.ApplyBuff_Buff(_env, actor, unit, {
			duration = 99,
			display = "AtkUp",
			group = "SelfEX_Cure_OneStage_Choice_SubFunction_Buff1",
			timing = 0,
			limit = 6,
			tags = {
				"BUFF",
				"DISPELLABLE",
				"STEALABLE"
			}
		}, {
			buff1
		})
	end

	function _M.__all__.SelfEX_Cure_OneStage_Choice_SubFunction_Buff2(_env, actor, unit, def)
		local this, global = _env.this, _env.global
		local buff2 = global.NumericEffect(_env, "+def", {
			"+Normal",
			"+Normal"
		}, def)

		global.ApplyBuff_Buff(_env, actor, unit, {
			duration = 99,
			display = "DefUp",
			group = "SelfEX_Cure_OneStage_Choice_SubFunction_Buff2",
			timing = 0,
			limit = 6,
			tags = {
				"BUFF",
				"DISPELLABLE",
				"STEALABLE"
			}
		}, {
			buff2
		})
	end

	function _M.__all__.SelfEX_Cure_OneStage_Choice_SubFunction_Buff3(_env, actor, unit)
		local this, global = _env.this, _env.global
		local Victim = global.LoadUnit(_env, unit, "ALL")
		local attacker = global.LoadUnit(_env, actor, "ALL")
		local prob = global.EvalProb1(_env, attacker, Victim, 0.22, 0.11)

		if global.GetSide(_env, unit) ~= global.GetSide(_env, actor) and global.ProbTest(_env, prob) then
			global.print(_env, "宋阿姨二觉给谁加了诅咒==", global.GetUnitCid(_env, unit))

			local buff3 = global.Curse(_env)

			global.ApplyBuff_Debuff(_env, actor, unit, {
				duration = 1,
				display = "Poison",
				group = "SelfEX_Cure_OneStage_Choice_SubFunction_Buff3",
				timing = 3,
				limit = 1,
				tags = {
					"Curse",
					"DISPELLABLE",
					"STEALABLE",
					"DEBUFF"
				}
			}, {
				buff3
			})
		end
	end

	function _M.__all__.SelfEX_Cure_OneStage_Choice_SubFunction_Buff4(_env, actor, unit)
		local this, global = _env.this, _env.global

		if global.GetSide(_env, unit) == global.GetSide(_env, actor) and global.ProbTest(_env, global.UnitPropGetter(_env, "effectrate")(_env, actor) + 0.25) and (global.MARKED(_env, "defense")(_env, unit) or global.MARKED(_env, "cure")(_env, unit)) then
			global.print(_env, "宋阿姨二觉给谁加了暴击==", global.GetUnitCid(_env, unit))

			local buff4 = global.NumericEffect(_env, "+critrate", {
				"+Normal",
				"+Normal"
			}, 0.15)

			global.ApplyBuff_Buff(_env, actor, unit, {
				duration = 99,
				display = "CritRateUp",
				group = "SelfEX_Cure_OneStage_Choice_SubFunction_Buff4",
				timing = 0,
				limit = 3,
				tags = {
					"BUFF",
					"DISPELLABLE",
					"STEALABLE"
				}
			}, {
				buff4
			})
		end
	end

	function _M.__all__.SelfEX_Cure_OneStage_Secret(_env, actor)
		local this, global = _env.this, _env.global
		local pbuff = global.PassiveFunEffectBuff(_env, "SelfEX_Cure_OneStage_Secret_SubSkill")

		global.ApplyBuff_Buff(_env, actor, actor, {
			duration = 99,
			group = "SelfEX_Cure_OneStage_Secret",
			timing = 0,
			limit = 1,
			tags = {
				"SelfEX_Cure_OneStage_Secret"
			}
		}, {
			pbuff
		})
	end

	_M.__all__.SelfEX_Cure_OneStage_Secret_SubSkill = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local num = global.GetFriendField(_env, _env.ACTOR, "SelfEX_Cure_OneStage_Secret_SubSkill")

				if num > 0 then
					return
				end

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.SUMMONS(_env, _env.unit) == false and _env.event.isRevive == nil then
					global.SelfEX_Cure_OneStage_Secret_Sub(_env, _env.ACTOR, _env.unit)
					global.SetFriendField(_env, _env.ACTOR, num + 1, "SelfEX_Cure_OneStage_Secret_SubSkill")
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "SelfEX_Cure_OneStage_Secret"), 99)
				end
			end)

			return _env
		end
	}

	function _M.__all__.SelfEX_Cure_OneStage_Secret_Sub(_env, actor, unit)
		local this, global = _env.this, _env.global
		local effect = {
			global.SelfEX_Cure_OneStage_Secret_SubFunction_Buff1,
			global.SelfEX_Cure_OneStage_Secret_SubFunction_Buff2,
			global.SelfEX_Cure_OneStage_Secret_SubFunction_Buff3
		}

		effect[global.Random(_env, 1, 3)](_env, actor, unit)
	end

	function _M.__all__.SelfEX_Cure_OneStage_Secret_SubFunction_Buff1(_env, actor, unit)
		local this, global = _env.this, _env.global
		local buff1 = global.NumericEffect(_env, "-atkrate", {
			"+Normal",
			"+Normal"
		}, 0.2)

		global.ApplyBuff_Buff(_env, actor, unit, {
			timing = 0,
			duration = 99,
			display = "AtkDown",
			tags = {
				"DEBUFF",
				"DISPELLABLE",
				"STEALABLE"
			}
		}, {
			buff1
		})
	end

	function _M.__all__.SelfEX_Cure_OneStage_Secret_SubFunction_Buff2(_env, actor, unit)
		local this, global = _env.this, _env.global

		if global.FriendMaster(_env) then
			local buff2 = global.SpecialNumericEffect(_env, "+SelfEX_Cure_OneStage_Secret_SubFunction_Buff2", {
				"?Normal"
			}, 1)

			global.ApplyBuff_Buff(_env, actor, unit, {
				timing = 4,
				duration = 20,
				tags = {
					"SelfEX_Cure_OneStage_Secret_SubFunction_Buff2",
					"DEBUFF",
					"DISPELLABLE",
					"STEALABLE"
				}
			}, {
				buff2
			})
		end
	end

	function _M.__all__.SelfEX_Cure_OneStage_Secret_SubFunction_Buff3(_env, actor, unit)
		local this, global = _env.this, _env.global
		local buff3 = global.NumericEffect(_env, "-def", {
			"+Normal",
			"+Normal"
		}, 0)

		global.ApplyBuff_Buff(_env, actor, unit, {
			timing = 0,
			duration = 99,
			display = "NoKick",
			tags = {
				"UnKick",
				"DEBUFF",
				"DISPELLABLE",
				"STEALABLE"
			}
		}, {
			buff3
		})
	end

	function _M.__all__.SelfEX_Defend_OneStage_Together(_env, actor)
		local this, global = _env.this, _env.global
		local friends = global.FriendUnits(_env, global.BACK_OF(_env, actor, true) * global.NEIGHBORS_OF(_env, actor) * global.COL_OF(_env, actor))

		if #friends > 0 then
			local pbuff = global.PassiveFunEffectBuff(_env, "SelfEX_Defend_OneStage_Together_SubSkill", {
				friend = actor
			})

			global.ApplyBuff_Buff(_env, actor, friends[1], {
				timing = 3,
				duration = 2,
				tags = {
					"BUFF",
					"DISPELLABLE",
					"STEALABLE",
					"SelfEX_Defend_OneStage_Together_SubSkill"
				}
			}, {
				pbuff
			})
		end
	end

	_M.__all__.SelfEX_Defend_OneStage_Together_SubSkill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.attacker = externs.attacker

			assert(_env.attacker ~= nil, "External variable `attacker` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.IsAlive(_env, _env.attacker) and global.IsAlive(_env, this.friend) and global.IsAlive(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "SelfEX_Defend_OneStage_Together_SubSkill")) > 0 then
					global.ApplyHPDamage_Check(_env, _env.attacker, this.friend, {
						1,
						1,
						0
					})
				end
			end)

			return _env
		end
	}

	function _M.__all__.SelfEX_Summon_OneStage_inherit(_env, unit)
		local this, global = _env.this, _env.global
		local pbuff = global.PassiveFunEffectBuff(_env, "SelfEX_Summon_OneStage_inherit_SubSkill")

		global.ApplyBuff_Buff(_env, unit, unit, {
			timing = 0,
			duration = 99,
			tags = {
				"DIE",
				"UNDISPELLABLE",
				"UNSTEALABLE"
			}
		}, {
			pbuff
		})
	end

	_M.__all__.SelfEX_Summon_OneStage_inherit_SubSkill = {
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
				local summons = global.FriendUnits(_env, global.SUMMONS)
				local unit

				if #summons > 0 then
					unit = global.RandomN(_env, 1, summons)[1]
				end

				if unit then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 0.08
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, {
						val = maxHp * 0.2
					})

					local buff1 = global.NumericEffect(_env, "+atk", {
						"+Normal",
						"+Normal"
					}, atk)
					local buff2 = global.MaxHpEffect(_env, maxHp * 0.2)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"BUFF",
							"DISPELLABLE",
							"UNSTEALABLE",
							"ATKUP"
						}
					}, {
						buff1
					})
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 0,
						duration = 99,
						display = "MaxHpUp",
						tags = {
							"BUFF",
							"DISPELLABLE",
							"UNSTEALABLE",
							"MaxHpUp"
						}
					}, {
						buff2
					})
				end
			end)

			return _env
		end
	}

	function _M.__all__.SelfEX_Support_OneStage_treasury(_env, unit, num)
		local this, global = _env.this, _env.global
		local position_list = {}

		position_list[#position_list + 1] = "SelfEX_Support_OneStage_treasury_SubSkill_Decoration"
		position_list[#position_list + 1] = "SelfEX_Support_OneStage_treasury_SubSkill_Boots"
		position_list[#position_list + 1] = "SelfEX_Support_OneStage_treasury_SubSkill_Top"
		position_list[#position_list + 1] = "SelfEX_Support_OneStage_treasury_SubSkill_Weapon"

		for i = 1, num do
			local pos = global.Random(_env, 1, #position_list)
			local position = position_list[pos]
			local pbuff = global.PassiveFunEffectBuff(_env, position)

			global.ApplyBuff_Buff(_env, unit, unit, {
				timing = 0,
				duration = 99,
				tags = {
					"Passive",
					"UNDISPELLABLE",
					"UNSTEALABLE"
				}
			}, {
				pbuff
			})
			global.TableRemove(_env, position_list, position)
		end
	end

	function _M.__all__.SelfEX_Support_OneStage_treasury_Subfun(_env, actor, att, position, times)
		local this, global = _env.this, _env.global

		times = times or 0

		if position == "Top" or position == "Decoration" then
			local buff1 = global.NumericEffect(_env, "+" .. att[1], {
				"+Normal",
				"+Normal"
			}, 0.075)

			global.ApplyBuff_Buff(_env, actor, actor, {
				duration = 1,
				timing = 1,
				limit = 2,
				display = att[2],
				tags = {
					"BUFF",
					"DISPELLABLE",
					"STEALABLE",
					position
				},
				group = position .. global.UnitPropGetter(_env, "hp")(_env, actor)
			}, {
				buff1
			})
		end

		if position == "Weapon" then
			local buff1 = global.NumericEffect(_env, "+" .. att[1], {
				"+Normal",
				"+Normal"
			}, 0.15)

			global.ApplyBuff_Buff(_env, actor, actor, {
				timing = 0,
				duration = 1 + times,
				display = att[2],
				tags = {
					"BUFF",
					"DISPELLABLE",
					"STEALABLE",
					position
				},
				group = position .. global.UnitPropGetter(_env, "hp")(_env, actor)
			}, {
				buff1
			})
		end

		if position == "Boots" then
			local buff1 = global.NumericEffect(_env, "+" .. att[1], {
				"+Normal",
				"+Normal"
			}, 0.075)

			global.ApplyBuff_Buff(_env, actor, actor, {
				timing = 0,
				duration = 1 + times,
				display = att[2],
				tags = {
					"BUFF",
					"DISPELLABLE",
					"STEALABLE",
					position
				},
				group = position .. global.UnitPropGetter(_env, "hp")(_env, actor)
			}, {
				buff1
			})
		end
	end

	_M.__all__.SelfEX_Support_OneStage_treasury_SubSkill_Decoration = {
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

				if global.GetSide(_env, _env.ACTOR) ~= global.GetSide(_env, _env.unit) and not global.SUMMONS(_env, _env.unit) then
					local att_list = {}

					att_list[1] = {
						"uneffectrate",
						"UnEffectRateUp"
					}
					att_list[2] = {
						"uncritrate",
						"UnCritRateUp"
					}
					att_list[3] = {
						"aoederate",
						"AoeUnHurtRateUp"
					}

					local pos = global.floor(_env, global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR)) % #att_list

					if pos == 0 then
						pos = global.Random(_env, 1, #att_list)
					end

					local att = att_list[pos]
					local num = 2

					if num > global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Decoration")) then
						global.SelfEX_Support_OneStage_treasury_Subfun(_env, _env.ACTOR, att, "Decoration")
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.SelfEX_Support_OneStage_treasury_SubSkill_Top = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.detail = externs.detail

			assert(_env.detail ~= nil, "External variable `detail` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.IsAlive(_env, _env.ACTOR) then
					return
				end

				local att_list = {}

				att_list[1] = {
					"defrate",
					"DefUp"
				}
				att_list[2] = {
					"unhurtrate",
					"UnHurtRateUp"
				}
				att_list[3] = {
					"blockrate",
					"BlockRateUp"
				}

				local pos = (_env.detail.eft + global.floor(_env, global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR))) % #att_list

				if pos == 0 then
					pos = global.Random(_env, 1, #att_list)
				end

				local att = att_list[pos]

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Top")) < 2 then
					global.SelfEX_Support_OneStage_treasury_Subfun(_env, _env.ACTOR, att, "Top")
				end
			end)

			return _env
		end
	}
	_M.__all__.SelfEX_Support_OneStage_treasury_SubSkill_Boots = {
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
				local att_list = {}

				att_list[1] = {
					"effectrate",
					"EffectRateUp"
				}
				att_list[2] = {
					"absorption",
					"Absorption"
				}
				att_list[3] = {
					"rprecvrate",
					"RageGainUp"
				}

				local att = att_list[global.Random(_env, 1, #att_list)]

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Boots")) < 2 then
					global.SelfEX_Support_OneStage_treasury_Subfun(_env, _env.ACTOR, att, "Boots")
				end
			end)

			return _env
		end
	}
	_M.__all__.SelfEX_Support_OneStage_treasury_SubSkill_Weapon = {
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
				local att_list = {}

				att_list[1] = {
					"hurtrate",
					"HurtRateUp"
				}
				att_list[2] = {
					"defweaken",
					"DefWeakenUp"
				}
				att_list[3] = {
					"unblockrate",
					"UnBlockRateUp"
				}
				att_list[4] = {
					"critrate",
					"CritRateUp"
				}

				local att = att_list[global.Random(_env, 1, #att_list)]
				local num = 2

				if num > global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Weapon")) then
					global.SelfEX_Support_OneStage_treasury_Subfun(_env, _env.ACTOR, att, "Weapon")

					if num > 2 then
						global.SelfEX_Support_OneStage_treasury_Subfun(_env, _env.ACTOR, att, "Weapon")
					end
				end
			end)

			return _env
		end
	}

	function _M.__all__.SelfEX_ASSASSIN_OneStage_Double(_env, actor)
		local this, global = _env.this, _env.global
		local buffeft2 = global.RageGainEffect(_env, "-", {
			"+Normal",
			"+Normal"
		}, 1)
		local buffeft3 = global.Diligent(_env)

		global.ApplyBuff(_env, actor, {
			timing = 2,
			duration = 1,
			tags = {
				"UNDISPELLABLE",
				"UNSTEALABLE"
			}
		}, {
			buffeft2,
			buffeft3
		})
		global.DiligentRound(_env, 100)
	end

	function _M.__all__.SelfEX_ASSASSIN_OneStage_Break(_env, actor, target)
		local this, global = _env.this, _env.global
		local applydamage = global.SpecialPropGetter(_env, "ApplyDamageValue")(_env, actor)
		local hp = global.UnitPropGetter(_env, "hp")(_env, target)
		local shield = global.UnitPropGetter(_env, "shield")(_env, target)
		local overdamage = applydamage - hp - shield

		if global.SelectBuffCount(_env, target, global.BUFF_MARKED(_env, "UNDEAD")) > 0 then
			overdamage = applydamage - hp - shield + 1
		end

		if ((global.SelectBuffCount(_env, target, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) > 0 or nil) and applydamage) > 0 then
			global.DispelBuff(_env, target, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)
		end
	end

	return _M
end
