-- chunkname: @/tmp/or_skill/lua_compile/Skill_TPGZhu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_TPGZhu_Normal = {
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
	_M.__all__.Skill_TPGZhu_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft4 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.TARGET, {
					timing = 2,
					duration = 1,
					display = "Hit_TPGZhu",
					tags = {
						"Hit_TPGZhu",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft4
				})
			end)
			exec["@time"]({
				800
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
	_M.__all__.Skill_TPGZhu_Unique = {
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
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft4 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Hit_TPGZhu",
						tags = {
							"Hit_TPGZhu",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft4
					})
				end
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft1 = global.NumericEffect(_env, "-defrate", {
						"+Normal",
						"+Normal"
					}, this.DeDefRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 4,
						display = "DefDown",
						group = "Skill_TPGZhu_Unique",
						duration = 10,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"DEBUFF",
							"DEFDOWN",
							"Skill_TPGZhu_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_TPGZhu_Passive_Death = {
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) == 0 then
					if global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) ~= 0 or global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
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

						local buff = global.SpecialNumericEffect(_env, "+Skill_TPGZhu_Passive_Transformed", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_TPGZhu_Passive_Transformed"
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) ~= 0 or global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
					-- block empty
				else
					global.FullInheritTransform(_env)
					global.Transform(_env, _env.ACTOR, 1, true)
					global.AddStatus(_env, _env.ACTOR, "Skill_TPGZhu_Passive_Transformed")
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

					global.ApplyHPReduce(_env, _env.ACTOR, maxHp * (1 - this.MaxHpRateFactor))

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

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

					if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
						this.RageFactor = this.RageFactor + 500
					end

					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
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
								"Skill_TPGZhu_Passive_Death"
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
							"Skill_TPGZhu_Passive_Death"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TPGZhu_Passive_Key = {
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

				if not global.MARKED(_env, "TPGZhu")(_env, _env.ACTOR) or not global.PETS(_env, _env.ACTOR) or global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
					-- block empty
				else
					for _, unit in global.__iter__(global.RandomN(_env, 3, global.FriendUnits(_env))) do
						local buffeft1 = global.Immune(_env)
						local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "DEBUFF"))

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 20,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TPGZhu_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft4 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.TARGET, {
					timing = 2,
					duration = 1,
					display = "Hit_TPGZhu",
					tags = {
						"Hit_TPGZhu",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft4
				})
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 3,
					display = "Shield",
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				}, 1)

				if global.FriendMaster(_env) then
					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 2,
						duration = 2,
						display = "Shield",
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TPGZhu_Unique_EX = {
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
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft4 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Hit_TPGZhu",
						tags = {
							"Hit_TPGZhu",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft4
					})
				end
			end)
			exec["@time"]({
				2367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft1 = global.NumericEffect(_env, "-defrate", {
						"+Normal",
						"+Normal"
					}, this.DeDefRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 4,
						display = "DefDown",
						group = "Skill_TPGZhu_Unique",
						duration = 10,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"DEBUFF",
							"DEFDOWN",
							"Skill_TPGZhu_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_TPGZhu_Passive_Death_EX = {
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) == 0 then
					if global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) ~= 0 or global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
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

						local buff = global.SpecialNumericEffect(_env, "+Skill_TPGZhu_Passive_Transformed", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"Skill_TPGZhu_Passive_Transformed"
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Death")) ~= 0 or global.INSTATUS(_env, "Skill_TPGZhu_Passive_Transformed")(_env, _env.ACTOR) then
					-- block empty
				else
					global.FullInheritTransform(_env)
					global.Transform(_env, _env.ACTOR, 1, true)
					global.AddStatus(_env, _env.ACTOR, "Skill_TPGZhu_Passive_Transformed")
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

					global.ApplyHPReduce(_env, _env.ACTOR, maxHp * (1 - this.MaxHpRateFactor))

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

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

					if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
						this.RageFactor = this.RageFactor + 500
					end

					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
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
								"Skill_TPGZhu_Passive_Death"
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
							"Skill_TPGZhu_Passive_Death"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.EXAtkRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_TPGZhu_Passive_Death_EX",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"HURTRATEUP",
						"Skill_TPGZhu_Passive_Death_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end
	}

	return _M
end
