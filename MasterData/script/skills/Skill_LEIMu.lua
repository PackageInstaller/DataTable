-- chunkname: @/tmp/or_skill/lua_compile/Skill_LEIMu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LEIMu_Normal = {
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
				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill1"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1,
						0
					}, 100, "skill1"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				467
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
	_M.__all__.Skill_LEIMu_Proud = {
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
				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill2"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				700
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
	_M.__all__.Skill_LEIMu_Unique = {
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
			_env.unit2 = nil
			_env.unit3 = nil
			_env.target = nil

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
				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.9, 80)
					global.HarmTargetView(_env, {
						_env.TARGET
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill3_1"))
					global.DelayCall(_env, 833, global.Perform, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill3_2"))
				else
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
					global.HarmTargetView(_env, {
						_env.TARGET
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill3_1"))
					global.DelayCall(_env, 833, global.Perform, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill3_2"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true) * global.COL_OF(_env, _env.TARGET))) do
					_env.unit2 = unit
				end

				if _env.unit2 then
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.unit2) * global.BACK_OF(_env, _env.unit2, true) * global.COL_OF(_env, _env.unit2))) do
						_env.unit3 = unit
					end
				else
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_OF(_env, _env.TARGET, true) * global.COL_OF(_env, _env.TARGET))) do
						_env.unit2 = unit
					end
				end
			end)
			exec["@time"]({
				1933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.TARGET, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				2450
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				2750
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 3 then
					global.Stop(_env)
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				3350
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 3 then
					global.Stop(_env)
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				3650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				3800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end
			end)
			exec["@time"]({
				4090
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LEIMu_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "LEIMu_Passive_Done")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)

					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buff2 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						display = "HurtRateUp",
						group = "Skill_LEIMu_Passive_HurtRate",
						duration = 20,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						display = "Absorption",
						group = "Skill_LEIMu_Passive_Absorption",
						duration = 20,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ABSORPTIONUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff2
					}, 1, 0)

					local buff = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"LEIMu_Passive"
						}
					}, {
						buff
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "LEIMu_Passive_Done"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LEIMu_Passive_Key = {
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

				if global.MASTER(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					if global.MARKED(_env, "LEIMu")(_env, _env.unit) then
						for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "LAMu"))) do
							global.RecruitCard(_env, card, {
								global.Random(_env, 1, 9)
							})
						end
					end

					if global.MARKED(_env, "LAMu")(_env, _env.unit) then
						for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "LEIMu"))) do
							global.RecruitCard(_env, card, {
								global.Random(_env, 1, 9)
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LEIMu_Proud_EX = {
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
				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill2"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local buff = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					display = "AtkUp",
					group = "Skill_LEIMu_Proud",
					duration = 2,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				}, 1, 0)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LEIMu_Unique_EX = {
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
			_env.unit2 = nil
			_env.unit3 = nil
			_env.target = nil

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
				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.9, 80)
					global.HarmTargetView(_env, {
						_env.TARGET
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill3_1"))
					global.DelayCall(_env, 833, global.Perform, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.9,
						0
					}, 100, "skill3_2"))
				else
					global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
					global.HarmTargetView(_env, {
						_env.TARGET
					})
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill3_1"))
					global.DelayCall(_env, 833, global.Perform, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.1,
						0
					}, 100, "skill3_2"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true) * global.COL_OF(_env, _env.TARGET))) do
					_env.unit2 = unit
				end

				if _env.unit2 then
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.unit2) * global.BACK_OF(_env, _env.unit2, true) * global.COL_OF(_env, _env.unit2))) do
						_env.unit3 = unit
					end
				else
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_OF(_env, _env.TARGET, true) * global.COL_OF(_env, _env.TARGET))) do
						_env.unit2 = unit
					end
				end
			end)
			exec["@time"]({
				1933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.TARGET, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				2450
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				2750
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 3 then
					global.Stop(_env)
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				3350
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end

				if _env.kill == 1 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit2 then
						_env.target = _env.unit2
					else
						global.Stop(_env)
					end
				elseif _env.kill == 2 then
					global.UnassignRoles(_env, _env.target, "target")

					if _env.unit3 then
						_env.target = _env.unit3
					else
						global.Stop(_env)
					end
				elseif _env.kill == 3 then
					global.Stop(_env)
				elseif _env.kill == 0 then
					_env.target = _env.TARGET
				end
			end)
			exec["@time"]({
				3650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, {
					_env.target
				})

				local num = global.GetSufaceIndex(_env, _env.ACTOR)

				if num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.9,
						0
					}, 50, "skill3_2"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
						-1.1,
						0
					}, 50, "skill3_2"))
				end

				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				3800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)
				local result = global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)

				if result and result.deadly then
					_env.kill = _env.kill + 1
				end
			end)
			exec["@time"]({
				4090
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LEIMu_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "LEIMu_Passive_Done")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)

					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buff2 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						display = "HurtRateUp",
						group = "Skill_LEIMu_Passive_HurtRate",
						duration = 20,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						display = "Absorption",
						group = "Skill_LEIMu_Passive_Absorption",
						duration = 20,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ABSORPTIONUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff2
					}, 1, 0)

					local buff = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"LEIMu_Passive"
						}
					}, {
						buff
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "LEIMu_Passive_Done"), 99)
				end
			end)

			return _env
		end
	}

	return _M
end
