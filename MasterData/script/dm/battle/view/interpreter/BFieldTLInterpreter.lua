-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/interpreter/BFieldTLInterpreter.lua

BFieldTLInterpreter = class("BFieldTLInterpreter", TLInterpreter, _M)

function BFieldTLInterpreter:initialize(viewContext)
	super.initialize(self)

	self._context = viewContext
	self._battleUIMediator = viewContext:getValue("BattleUIMediator")
	self._battleGround = viewContext:getValue("BattleGroundLayer")
end

function BFieldTLInterpreter:lockCell(action, args)
	return
end

function BFieldTLInterpreter:unLockCell(action, args)
	return
end

function BFieldTLInterpreter:dealWithTrapEft(eft)
	if not eft then
		return
	end

	for _, detail in ipairs(eft) do
		if detail.evt then
			if detail.evt == "LockCell" then
				local cellId = detail.cellId
				local cell = self._battleGround:getCellById(cellId)

				cell:lock()
			elseif detail.evt == "UnLockCell" then
				local cellId = detail.cellId
				local cell = self._battleGround:getCellById(cellId)

				cell:unlock()
			end
		end
	end
end

function BFieldTLInterpreter:act_AddTrap(action, args)
	self:dealWithTrapEft(args.eft)

	self._mainPlayerSide = self._context:getValue("IsTeamAView")
	self._mainPlayerId = self._context:getValue("CurMainPlayerId")

	local isLeft = true
	local cellId = args.cellId

	isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)
	cellId = isLeft and math.abs(cellId) or -math.abs(cellId)

	local cell = self._battleGround:getCellById(cellId)

	cell:addTrap(args, isLeft)
end

function BFieldTLInterpreter:act_RmTrap(action, args)
	self:dealWithTrapEft(args.eft)

	local cellId = args.cellId

	isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)
	cellId = isLeft and math.abs(cellId) or -math.abs(cellId)

	local cell = self._battleGround:getCellById(cellId)

	cell:removeTrap(args)
end

function BFieldTLInterpreter:act_BlockCell(action, args)
	self._battleGround:setBlockCells(args.blockCells)
end
