-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_HYXia.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.FlameMonster_0408 = {
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
				local buff_up = global.SpecialNumericEffect(_env, "+location0408", {
					"+Normal",
					"+Normal"
				}, this.direction)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"SET_LOCATION",
						"RECORD_DMAGE"
					}
				}, {
					buff_up
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
				300
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.PassiveFunEffectBuff(_env, "BurningSelf", {
					burningDps = this.BurningDps,
					timeSlice = this.TimeSlice
				})

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "DAMAGEFROM0408")) > 0 then
						global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
							timing = 4,
							display = "Burning",
							group = "BurningSelf",
							limit = 1,
							duration = this.BurningTime,
							tags = {
								"STATUS",
								"DEBUFF",
								"BURNING",
								"ABNORMAL",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "DAMAGEFROM0408"), 99)
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "DAMAGECOUNT0408"), 99)
				end
			end)

			return _env
		end
	}

	function _M.__all__.Move_FlameMonster(_env, unit, location, duration, speed)
		local this, global = _env.this, _env.global

		if global.GetCellUnit(_env, location) then
			-- block empty
		else
			global.transportExt(_env, unit, location, duration, speed)
		end
	end

	function _M.__all__.Location_FlameMonster_Next(_env, unit, direction)
		local this, global = _env.this, _env.global

		if direction == 0 then
			local cellId0 = global.GetCellId(_env, unit) + 1
			local units = global.FriendCells(_env, global.CELL_IN_POS(_env, -cellId0))

			return units[1]
		end

		if direction == 1 then
			local cellId1 = global.GetCellId(_env, unit) - 1
			local units = global.FriendCells(_env, global.CELL_IN_POS(_env, -cellId1))

			return units[1]
		end
	end

	function _M.__all__.Turn_FlameMonster_Next(_env, unit, direction)
		local this, global = _env.this, _env.global

		if global.CellColLocation(_env, global.GetCell(_env, unit)) == 1 and direction == 0 then
			direction = 1
		end

		if global.CellColLocation(_env, global.GetCell(_env, unit)) == 3 and direction == 1 then
			direction = 0
		end

		return direction
	end

	_M.__all__.BurningSelf = {
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

				global.ApplyHPReduce(_env, _env.ACTOR, this.burningDps)
			end)

			return _env
		end
	}
	_M.__all__.DO_NOTHING_HYXia = {
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
	_M.__all__.FlameMonster_0408_Move = {
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
				local direction_next = global.Turn_FlameMonster_Next(_env, _env.ACTOR, global.SpecialPropGetter(_env, "location0408")(_env, _env.ACTOR))
				local buff_up = global.SpecialNumericEffect(_env, "+location0408", {
					"+Normal",
					"+Normal"
				}, -global.SpecialPropGetter(_env, "location0408")(_env, _env.ACTOR) + direction_next)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"SET_LOCATION"
					}
				}, {
					buff_up
				})

				local location_next = global.Location_FlameMonster_Next(_env, _env.ACTOR, global.SpecialPropGetter(_env, "location0408")(_env, _env.ACTOR))

				if global.GetCellUnit(_env, location_next) then
					if global.MARKED(_env, "HYXia")(_env, global.GetCellUnit(_env, location_next)) then
						direction_next = direction_next == 0 and 1 or 0

						local buff_up2 = global.SpecialNumericEffect(_env, "+location0408", {
							"+Normal",
							"+Normal"
						}, -global.SpecialPropGetter(_env, "location0408")(_env, _env.ACTOR) + direction_next)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"SET_LOCATION"
							}
						}, {
							buff_up2
						})

						local location_next = global.Location_FlameMonster_Next(_env, _env.ACTOR, global.SpecialPropGetter(_env, "location0408")(_env, _env.ACTOR))

						if global.GetCellUnit(_env, location_next) then
							-- block empty
						else
							global.transportExt(_env, _env.ACTOR, global.IdOfCell(_env, location_next), 200, 1)
						end
					end
				else
					global.transportExt(_env, _env.ACTOR, global.IdOfCell(_env, location_next), 200, 1)
				end
			end)

			return _env
		end
	}

	return _M
end
