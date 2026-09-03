-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/trap_ops.lua

if not SkillDevKit then
	local floor, ceil = math.floor, math.ceil
	local MakeFilter = _G.MakeFilter
	local makeBuffMatchFunction = _G.makeBuffMatchFunction

	local function filterElements(array, filter, total)
		local result, count = {}, 0

		if total == nil then
			total = #array
		end

		for i = 1, total do
			local element = array[i]

			if element and filter(element) then
				count = count + 1
				result[count] = element
			end
		end

		return result, count
	end

	_G.filterElements = filterElements

	function SkillDevKit.EMPTY_CELL(env)
		return MakeFilter(function(cell)
			return cell:getResident() == nil and cell:isNormalStatus()
		end)
	end

	function SkillDevKit.CELL_IN_POS(env, pos1, ...)
		local poses = {
			pos1,
			...
		}
		local cnt = #poses

		return MakeFilter(function(cell)
			for i = 1, cnt do
				if math.abs(cell:getId()) == poses[i] then
					return true
				end
			end

			return false
		end)
	end

	function SkillDevKit.CELL_HAS_UNIT(env, unit)
		return MakeFilter(function(cell)
			return cell:getResident() == unit
		end)
	end

	function SkillDevKit.ROW_CELL_OF(env, who)
		if not who then
			return nil
		end

		local pos = who:getPosition()

		return MakeFilter(function(cell)
			return cell:getPosition().x == pos.x
		end)
	end

	function SkillDevKit.COL_CELL_OF(env, who)
		if not who then
			return nil
		end

		local pos = who:getPosition()

		return MakeFilter(function(cell)
			return cell:getPosition().y == pos.y
		end)
	end

	SkillDevKit.FRONT_ROW_CELL = _G.MakeFilter(function(cell)
		return cell:getPosition().x == 1
	end)
	SkillDevKit.MID_ROW_CELL = _G.MakeFilter(function(cell)
		return cell:getPosition().x == 2
	end)
	SkillDevKit.BACK_ROW_CELL = _G.MakeFilter(function(cell)
		return cell:getPosition().x == 3
	end)
	SkillDevKit.TOP_COL_CELL = _G.MakeFilter(function(cell)
		return cell:getPosition().y == 1
	end)
	SkillDevKit.MID_COL_CELLL = _G.MakeFilter(function(cell)
		return cell:getPosition().y == 2
	end)
	SkillDevKit.BOTTOM_COL_CELL = _G.MakeFilter(function(cell)
		return cell:getPosition().y == 3
	end)

	function SkillDevKit.NEIGHBORS_CELL_OF(env, who)
		if not who then
			return nil
		end

		local pos = who:getPosition()

		return MakeFilter(function(cell)
			local sqt_x = math.pow(pos.x - cell:getPosition().x, 2)
			local sqt_y = math.pow(pos.y - cell:getPosition().y, 2)

			return sqt_x + sqt_y <= 1
		end)
	end

	function SkillDevKit.ONESELF_CELL(env, who)
		return MakeFilter(function(cell)
			return who == cell
		end)
	end

	function SkillDevKit.DIAGONAL_CELL_OF(env, who)
		if not who then
			return nil
		end

		local pos = who:getPosition()

		return MakeFilter(function(cell)
			local sqt_x = math.pow(pos.x - cell:getPosition().x, 2)
			local sqt_y = math.pow(pos.y - cell:getPosition().y, 2)

			return sqt_x - sqt_y == 0
		end)
	end

	function SkillDevKit.AllCells(env, filter)
		local battleField = env.global["$BattleField"]
		local cells = battleField:collectCells({}, 1)

		cells = battleField:collectCells(cells, -1)

		if filter == nil then
			return cells
		end

		return filterElements(cells, filter)
	end

	function SkillDevKit.FriendCells(env, filter)
		local targetSide = env["$actor"]:getSide()
		local cells = env.global["$BattleField"]:collectCells({}, targetSide)

		if filter == nil then
			return cells
		end

		return filterElements(cells, filter)
	end

	function SkillDevKit.EnemyCells(env, filter)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local cells = env.global["$BattleField"]:collectCells({}, targetSide)

		if filter == nil then
			return cells
		end

		return filterElements(cells, filter)
	end

	function SkillDevKit.GetCell(env, unit)
		return unit:getCell()
	end

	function SkillDevKit.GetCellById(env, id, side)
		return env.global["$BattleField"]:getCellById(id, side)
	end

	function SkillDevKit.getCellBySideAndNo(env, side, no)
		return env.global["$BattleField"]:getCellBySideAndNo(side, no)
	end

	function SkillDevKit.GetCellId(env, unit)
		if not unit then
			return nil
		end

		return unit:getCell():getId()
	end

	function SkillDevKit.IdOfCell(env, cell)
		if not cell then
			return nil
		end

		return cell:getId()
	end

	function SkillDevKit.GetCellUnit(env, cell)
		if not cell then
			return nil
		end

		return cell:getResident()
	end

	function SkillDevKit.LockCellTrap(env)
		return LockCellTrap:new()
	end

	function SkillDevKit.ApplyTrap(env, cell, config, traps)
		local trapSystem = env.global["$TrapSystem"]

		if trapSystem == nil then
			return nil
		end

		local trapConfig = {
			duration = config.duration,
			display = config.display,
			tags = config.tags
		}
		local trapObject = TrapObject:new(trapConfig, traps)

		trapObject:setSource(env["$actor"])

		return trapSystem:applyTrapsOnCell(cell, trapObject, env["$id"])
	end

	function SkillDevKit.BuffTrap(env, config, buffEffects)
		return BuffTrap:new(config, buffEffects, env["$actor"])
	end

	function SkillDevKit.HPDamageTrap(env, value, lowerlimit)
		local config = {
			value = value
		}

		function config.onTrigger(battleContext, cell, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local healthSystem = battleContext:getObject("HealthSystem")
			local formationSystem = env.global["$FormationSystem"]
			local result = healthSystem:performHealthDamage(nil, unit, buffValue, lowerlimit)

			if result and result.deadly then
				unit:setFoe(source:getId())
				formationSystem:excludeDyingUnit(unit)
			end

			return result
		end

		return TrapEffect:new(config)
	end

	function SkillDevKit.HPRecoverTrap(env, value)
		local config = {
			value = value
		}

		function config.onTrigger(battleContext, cell, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local healthSystem = battleContext:getObject("HealthSystem")
			local unitFlagComp = unit:getComponent("Flag")

			if unitFlagComp:hasStatus(kBECurse) then
				return (healthSystem:performHealthDamage(nil, unit, buffValue, 1))
			else
				return (healthSystem:performHealthRecovery(nil, unit, buffValue))
			end
		end

		return TrapEffect:new(config)
	end

	function SkillDevKit.AngerDamageTrap(env, value)
		local config = {
			value = value
		}

		function config.onTrigger(battleContext, cell, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local angerSystem = battleContext:getObject("AngerSystem")

			return angerSystem:performAngerDamage(nil, unit, value, workId)
		end

		return TrapEffect:new(config)
	end

	function SkillDevKit.AngerRecoverTrap(env, value)
		local config = {
			value = value
		}

		function config.onTrigger(battleContext, cell, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local angerSystem = battleContext:getObject("AngerSystem")

			return angerSystem:performAngerRecovery(nil, unit, value, workId)
		end

		return TrapEffect:new(config)
	end

	function SkillDevKit.DispelBuffTrap(env, cell, tagOrFilter)
		local trapSystem = env.global["$TrapSystem"]

		if not trapSystem then
			return nil
		end

		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		return trapSystem:dispelBuffsOnTarget(cell, matchFunc)
	end
end
