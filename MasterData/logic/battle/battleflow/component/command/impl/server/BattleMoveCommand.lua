-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleMoveCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleMoveCommand", package.seeall)

local BattleMoveCommand = class("BattleMoveCommand", BattleCommandBase)

function BattleMoveCommand:parseServerCommand(cmdParser, movedEventNO)
	local cmd = BattleMoveCommand:createInstance()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(movedEventNO.entity)

	cmd:insertPathCoordinates(unit.transform:getCoordinates())
	cmd:insertPathCoordinatesList(movedEventNO.movement)
	cmd:setEntityId(movedEventNO.entity)
	cmd:setDefaultOriginalUnionIndex()
	BattleCmdUtil.parseServerCommandBatch(cmdParser, movedEventNO.before)
	cmdParser:addCommand(cmd)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, movedEventNO.after)
end

function BattleMoveCommand:isMoved(movedEventNO)
	return #movedEventNO.movement > 0
end

function BattleMoveCommand:create(entityId, originUnionIndex, unionIndexList)
	local cmd = BattleMoveCommand:createInstance()

	cmd:setEntityId(entityId)
	cmd:setPathUnionIndexList(unionIndexList)
	cmd:setOriginalUnionIndex(originUnionIndex)

	return cmd
end

function BattleMoveCommand:onInit()
	self._entityId = 0
	self._pathUnionIndexList = {}
	self._originUnionIndex = 0
	self._currentUnionIndex = 0
	self._stopUnionIndex = 0
end

function BattleMoveCommand:onClear()
	self:_clearExecute()

	self._entityId = 0
	self._originUnionIndex = 0
	self._currentUnionIndex = 0
	self._stopUnionIndex = 0

	if self._soloInMainScene then
		self._soloInMainScene:clear()
	end

	table.clear(self._pathUnionIndexList)
end

function BattleMoveCommand:execute(battleFlow)
	local entityId = self._entityId
	local pathUnionIndexList = self._pathUnionIndexList
	local pathCount = #pathUnionIndexList

	if pathCount <= 0 then
		self:finish(true)

		return
	end

	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		self:finish(true)

		if BattleLog.enableError then
			BattleLog.error(string.format("BattleMoveCommand::Cannot find unit[%s]", entityId))
		end

		return
	end

	local stopUnionIndex = pathUnionIndexList[pathCount]
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	if unionIndex == stopUnionIndex then
		self:finish(true)

		return
	end

	self._unit = unit
	self._currentUnionIndex = unionIndex
	self._stopUnionIndex = stopUnionIndex

	if unit.property:isStateActive(BattleEnum.State.IGNORE_BARRIER) then
		self:_executeAsTransportMove(battleFlow)
	else
		self:_executeAsNormalMove(battleFlow)
	end

	BattleUnitUtil.play3dAudio(unit, unit.property:getRunAudio())
end

function BattleMoveCommand:_executeAsNormalMove(battleFlow)
	local unit = self._unit
	local pathUnionIndexList = self._pathUnionIndexList
	local stopUnionIndex = self._stopUnionIndex

	self:_initExecute()

	local boardMgr = battleFlow.boardMgr
	local boardModel = battleFlow.boardModel

	boardModel:setUnitToUnionIndex(unit, stopUnionIndex)

	for _, pathIndex in pairs(pathUnionIndexList) do
		local position = boardMgr:getCellPosition(pathIndex)

		unit.mover:addWayPoint(position.x, position.z)
	end
end

function BattleMoveCommand:_executeAsTransportMove(battleFlow)
	if not self._soloInMainScene then
		self._soloInMainScene = SkillSoloInMainScene.New()
	end

	self._skillVSInfo = SkillVSInfo:createInstance()

	self._skillVSInfo:setAttacker(self._unit)
	self._skillVSInfo:setVictim(self._unit)
	self._skillVSInfo:setTargetUnionIndex(self._stopUnionIndex)

	self._attackInfo = SkillAttackInfo:createInstance()

	self._attackInfo:setAttacker(self._unit)

	local handler = TransportSkillAttackPointHandler:createInstance()

	handler:setEntityId(self._unit.property:getEntityId())
	handler:setPositionChangingMethod(BattleExtension_pb.PositionChangingMethod.POSITION_CHANGING_METHOD_SUDDEN)
	handler:setTransportUnionIndex(self._stopUnionIndex)
	self._attackInfo:addAttackPointHandler(handler)

	self._context = SkillTimelineContext.New(self._skillVSInfo)

	self._soloInMainScene:bindContext(self._context)

	local url = self:_getMoveTimelineResUrl()

	self._soloInMainScene:loadResource(url, self._resourceLoaded, self)
end

function BattleMoveCommand:_getMoveTimelineResUrl()
	local modeCode = self._unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modeCode)
	local resName = string.format("%s_run", modelCO.resName)

	return BattleSkillAssist.getNormal3dEffectSkillUrl(resName)
end

function BattleMoveCommand:_resourceLoaded()
	self._soloInMainScene:start(self._attackInfo, self._onTransportPerformanceFinished, self)
end

function BattleMoveCommand:_onTransportPerformanceFinished()
	self._attackInfo:returnSelf()
	self._skillVSInfo:returnSelf()
	self._unit:dispatchInnerEvent(UnitActionType.PosChanged)
	self:_onPosChanged()
	self._unit:dispatchInnerEvent(UnitActionType.Arrive)
	self:finish(true)
end

function BattleMoveCommand:_initExecute()
	self._unit:addInnerEventListener(UnitActionType.Arrive, self._onArrive, self)
	self._unit:addInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
	self._unit:addInnerEventListener(UnitActionType.Interrupt, self._onInterrupt, self)
end

function BattleMoveCommand:_clearExecute()
	if self._unit then
		self._unit:removeInnerEventListener(UnitActionType.Arrive, self._onArrive, self)
		self._unit:removeInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
		self._unit:removeInnerEventListener(UnitActionType.Interrupt, self._onInterrupt, self)

		self._unit = false
	end
end

function BattleMoveCommand:_onPosChanged()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityMove, self._entityId)
end

function BattleMoveCommand:_onArrive()
	if self._unit then
		CriwareAudioFacade.instance:stopSoundByByName(self._unit.property:getRunAudio())
	end

	self:finish(true)
end

function BattleMoveCommand:_onInterrupt()
	CriwareAudioFacade.instance:stopSoundByByName(self._unit.property:getRunAudio())
	self:finish(true)

	if BattleLog.enableWarn then
		BattleLog.warn("BattleMoveCommand::unit moving is interrupted!")
	end
end

function BattleMoveCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleMoveCommand:setOriginalUnionIndex(originUnionIndex)
	self._originUnionIndex = originUnionIndex

	return self
end

function BattleMoveCommand:setPathUnionIndexList(unionIndexList)
	if unionIndexList then
		table.insertto(self._pathUnionIndexList, unionIndexList)
	end

	return self
end

function BattleMoveCommand:insertPathCoordinates(x, z)
	table.insert(self._pathUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
end

function BattleMoveCommand:insertPathCoordinatesList(coordinatesList)
	for _, coordinates in ipairs(coordinatesList) do
		self:insertPathCoordinates(coordinates.x, coordinates.z)
	end

	return self
end

function BattleMoveCommand:setDefaultOriginalUnionIndex()
	self:setOriginalUnionIndex(self._pathUnionIndexList[1])

	return self
end

function BattleMoveCommand:toString()
	return string.format("[move command entityId = %s, path = %s]", self._entityId, BattleTableUtil.arrayToString(self._pathUnionIndexList))
end

return BattleMoveCommand
