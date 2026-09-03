-- chunkname: @/tmp/or_skill/lua_compile/Skill_KMLa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_KMLa_Normal = {
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
				500
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
	_M.__all__.Skill_KMLa_Proud = {
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

			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.SUMMONS))) do
					local buffeft1 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff(_env, unit, {
						duration = 99,
						group = "Skill_KMLa_Proud",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ABSORPTION"
						}
					}, {
						buffeft1
					})
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Unique = {
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

			_env.count1 = 0
			_env.count = 0
			_env.dam = 0

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				_env.dam = hp * 0.12 > atk * 3 and atk * 3 or hp * 0.12

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage + _env.dam)
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Passive_Death = {
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) < 1 then
					if global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed")(_env, _env.ACTOR) then
						global.Stop(_env)
					else
						global.ActivateSpecificTrigger(_env, _env.ACTOR, "FAKE_DIE")
						global.ActivateGlobalTrigger(_env, _env.ACTOR, "UNIT_FAKE_DIE")
					end
				else
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) >= 1 or global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed")(_env, _env.ACTOR) then
					-- block empty
				else
					global.AddAnim(_env, {
						loop = 2,
						anim = "huanrao_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							0.3,
							-0.8
						}
					})
					global.Sound(_env, "Se_Skill_Change_1", 1)

					if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LOVER_UNLOCK")) == 0 then
						global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
					else
						global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LOVER_UNLOCK"), 1)

						local buff = global.SpecialNumericEffect(_env, "+Skill_KMLa_Passive_Transformed", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_KMLa_Passive_Transformed"
							}
						}, {
							buff
						})
						global.Stop(_env)
					end
				end
			end)
			exec["@time"]({
				667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) >= 1 or global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed")(_env, _env.ACTOR) then
					-- block empty
				else
					global.FullInheritTransform(_env)
					global.Transform(_env, _env.ACTOR, 1, true)
					global.AddStatus(_env, _env.ACTOR, "Skill_KMLa_Passive_Transformed")
					global.AddAnim(_env, {
						loop = 1,
						anim = "die_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							0.3,
							-1.3
						}
					})
					global.Sound(_env, "Se_Skill_Change_2", 1)

					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPReduce(_env, _env.ACTOR, maxHp * 0.99)
					global.ApplyRPRecovery(_env, _env.ACTOR, 1000)
				end

				if global.FriendMaster(_env) then
					if global.MARKED(_env, "Player_Master")(_env, global.FriendMaster(_env)) then
						local buff_check = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_KMLa_Passive_Death"
							}
						}, {
							buff_check
						})
					end
				else
					local buff_check = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_KMLa_Passive_Death"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Proud_EX = {
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

			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.SUMMONS))) do
					local buffeft1 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, 0.3)

					global.ApplyBuff(_env, unit, {
						duration = 99,
						group = "Skill_KMLa_Proud",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ABSORPTION"
						}
					}, {
						buffeft1
					})
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Unique_EX = {
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

			_env.count1 = 0
			_env.count = 0
			_env.dam = 0

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				_env.dam = hp * 0.17 > atk * 4 and atk * 4 or hp * 0.17

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage + _env.dam)
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Passive_Death_EX = {
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) < 2 then
					if global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed2")(_env, _env.ACTOR) then
						global.Stop(_env)
					else
						global.ActivateSpecificTrigger(_env, _env.ACTOR, "FAKE_DIE")
						global.ActivateGlobalTrigger(_env, _env.ACTOR, "UNIT_FAKE_DIE")
					end
				else
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) >= 2 or global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed2")(_env, _env.ACTOR) then
					-- block empty
				else
					global.AddAnim(_env, {
						loop = 2,
						anim = "huanrao_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							0.3,
							-0.8
						}
					})
					global.Sound(_env, "Se_Skill_Change_1", 1)

					if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LOVER_UNLOCK")) == 0 then
						global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
					else
						if global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed")(_env, _env.ACTOR) then
							global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LOVER_UNLOCK"), 1)

							local buff = global.SpecialNumericEffect(_env, "+Skill_KMLa_Passive_Transformed2", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"Skill_KMLa_Passive_Transformed2"
								}
							}, {
								buff
							})
						else
							global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LOVER_UNLOCK"), 1)

							local buff = global.SpecialNumericEffect(_env, "+Skill_KMLa_Passive_Transformed", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"Skill_KMLa_Passive_Transformed"
								}
							}, {
								buff
							})
						end

						global.Stop(_env)
					end
				end
			end)
			exec["@time"]({
				667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Death")) >= 2 or global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed2")(_env, _env.ACTOR) then
					-- block empty
				elseif global.INSTATUS(_env, "Skill_KMLa_Passive_Transformed")(_env, _env.ACTOR) then
					global.FullInheritTransform(_env)
					global.Transform(_env, _env.ACTOR, 1, true)
					global.AddStatus(_env, _env.ACTOR, "Skill_KMLa_Passive_Transformed2")
					global.AddAnim(_env, {
						loop = 1,
						anim = "die_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							0.3,
							-1.3
						}
					})
					global.Sound(_env, "Se_Skill_Change_2", 1)

					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPReduce(_env, _env.ACTOR, maxHp * 0.99)
					global.ApplyRPRecovery(_env, _env.ACTOR, 1000)

					local maxatk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local buffeft1 = global.NumericEffect(_env, "-atk", {
						"+Normal",
						"+Normal"
					}, maxatk / 2)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "Skill_TPGZhu_Passive_Death",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				else
					global.FullInheritTransform(_env)
					global.Transform(_env, _env.ACTOR, 1, true)
					global.AddStatus(_env, _env.ACTOR, "Skill_KMLa_Passive_Transformed")
					global.AddAnim(_env, {
						loop = 1,
						anim = "die_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							0.3,
							-1.3
						}
					})
					global.Sound(_env, "Se_Skill_Change_2", 1)

					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPReduce(_env, _env.ACTOR, maxHp * 0.99)
					global.ApplyRPRecovery(_env, _env.ACTOR, 1000)
				end

				if global.FriendMaster(_env) then
					if global.MARKED(_env, "Player_Master")(_env, global.FriendMaster(_env)) then
						local buff_check = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_KMLa_Passive_Death"
							}
						}, {
							buff_check
						})
					end
				else
					local buff_check = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_KMLa_Passive_Death"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KMLa_Unique_Awaken = {
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

			_env.count1 = 0
			_env.count = 0
			_env.dam = 0

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				_env.dam = hp * this.MaxHpRateFactor > atk * 4 and atk * 4 or hp * this.MaxHpRateFactor

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage + _env.dam)
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
