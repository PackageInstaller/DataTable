-- chunkname: @/tmp/or_skill/lua_compile/LeadStage.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.LeadStage_Energy = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_XueZhan_skill = {
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

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local SummonedLengMo = global.Summon(_env, _env.ACTOR, "Summoned_LengMo", this.summonFactor, nil, {
						2,
						5,
						1,
						3,
						4,
						6,
						7,
						8,
						9
					})
					local SummonedHeiHei = global.Summon(_env, _env.ACTOR, "Summoned_HeiHei", this.summonFactor, nil, {
						7,
						9,
						8,
						4,
						6,
						5,
						1,
						3,
						2
					})

					if this.summonNum == 3 then
						local i = global.Random(_env, 1, 2)

						if i == 1 then
							local Summoned3 = global.Summon(_env, _env.ACTOR, "Summoned_LengMo", this.summonFactor, nil, {
								global.Random(_env, 1, 9)
							})
						else
							local Summoned3 = global.Summon(_env, _env.ACTOR, "Summoned_HeiHei", this.summonFactor, nil, {
								global.Random(_env, 1, 9)
							})
						end
					end

					local buff = global.RageGainEffect(_env, "+", {
						"+Normal",
						"+Normal"
					}, this.RageSpdFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"LeadStage_XueZhan_skill",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_LieSha_skill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, global.EnemyMaster(_env))
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local damage = 0

					damage = global.MARKED(_env, "Player_Master")(_env, global.EnemyMaster(_env)) and maxHp * this.MaxHpDamgeRate or global.min(_env, maxHp * this.MaxHpDamgeRate, atk * 5)

					global.AnimForTrgt(_env, global.EnemyMaster(_env), {
						loop = 1,
						anim = "baodian_shoujibaodian",
						zOrder = "TopLayer",
						pos = {
							0.5,
							0.5
						}
					})
					global.ApplyRealDamage(_env, _env.ACTOR, global.EnemyMaster(_env), 1, 1, 0, 0, 0, nil, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_BiLei_skill = {
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

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+uncritrate", {
						"+Normal",
						"+Normal"
					}, this.UnCritRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "LeadStage_BiLei",
						tags = {
							"NUMERIC",
							"BUFF",
							"LeadStage_BiLei_skill",
							"AOEDERATEUP",
							"UNCRITRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_FuHun_skill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.AnimForTrgt(_env, _env.ACTOR, {
							loop = 1,
							anim = "cx_nengliangchongji",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_SenLing_skill = {
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

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local buff = global.PassiveFunEffectBuff(_env, "LeadStage_SenLing_skill_For_Field", {
						RecoveryFactor = this.RecoveryFactor,
						Time = this.Time
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"LeadStage_SenLing_skill_Ready"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_SenLing_skill_For_Field = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "LeadStage_SenLing_skill_Ready") then
					local buff_start = global.SpecialNumericEffect(_env, "+LeadStage_SenLing_start", {
						"+Normal",
						"+Normal"
					}, 1)
					local buff_show = global.SpecialNumericEffect(_env, "+LeadStage_SenLing", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						duration = 2,
						display = "LeadStage_SenLing_Start",
						tags = {
							"LeadStage_SenLing_skill_Start"
						}
					}, {
						buff_start
					})
					global.DelayCall(_env, 600, global.ApplyBuff, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "LeadStage_SenLing",
						tags = {
							"LeadStage_SenLing_skill",
							"Magic_Circle"
						}
					}, {
						buff_show
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "LeadStage_SenLing_skill", "Magic_Circle"), 99)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "LeadStage_SenLing_skill", "Magic_Circle")) > 0 then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

						global.ApplyHPRecovery(_env, unit, maxHp * this.RecoveryFactor, true)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.LeadStage_LiMing_skill = {
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

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end
			end)

			return _env
		end
	}

	return _M
end
