-- chunkname: @/tmp/or_skill/lua_compile/Skill_FLYDe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_FLYDe_Normal = {
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
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PASSIVE_RP"), 99)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill2"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PASSIVE_RP"), 99)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Unique = {
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

			_env.kill = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
					global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				else
					global.GroundEft(_env, _env.ACTOR, "Ground_Xige")
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST"), 1)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.FixedPos(_env, 0, 0, 2), 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill3")), false)
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PASSIVE_RP"), 99)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if result and result.deadly == true then
						_env.kill = _env.kill + 1
					end
				end
			end)
			exec["@time"]({
				3033
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				3867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				4000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown) * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				4700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Passive = {
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
				local rp_enter = global.UnitPropGetter(_env, "rp")(_env, _env.ACTOR)

				if rp_enter < 1000 then
					global.GroundEft(_env, _env.ACTOR, "Ground_Xige", 1000, false)
				else
					local buff_first = global.SpecialNumericEffect(_env, "+xige_first", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 1,
						group = "xige_first",
						timing = 2,
						limit = 1,
						tags = {
							"XIGE_FIRST"
						}
					}, {
						buff_first
					})
				end

				global.DelayCall(_env, 600, global.ShakeScreen, {
					Id = 3,
					duration = 80,
					enhance = 5
				})
				global.DelayCall(_env, 1000, global.ShakeScreen, {
					Id = 3,
					duration = 100,
					enhance = 5
				})
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_rp = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 1,
					group = "passive_rp",
					timing = 2,
					limit = 1,
					tags = {
						"PASSIVE_RP"
					}
				}, {
					buff_rp
				})

				for _, unit in global.__iter__(global.AllUnits(_env, global.PETS - global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local cost = global.GetCost(_env, unit)
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							1,
							0
						})

						damage.val = global.max(_env, maxHp * (this.DamageFactor - cost * this.DamageFloor), 0)

						if this.DamageFactor - cost * this.DamageFloor == 1 then
							damage.val = damage.val + 1
						end

						if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 and global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
							local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
							local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

							if damage.val > hp + shield then
								damage.val = 0

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyBuff(_env, unit, {
									timing = 0,
									duration = 99,
									tags = {
										"LEIMu_Passive_Done"
									}
								}, {
									buff
								})
							end
						end

						damage.crit = nil
						damage.block = nil

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "DHB_Damage_Way")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Damage_Way_DARK")) == 0 then
							damage.val = 0
						end

						if damage.val > 0 then
							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

							if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
								global.AnimForTrgt(_env, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							else
								global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							end
						end
					end
				end

				local killcount = global.SpecialNumericEffect(_env, "+weapon_15119_1", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.AllUnits(_env, global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						global.KillTarget(_env, unit)

						if global.SpecialPropGetter(_env, "weapon_15119_1_check")(_env, _env.ACTOR) > 0 then
							global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT"
								}
							}, {
								killcount
							}, 1)

							if global.SpecialPropGetter(_env, "weapon_15119_1")(_env, global.FriendField(_env)) % 3 == 0 and global.EnemyMaster(_env) then
								global.ApplyHPDamage(_env, global.EnemyMaster(_env), global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.2)
							end
						end

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
							global.AnimForTrgt(_env, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						else
							global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				}, 100, "skill2"))

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PASSIVE_RP"), 99)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Unique_EX = {
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

			_env.kill = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
					global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				else
					global.GroundEft(_env, _env.ACTOR, "Ground_Xige")
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST"), 1)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.FixedPos(_env, 0, 0, 2), 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill3")), false)
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PASSIVE_RP"), 99)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if result and result.deadly == true then
						_env.kill = _env.kill + 1
					end
				end
			end)
			exec["@time"]({
				3033
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				3867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				4000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown) * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				4700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Passive_EX = {
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
				local rp_enter = global.UnitPropGetter(_env, "rp")(_env, _env.ACTOR)

				if rp_enter < 1000 then
					global.GroundEft(_env, _env.ACTOR, "Ground_Xige", 1000, false)
				else
					local buff_first = global.SpecialNumericEffect(_env, "+xige_first", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 1,
						group = "xige_first",
						timing = 2,
						limit = 1,
						tags = {
							"XIGE_FIRST"
						}
					}, {
						buff_first
					})
				end

				global.DelayCall(_env, 600, global.ShakeScreen, {
					Id = 3,
					duration = 80,
					enhance = 5
				})
				global.DelayCall(_env, 1000, global.ShakeScreen, {
					Id = 3,
					duration = 100,
					enhance = 5
				})
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_rp = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 1,
					group = "passive_rp",
					timing = 2,
					limit = 1,
					tags = {
						"PASSIVE_RP"
					}
				}, {
					buff_rp
				})

				for _, unit in global.__iter__(global.AllUnits(_env, global.PETS - global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local cost = global.GetCost(_env, unit)
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							1,
							0
						})

						damage.val = global.max(_env, maxHp * (this.DamageFactor - cost * this.DamageFloor), 0)

						if this.DamageFactor - cost * this.DamageFloor == 1 then
							damage.val = damage.val + 1
						end

						if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 and global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
							local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
							local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

							if damage.val > hp + shield then
								damage.val = 0

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyBuff(_env, unit, {
									timing = 0,
									duration = 99,
									tags = {
										"LEIMu_Passive_Done"
									}
								}, {
									buff
								})
							end
						end

						damage.crit = nil
						damage.block = nil

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "DHB_Damage_Way")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Damage_Way_DARK")) == 0 then
							damage.val = 0
						end

						if damage.val > 0 then
							global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

							if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
								global.AnimForTrgt(_env, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							else
								global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							end
						end
					end
				end

				local killcount = global.SpecialNumericEffect(_env, "+weapon_15119_1", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.AllUnits(_env, global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						global.KillTarget(_env, unit)

						if global.SpecialPropGetter(_env, "weapon_15119_1_check")(_env, _env.ACTOR) > 0 then
							global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT"
								}
							}, {
								killcount
							}, 1)

							if global.SpecialPropGetter(_env, "weapon_15119_1")(_env, global.FriendField(_env)) % 3 == 0 and global.EnemyMaster(_env) then
								global.ApplyHPDamage(_env, global.EnemyMaster(_env), global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.2)
							end
						end

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
							global.AnimForTrgt(_env, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						else
							global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Passive_BOSS = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+DamageFactor", {
					"?Normal"
				}, this.DamageFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+DamageFloor", {
					"?Normal"
				}, this.DamageFloor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"XIGE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Unique_BOSS = {
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

			_env.kill = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "Ground_Xige")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local DamageFactor = global.SpecialPropGetter(_env, "DamageFactor")(_env, _env.ACTOR)
				local DamageFloor = global.SpecialPropGetter(_env, "DamageFloor")(_env, _env.ACTOR)

				for _, unit in global.__iter__(global.AllUnits(_env, global.PETS - global.SUMMONS)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local cost = global.GetCost(_env, unit)
					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						1,
						0
					})

					damage.val = global.max(_env, maxHp * (DamageFactor - cost * DamageFloor), 0)

					if DamageFactor - cost * DamageFloor == 1 then
						damage.val = damage.val + 1
					end

					if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 and global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
						local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
						local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

						if damage.val > hp + shield then
							damage.val = 0

							local buff = global.NumericEffect(_env, "+def", {
								"+Normal",
								"+Normal"
							}, 0)

							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								tags = {
									"LEIMu_Passive_Done"
								}
							}, {
								buff
							})
						end
					end

					damage.crit = nil
					damage.block = nil

					if damage.val > 0 then
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							anim = "xge_bufftexiao",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.85
							}
						})
					end
				end

				for _, unit in global.__iter__(global.AllUnits(_env, global.SUMMONS)) do
					global.KillTarget(_env, unit)
					global.AnimForTrgt(_env, unit, {
						loop = 1,
						anim = "xge_bufftexiao",
						zOrder = "TopLayer",
						pos = {
							0.45,
							0.85
						}
					})
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ShakeScreen(_env, {
					Id = 3,
					duration = 80,
					enhance = 5
				})
				global.DelayCall(_env, 400, global.ShakeScreen, {
					Id = 3,
					duration = 100,
					enhance = 5
				})
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.FixedPos(_env, 0, 0, 2), 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill3")), false)
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if result and result.deadly == true then
						_env.kill = _env.kill + 1
					end
				end
			end)
			exec["@time"]({
				3033
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				3867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				4000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown) * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				4700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Passive_PV = {
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buff_daze = global.Daze(_env)

					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"XIGE_PV"
						}
					}, {
						buff_daze
					})
				end

				global.GroundEft(_env, _env.ACTOR, "Ground_Xige", 6000, false)

				local buff_first = global.SpecialNumericEffect(_env, "+xige_first", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"XIGE_FIRST"
					}
				}, {
					buff_first
				})

				for _, unit in global.__iter__(global.AllUnits(_env, global.PETS - global.SUMMONS)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local cost = global.GetCost(_env, unit)
					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						1,
						0
					})

					damage.val = global.max(_env, maxHp * (this.DamageFactor - cost * this.DamageFloor), 0)
					damage.crit = nil
					damage.block = nil

					if damage.val > 0 then
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AnimForTrgt(_env, unit, {
							loop = 1,
							anim = "xge_bufftexiao",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.85
							}
						})
					end
				end

				local killcount = global.SpecialNumericEffect(_env, "+weapon_15119_1", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.AllUnits(_env, global.SUMMONS)) do
					global.KillTarget(_env, unit)

					if global.SpecialPropGetter(_env, "weapon_15119_1_check")(_env, _env.ACTOR) > 0 then
						global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"UR_EQUIPMENT"
							}
						}, {
							killcount
						}, 1)

						if global.SpecialPropGetter(_env, "weapon_15119_1")(_env, global.FriendField(_env)) % 3 == 0 and global.EnemyMaster(_env) then
							global.ApplyHPDamage(_env, global.EnemyMaster(_env), global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.2)
						end
					end

					global.AnimForTrgt(_env, unit, {
						loop = 1,
						anim = "xge_bufftexiao",
						zOrder = "TopLayer",
						pos = {
							0.45,
							0.85
						}
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Unique_PV = {
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

			_env.kill = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
					global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.FixedPos(_env, 0, 0, 2), 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill3")), false)
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if result and result.deadly == true then
						_env.kill = _env.kill + 1
					end
				end
			end)
			exec["@time"]({
				3033
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				3867
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					global.CancelTargetView(_env)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill4"), false)
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				end
			end)
			exec["@time"]({
				4000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.kill > 0 then
					_env.kill = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * (1 - this.DamageDown) * (1 - this.DamageDown)

						local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

						if result and result.deadly == true then
							_env.kill = _env.kill + 1
						end
					end
				else
					global.DelayCall(_env, 200, global.Stop)
				end
			end)
			exec["@time"]({
				4700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill5"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLYDe_Passive_Awaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = externs.count

			if _env.count == nil then
				_env.count = 0
			end

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local rp_enter = global.UnitPropGetter(_env, "rp")(_env, _env.ACTOR)

				if rp_enter < 1000 then
					global.GroundEft(_env, _env.ACTOR, "Ground_Xige", 1000, false)
				else
					local buff_first = global.SpecialNumericEffect(_env, "+xige_first", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 1,
						group = "xige_first",
						timing = 2,
						limit = 1,
						tags = {
							"XIGE_FIRST"
						}
					}, {
						buff_first
					})
				end

				global.DelayCall(_env, 600, global.ShakeScreen, {
					Id = 3,
					duration = 80,
					enhance = 5
				})
				global.DelayCall(_env, 1000, global.ShakeScreen, {
					Id = 3,
					duration = 100,
					enhance = 5
				})
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_rp = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 1,
					group = "passive_rp",
					timing = 2,
					limit = 1,
					tags = {
						"PASSIVE_RP"
					}
				}, {
					buff_rp
				})

				for _, unit in global.__iter__(global.AllUnits(_env, global.PETS - global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local cost = global.GetCost(_env, unit)
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							1,
							0
						})

						damage.val = global.max(_env, maxHp * (this.DamageFactor - cost * this.DamageFloor), 0)

						if this.DamageFactor - cost * this.DamageFloor == 1 then
							damage.val = damage.val + 1
						end

						damage.crit = nil
						damage.block = nil

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "DHB_Damage_Way")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Damage_Way_DARK")) == 0 then
							damage.val = 0
						end

						if damage.val > 0 then
							local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

							if result and result.deadly == true then
								_env.count = _env.count + 1
							end

							if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
								global.AnimForTrgt(_env, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							else
								global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
									loop = 1,
									anim = "xge_bufftexiao",
									zOrder = "TopLayer",
									pos = {
										0.45,
										0.85
									}
								})
							end
						end
					end
				end

				local killcount = global.SpecialNumericEffect(_env, "+weapon_15119_1", {
					"+Normal",
					"+Normal"
				}, 1)

				for _, unit in global.__iter__(global.AllUnits(_env, global.SUMMONS)) do
					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "NianShou")) == 0 then
						global.KillTarget(_env, unit)

						if global.SpecialPropGetter(_env, "weapon_15119_1_check")(_env, _env.ACTOR) > 0 then
							global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT"
								}
							}, {
								killcount
							}, 1)

							if global.SpecialPropGetter(_env, "weapon_15119_1")(_env, global.FriendField(_env)) % 3 == 0 and global.EnemyMaster(_env) then
								global.ApplyHPDamage(_env, global.EnemyMaster(_env), global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.2)
							end
						end

						_env.count = _env.count + 1

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XIGE_FIRST")) == 0 then
							global.AnimForTrgt(_env, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						else
							global.DelayCall(_env, 1600, global.AnimForTrgt, unit, {
								loop = 1,
								anim = "xge_bufftexiao",
								zOrder = "TopLayer",
								pos = {
									0.45,
									0.85
								}
							})
						end
					end
				end

				local buff_atk = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRate)
				local buff_atk_3 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRate * 2)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "AtkUp",
					group = "Skill_FLYDe_Passive_Awaken",
					duration = 99,
					limit = 1,
					tags = {
						"Skill_FLYDe_Passive_Awaken"
					}
				}, {
					buff_atk
				})

				if _env.count >= 4 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_FLYDe_Passive_Awaken_3",
						duration = 99,
						limit = 1,
						tags = {
							"Skill_FLYDe_Passive_Awaken"
						}
					}, {
						buff_atk_3
					})
				end
			end)

			return _env
		end
	}

	return _M
end
