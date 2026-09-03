-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/TrapSystem.lua

TrapSystem = class("TrapSystem", BattleSubSystem)

function TrapSystem:initialize()
	super.initialize(self)

	self._cellAgentRegistry = {}
end

function TrapSystem:startup(battleContext)
	super.startup(self, battleContext)

	self._battleField = battleContext:getObject("BattleField")

	return self
end

function TrapSystem:updateOnRoundEnded()
	self:updateTraps()
end

function TrapSystem:retrieveCellAgent(cell, autoCreate)
	local cellAgentRegistry = self._cellAgentRegistry
	local cellAgent = cellAgentRegistry[cell]

	if cellAgent ~= nil or not autoCreate then
		return cellAgent
	end

	cellAgent = CellAgent:new(cell)
	cellAgentRegistry[cell] = cellAgent

	return cellAgent
end

function TrapSystem:selectBuffsOnTarget(cell, condition)
	assert(cell ~= nil)

	local cellAgent = self:retrieveCellAgent(cell, false)

	if cellAgent == nil then
		return {}, 0
	end

	return cellAgent:selectBuffObjects(condition)
end

function TrapSystem:discardCellAgent(cell)
	local cellAgentRegistry = self._cellAgentRegistry

	cellAgentRegistry[cell] = nil

	return cellAgentRegistry[cell]
end

function TrapSystem:applyTrapsOnCell(cell, trapObject, workId)
	assert(trapObject ~= nil, "Invalid arguments")

	local cellAgent = self:retrieveCellAgent(cell, true)
	local appliedCell, detail = trapObject:putTrap(cellAgent)

	if appliedCell == nil then
		return nil
	end

	local added = cellAgent:addTrapObject(trapObject)

	if detail and self._processRecorder then
		self._processRecorder:recordObjectEvent(kBRFieldLine, "AddTrap", detail, workId)
	end
end

function TrapSystem:triggerTrap(target)
	local posComp = target:getComponent("Position")
	local cell = target:getCell()
	local buffSystem = self._battleContext:getObject("BuffSystem")
	local targetAgent = buffSystem:retrieveTargetAgent(target, true)
	local cellAgent = self:retrieveCellAgent(cell)

	if cellAgent then
		local trapList = cellAgent:getTraps()

		if trapList then
			for i, trap in ipairs(trapList) do
				if not targetAgent:isImmuneToTrapBuffObject(trap) then
					trap:trigger(target, self._battleContext)

					if trap:isScrapped() then
						self:cancelTrap(cell, trap)
					end
				end
			end
		end
	end
end

function TrapSystem:updateTraps()
	local function visitor(cell)
		local cellAgent = self:retrieveCellAgent(cell)
		local trapList = cellAgent and cellAgent:getTraps()

		if trapList then
			for i, trap in ipairs(trapList) do
				if cellAgent:hasTrapObject(trap) then
					local result = trap:updateTiming(self._battleContext)

					if result and self._processRecorder then
						self._processRecorder:recordObjectEvent(kBRFieldLine, "TickTrap", result)
					end

					if trap:isScrapped() then
						self:cancelTrap(cell, trap)
					end
				end
			end
		end
	end

	self._battleField:visitAllCells(visitor)
end

function TrapSystem:cancelTrap(cell, trap)
	local cellAgent = self:retrieveCellAgent(cell)

	if cellAgent and cellAgent:removeTrapObject(trap) then
		local sucess, detail = trap:cancelTrap(cellAgent)

		if sucess and self._processRecorder then
			self._processRecorder:recordObjectEvent(kBRFieldLine, "RmTrap", detail)
		end
	end
end

function TrapSystem:dispelBuffsOnTarget(cell, condition, workId, ignoreTriggerEvent)
	local cellAgent = self:retrieveCellAgent(cell, false)

	if cellAgent == nil then
		return 0
	end

	local trapList = cellAgent:selectBuffObjects(condition)

	if trapList == nil then
		return 0
	end

	local total = 0

	for i = 1, #trapList do
		local trap = trapList[i]

		if cellAgent:removeTrapObject(trap) then
			local sucess, detail = trap:cancelTrap(cellAgent)

			if sucess and self._processRecorder then
				self._processRecorder:recordObjectEvent(kBRFieldLine, "RmTrap", detail)
			end

			total = total + 1
		end
	end

	return total
end

function TrapSystem:cleanTrapsOnCell(cell)
	local cellAgent = self:retrieveCellAgent(cell)
	local trapList = cellAgent and cellAgent:getTraps()

	if trapList then
		for i, trap in ipairs(trapList) do
			if cellAgent:removeTrapObject(trap) then
				local sucess, detail = trap:cancelTrap(cellAgent)

				if sucess and self._processRecorder then
					self._processRecorder:recordObjectEvent(kBRFieldLine, "RmTrap", detail)
				end
			end
		end
	end

	self:discardCellAgent(cell)
end

function TrapSystem:cleanAllTraps()
	local function visitor(cell)
		self:cleanTrapsOnCell(cell)
	end

	self._battleField:visitAllCells(visitor)
end

function TrapSystem:cleanup()
	self:cleanAllTraps()
end
