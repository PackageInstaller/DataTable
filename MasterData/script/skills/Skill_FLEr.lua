-- chunkname: @/tmp/or_skill/lua_compile/Skill_FLEr.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_FLEr_Normal = {
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
					-0.9,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
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
	_M.__all__.Skill_FLEr_Proud = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
							_env.target = unit
						end
					end
				else
					_env.target = _env.TARGET
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Unique = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							_env.target = _env.TARGET or global.RandomN(_env, 1, global.EnemyUnits(_env, -global.HASBUFFTAG(_env, global.BUFF_MARKED(_env, "STEALTH"))))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, _env.target))

							break
						end
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							_env.target = unit
						end
					end
				else
					_env.target = _env.TARGET
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-3,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.target, "target")
				global.HarmTargetView(_env, {
					_env.target
				})
			end)
			exec["@time"]({
				1767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.target, this.RageFactor)
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Passive_Death = {
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

				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Passive_Key = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "HLa")(_env, _env.unit) and global.MASTER(_env, _env.ACTOR) then
					local wolf = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "FLEr"))

					if wolf[1] then
						local cellid = global.abs(_env, global.GetCellId(_env, _env.unit))
						local cardlocation = global.GetCardWindowIndex(_env, _env.ACTOR)
						local acard = global.BackToCard_ResultCheck(_env, _env.unit, "window", cardlocation)

						if acard then
							global.ForceKick(_env, _env.unit)

							local Aibo = global.RecruitCard(_env, wolf[1], {
								cellid
							}, nil, global.GetOwner(_env, _env.ACTOR), true)

							if Aibo then
								global.AddStatus(_env, Aibo, "Skill_FLEr_Passive_Key")
							end
						end
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

				if global.INSTATUS(_env, "Skill_FLEr_Passive_Key")(_env, _env.ACTOR) then
					global.KillTarget(_env, _env.ACTOR)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Proud_EX = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
							_env.target = unit
						end
					end
				else
					_env.target = _env.TARGET
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.target, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.target, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Unique_EX = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.EnemyMaster(_env) then
					_env.target = global.EnemyMaster(_env)

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							_env.target = _env.TARGET or global.RandomN(_env, 1, global.EnemyUnits(_env, -global.HASBUFFTAG(_env, global.BUFF_MARKED(_env, "STEALTH"))))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, _env.target))

							break
						end
					end

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							_env.target = unit
						end
					end
				else
					_env.target = _env.TARGET
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.target) + {
					-3,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.target, "target")
				global.HarmTargetView(_env, {
					_env.target
				})
			end)
			exec["@time"]({
				1767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.target)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.target)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.target, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.target, damage)
				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.target, this.RageFactor)
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_FLEr_Passive_Death_EX = {
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

				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
			end)

			return _env
		end
	}

	return _M
end
