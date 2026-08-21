-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/halo/BattleCompHaloLinks.lua

module("logic.battle.battleflow.component.halo.BattleCompHaloLinks", package.seeall)

local BattleCompHaloLinks = class("BattleCompHaloLinks", IBattleFlowComp)

function BattleCompHaloLinks:onInit()
	self._entityLinkTable = {}
	self._lineList = {}
	self._entityIds = {}
	self._removingLinkList = {}
end

function BattleCompHaloLinks:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._boardModel = self.flow.boardModel or false

	BattleDispatcher:addEventListener(BattleEventType.OnEntityForecastMove, self._onUnitMove, self)
end

function BattleCompHaloLinks:onClear()
	self._unitMgr = false
	self._boardModel = false

	BattleTableUtil.clearReusableTable(self._lineList)
	BattleTableUtil.clearReusableTable(self._removingLinkList)
	BattleTableUtil.clearTable(self._entityIds)
	BattleTableUtil.clearReusableTable(self._entityLinkTable)
	BattleDispatcher:removeEventListener(BattleEventType.OnEntityForecastMove, self._onUnitMove, self)
end

function BattleCompHaloLinks:onUndoReset()
	BattleTableUtil.clearReusableTable(self._lineList)
	BattleTableUtil.clearReusableTable(self._removingLinkList)
	BattleTableUtil.clearTable(self._entityIds)
	BattleTableUtil.clearReusableTable(self._entityLinkTable)
end

function BattleCompHaloLinks:addLink(fromEntityId, toEntityId, fromSkillId)
	local linkMO = self._entityLinkTable[toEntityId]

	if not linkMO then
		linkMO = BattleHaloLinkSourceMO:createInstance(toEntityId)
		self._entityLinkTable[toEntityId] = linkMO
	end

	linkMO:addLinkSource(fromEntityId, fromSkillId)
end

function BattleCompHaloLinks:removeLink(fromEntityId, toEntityId, fromSkillId)
	local linkMO = self._entityLinkTable[toEntityId]

	if not linkMO then
		return
	end

	linkMO:removeLinkSource(fromEntityId, fromSkillId)

	if linkMO:isEmpty() then
		linkMO:returnSelf()

		self._entityLinkTable[toEntityId] = nil
	end
end

function BattleCompHaloLinks:getLinkSourceMO(entityId)
	return self._entityLinkTable[entityId]
end

function BattleCompHaloLinks:drawHaloLinksForUnit(entityId)
	BattleTableUtil.insertunique(self._entityIds, entityId)
	self:_updateHaloLinksForUnit(entityId)
end

function BattleCompHaloLinks:clearHaloLinksForUnit(entityId)
	for i = #self._lineList, 1, -1 do
		local line = self._lineList[i]

		if line:getToEntityId() == entityId then
			self:_hideLine(line)
			table.remove(self._lineList, i)
		end
	end

	self:_onUnitMove(evt, entityId)
	table.removebyvalue(self._entityIds, entityId)
end

function BattleCompHaloLinks:updateHaloLinks()
	for _, entityId in ipairs(self._entityIds) do
		self:_updateHaloLinksForUnit(entityId)
	end
end

function BattleCompHaloLinks:clearAllLinkLine()
	self:_clearAllLine(self._lineList)

	for _, entityId in ipairs(self._entityIds) do
		self:_updateEntityPosition(entityId)
	end

	BattleTableUtil.clearTable(self._entityIds)
end

function BattleCompHaloLinks:_updateHaloLinksForUnit(entityId)
	local unitMgr = self._unitMgr
	local needRemoveLines = BattleTableUtil.getTempList()

	for i = #self._lineList, 1, -1 do
		local line = self._lineList[i]

		if line:getToEntityId() == entityId then
			table.remove(self._lineList, i)
			table.insert(needRemoveLines, line)
		end
	end

	local unit = self._unitMgr:getUnit(entityId)
	local linkSourceMO = self:getLinkSourceMO(entityId)

	if linkSourceMO then
		local sourceEntityIds = linkSourceMO:getSourceEntityIds()
		local sourceSkillIds = linkSourceMO:getFromSkills()

		for i, sourceEntityId in ipairs(sourceEntityIds) do
			self:_checkCacheAndDrawLine(needRemoveLines, sourceEntityId, entityId, sourceSkillIds[i])
		end
	end

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local boardCellMO = self._boardModel:getBoardCellMO(unionIndex)
	local stateMOList = boardCellMO:getStateMOList()

	for _, stateMO in pairs(stateMOList) do
		if stateMO:isTargetState(BattleEnum.CellState.BLOCKED) then
			local targetUnit = self._unitMgr:getUnit(stateMO:getEntityId())

			if BattleCampRelationUtil.areTheyEnemyRelation(unit, targetUnit) then
				self:_checkCacheAndDrawLine(needRemoveLines, stateMO:getEntityId(), entityId, stateMO:getSkillCode())
			end
		end
	end

	self:_clearAllLine(needRemoveLines)
	BattleTableUtil.releaseTempList(needRemoveLines)
end

function BattleCompHaloLinks:_checkCacheAndDrawLine(lineListCache, fromEntityId, toEntityId, fromSkill)
	if fromEntityId == toEntityId then
		return
	end

	for i, line in ipairs(lineListCache) do
		if line:isTargetLink(fromEntityId, toEntityId) then
			table.remove(lineListCache, i)
			table.insert(self._lineList, line)

			return
		end
	end

	self:_drawLine(fromEntityId, toEntityId, fromSkill)
end

function BattleCompHaloLinks:_drawLine(fromEntityId, toEntityId, fromSkill)
	local fromUnit = self._unitMgr:getUnit(fromEntityId)
	local toUnit = self._unitMgr:getUnit(toEntityId)
	local isSameOrFriendRelation = BattleCampRelationUtil.areTheySameOrFriendRelation(fromUnit, toUnit)
	local fx, fy, fz = self:_getUnitCenterPosInForecast(fromUnit)
	local tx, ty, tz = self:_getUnitCenterPosInForecast(toUnit)
	local line = HaloLinkLine:createInstance()

	line:setReturnCallBack(self._onLineCleared, self)
	line:setRelation(isSameOrFriendRelation)
	line:setEntityId(fromEntityId, toEntityId)
	line:setShapeAndRange(BattleEnum.Shape.Rhombus, 0)

	if fromSkill and fromUnit.skill then
		local skillMO = fromUnit.skill:getActiveSkillById(fromSkill)

		if skillMO then
			local shape, range = skillMO:getHaloShapeAndRange()

			line:setShapeAndRange(shape, range)
		end
	end

	line:setStartPositionXYZ(fx, fy, fz)
	line:setEndPositionXYZ(tx, ty, tz)
	line:show()
	table.insert(self._lineList, line)
end

function BattleCompHaloLinks:_hideLine(line)
	table.insert(self._removingLinkList, line)
	line:hide()
end

function BattleCompHaloLinks:_onLineCleared(line)
	table.removebyvalue(self._removingLinkList, line)
	line:returnSelf()
end

function BattleCompHaloLinks:_clearAllLine(lineList)
	for _, line in pairs(lineList) do
		self:_hideLine(line)
	end

	BattleTableUtil.clearTable(lineList)
end

function BattleCompHaloLinks:clearLinkLineByDestination(entityId, unionIndex)
	local unit = self._unitMgr:getUnit(entityId)

	for i = #self._lineList, 1, -1 do
		local line = self._lineList[i]

		if line:getFromEntityId() == entityId then
			local shape, range = line:getShapeAndRange()
			local toUnit = self._unitMgr:getUnit(line:getToEntityId())

			if not BattleSkillAssist.testUnitInShapeRange(unit, unionIndex, toUnit, false, shape, range) then
				local line = table.remove(self._lineList, i)

				self:_hideLine(line)
			end
		elseif line:getToEntityId() == entityId then
			local shape, range = line:getShapeAndRange()
			local fromUnit = self._unitMgr:getUnit(line:getFromEntityId())

			if not BattleSkillAssist.testUnitInShapeRange(fromUnit, false, unit, unionIndex, shape, range) then
				local line = table.remove(self._lineList, i)

				self:_hideLine(line)
			end
		end
	end
end

function BattleCompHaloLinks:isInHaloRange(fromEntityId, toEntityId, fromSkillId)
	local unitMgr = self._unitMgr
	local fromUnit = unitMgr:getUnit(fromEntityId)
	local toUnit = unitMgr:getUnit(toEntityId)
	local skillMO = fromUnit.skill:getActiveSkillById(fromSkillId)
	local shape, range = skillMO:getHaloShapeAndRange()

	return BattleSkillAssist.isUnitInShapeRange(fromUnit, toUnit, shape, range)
end

function BattleCompHaloLinks:_onUnitMove(evt, entityId)
	self:_updateEntityPosition(entityId)
end

function BattleCompHaloLinks:_getUnitCenterPosInForecast(unit)
	local forecastUnit = unit.property:getForecastUnit() or unit

	return BattleUnitUtil.getUnitCenterPos(forecastUnit)
end

function BattleCompHaloLinks:_updateEntityPosition(entityId)
	local unit = self._unitMgr:getUnit(entityId)

	if not unit then
		return
	end

	local x, y, z = self:_getUnitCenterPosInForecast(unit)

	for i, line in ipairs(self._lineList) do
		if line:getFromEntityId() == entityId then
			local toUnit = self._unitMgr:getUnit(line:getToEntityId())

			line:setStartPositionXYZ(x, y, z)
			line:setEndPositionXYZ(self:_getUnitCenterPosInForecast(toUnit))
		elseif line:getToEntityId() == entityId then
			line:setEndPositionXYZ(x, y, z)
		end
	end

	for i, line in ipairs(self._removingLinkList) do
		if line:getFromEntityId() == entityId then
			local toUnit = self._unitMgr:getUnit(line:getToEntityId())

			line:setStartPositionXYZ(x, y, z)
			line:setEndPositionXYZ(self:_getUnitCenterPosInForecast(toUnit))
		elseif line:getToEntityId() == entityId then
			line:setEndPositionXYZ(x, y, z)
		end
	end
end

function BattleCompHaloLinks:toString()
	local sb = StringBuffer.New()

	sb:append("haloLinks::"):appendLine()

	for _, linkMO in pairs(self._entityLinkTable) do
		sb:append(linkMO:toString()):appendLine()
	end

	return sb:toString()
end

return BattleCompHaloLinks
