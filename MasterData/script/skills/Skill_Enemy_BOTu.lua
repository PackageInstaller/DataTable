-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_BOTu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_Enemy_ToyRabbitA_Normal = {
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
				433
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
	_M.__all__.Skill_Enemy_ToyRabbitA_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				699
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for i = 1, this.summonCount do
					local SummonedBOtu = global.Summon(_env, _env.ACTOR, "SummonedBOtu", this.summonFactor, nil, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						9,
						8
					})

					if SummonedBOtu then
						global.AddStatus(_env, SummonedBOtu, "SummonedBOtu")
					end
				end
			end)
			exec["@time"]({
				1366
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_ToyRabbitA_Passive = {
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
				local units = global.AllUnits(_env, global.MARKED(_env, "SummonedBOtu"))

				for _, unit in global.__iter__(units) do
					if unit then
						global.Kick(_env, unit)
					end
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 4,
					duration = 10,
					display = "Shader_BOTu",
					tags = {
						"BUFF",
						"ToyRabbitHit",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedBOtu")(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.RandomN(_env, 1, global.FriendCells(_env, -global.BACK_ROW_CELL))

				global.transportExt(_env, _env.ACTOR, global.IdOfCell(_env, units[1]), 500, 1)
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "stand"))
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_SummonedBOtuA_Normal = {
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
				433
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
	_M.__all__.Skill_Enemy_SummonedBOtuA_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.2,
					0
				}, 100, "skill1"))
			end)
			exec["@time"]({
				433
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local setLoction

				if _env.TARGET ~= global.EnemyMaster(_env) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					setLoction = global.GetCell(_env, _env.TARGET)

					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

					if global.GetCellUnit(_env, setLoction) then
						global.Kick(_env, _env.TARGET)

						if global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1] then
							global.SpawnByTransform(_env, global.GetOwner(_env, global.EnemyMaster(_env)), global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1], {
								global.IdOfCell(_env, setLoction)
							}, true)
						end
					end
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_SummonedBOtuA_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.cellNumber = nil
			_env.petsss = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.print(_env, "-========判断")

				_env.petsss = global.EnemyUnits(_env, global.PETS - global.SUMMONS - global.MARKED(_env, "DAGUN"))

				if _env.petsss[1] then
					local units = global.RandomN(_env, 1, _env.petsss)

					global.print(_env, "-========我好了", global.GetCellId(_env, units[1]))

					_env.cellNumber = global.GetCell(_env, units[1])

					global.Kick(_env, units[1])
					global.print(_env, "-========再次确认", global.IdOfCell(_env, _env.cellNumber))

					if global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1] then
						global.SpawnByTransform(_env, global.GetOwner(_env, global.EnemyMaster(_env)), global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1], {
							global.IdOfCell(_env, _env.cellNumber)
						}, true)
					end
				else
					global.print(_env, "-========找空位")

					local setLoction = global.RandomN(_env, 1, global.EnemyCells(_env, global.EMPTY_CELL(_env)))[1]

					if global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1] and global.RandomN(_env, 1, global.EnemyCells(_env, global.EMPTY_CELL(_env)))[1] then
						global.SpawnByTransform(_env, global.GetOwner(_env, global.EnemyMaster(_env)), global.FriendUnits(_env, global.MARKED(_env, "ToyRabbitA"))[1], {
							global.IdOfCell(_env, setLoction)
						}, true)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_SummonedBOtuB_Normal = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				return
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_SummonedBOtuB_Unique = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				return
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_SummonedBOtuB_Passive = {
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
				local buffeft2 = global.Stealth(_env, 0.8)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 99,
					display = "Stealth",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"STEALTH",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				})

				local buffeft = global.Immune(_env)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Invisible_Immune"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.buffeft1 = global.SpecialNumericEffect(_env, "+specialnumkill", {
				"?Normal"
			}, 0)
			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyBuff(_env, global.FriendMaster(_env), {
					timing = 2,
					duration = 99,
					tags = {
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Skill_Enemy_SummonedBOtuB_Passive"
					}
				}, {
					global.buffeft2
				})

				if #global.FriendUnits(_env, global.MARKED(_env, "SummonedBOtu")) == 8 and global.FriendMaster(_env) then
					global.KillTarget(_env, global.FriendMaster(_env))
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

				global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "Skill_Enemy_SummonedBOtuB_Passive"), 1)

				if #global.FriendUnits(_env, global.MARKED(_env, "SummonedBOtu")) == 8 and global.FriendMaster(_env) then
					global.KillTarget(_env, global.FriendMaster(_env))
				end
			end)

			return _env
		end
	}

	return _M
end
