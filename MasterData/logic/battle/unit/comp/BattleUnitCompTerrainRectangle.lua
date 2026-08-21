-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompTerrainRectangle.lua

module("logic.battle.unit.comp.BattleUnitCompTerrainRectangle", package.seeall)

local BattleUnitCompTerrainRectangle = class("BattleUnitCompTerrainRectangle", UnitComponentBase, IBattleUnitComponent)
local kTempUnionTable = {}

function BattleUnitCompTerrainRectangle:onInit()
	self._rectangle = Rectangle:createInstance()
	self._mover = self._unit.mover
	self._mountRoot = self._unit.mountRoot
	self._terrainModel = self._unit.terrainModel
	self._groupType = BattleEnum.AdditionalTerrainGroup.None
end

function BattleUnitCompTerrainRectangle:onReset()
	self._groupType = BattleEnum.AdditionalTerrainGroup.None

	local goAvatar = self._mountRoot:getAvatarRoot()

	TransformUtils.SetLocalScale(goAvatar.transform, 1, 1, 1)
end

function BattleUnitCompTerrainRectangle:setOriginalUnionIndex(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	self._rectangle:setRanges(x, x, z, z)
end

function BattleUnitCompTerrainRectangle:internal_updatePerformance()
	if self._groupType == BattleEnum.AdditionalTerrainGroup.Scaled then
		self:_internal_updateAvatar()
	elseif self._groupType == BattleEnum.AdditionalTerrainGroup.PointAdd then
		self:_internal_pointUpdate()
	end
end

function BattleUnitCompTerrainRectangle:_internal_pointUpdate()
	self._terrainModel:resetRemoveState()

	local minx, maxx, minz, maxz = self:_getRanges()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local halfSideLength = SpaceX.CheckBoardSetting.GetHalfSideLength()

	for i = minx, maxx do
		local cell = self._terrainModel:getOrCreateByPos(i, minz, 1)

		cell:setRemoveState(false)

		local x, y, z = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(i, minz))

		cell:setPos(x - halfSideLength, y, z - halfSideLength)
	end

	for i = minz, maxz do
		local cell = self._terrainModel:getOrCreateByPos(maxx, i, 2)

		cell:setRemoveState(false)

		local x, y, z = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(maxx, i))

		cell:setPos(x + halfSideLength, y, z - halfSideLength)
	end

	for i = maxx, minx, -1 do
		local cell = self._terrainModel:getOrCreateByPos(i, maxz, 3)

		cell:setRemoveState(false)

		local x, y, z = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(i, maxz))

		cell:setPos(x + halfSideLength, y, z + halfSideLength)
	end

	for i = maxz, minz, -1 do
		local cell = self._terrainModel:getOrCreateByPos(minx, i, 4)

		cell:setRemoveState(false)

		local x, y, z = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(minx, i))

		cell:setPos(x - halfSideLength, y, z + halfSideLength)
	end

	self._terrainModel:removeTerrainWithState()
end

function BattleUnitCompTerrainRectangle:_internal_updateAvatar()
	local minx, maxx, minz, maxz = self:_getRanges()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x1, y1, z1 = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(minx, minz))
	local x2, y2, z2 = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(maxx, maxz))

	self._mover:setPosDirectly((x1 + x2) / 2, (z1 + z2) / 2)

	local goAvatar = self._mountRoot:getAvatarRoot()

	TransformUtils.SetLocalScale(goAvatar.transform, maxx - minx + 1, 1, maxz - minz + 1)
end

function BattleUnitCompTerrainRectangle:internal_merge(srcGroup)
	if self._unit.terrainCode ~= srcGroup.terrainCode then
		return false
	end

	local minx, maxx, minz, maxz = self:_getRanges()
	local sminx, smaxx, sminz, smaxz = srcGroup.rectangle:_getRanges()

	if maxx + 1 == sminx and minz == sminz and maxz == smaxz then
		self._rectangle:setMaxx(smaxx)

		return true
	end

	if minx - 1 == smaxx and minz == sminz and maxz == smaxz then
		self._rectangle:setMinx(sminx)

		return true
	end

	if maxz + 1 == sminz and minx == sminx and maxx == smaxx then
		self._rectangle:setMaxz(smaxz)

		return true
	end

	if minz - 1 == smaxz and minx == sminx and maxx == smaxx then
		self._rectangle:setMinz(sminz)

		return true
	end

	return false
end

function BattleUnitCompTerrainRectangle:internal_tryMergeInGroup(unionIndexList)
	if #unionIndexList <= 0 then
		return
	end

	local unionIndexMap = kTempUnionTable

	for _, unionIndex in ipairs(unionIndexList) do
		unionIndexMap[unionIndex] = true
	end

	self:_tryMergeInGroup(unionIndexMap)
	BattleTableUtil.clearTable(unionIndexList)
	BattleTableUtil.insertfrommapkey(unionIndexList, unionIndexMap)
	BattleTableUtil.clearTable(unionIndexMap)
end

function BattleUnitCompTerrainRectangle:internal_containsUnionIndex(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	return self._rectangle:inRectangle(x, z)
end

function BattleUnitCompTerrainRectangle:internal_splitToUnionIndexList(outUnionIndexList)
	local minx, maxx, minz, maxz = self._rectangle:getRanges()

	for x = minx, maxx do
		for z = minz, maxz do
			table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
		end
	end
end

function BattleUnitCompTerrainRectangle:_getRanges()
	return self._rectangle:getRanges()
end

function BattleUnitCompTerrainRectangle:getRectanglePos()
	local minx, maxx, minz, maxz = self._rectangle:getRanges()

	return minx, minz
end

function BattleUnitCompTerrainRectangle:_tryMergeInGroup(unionIndexMap)
	local result = false

	if self:_tryExtendPositiveX(unionIndexMap) then
		result = true
	end

	if self:_tryExtendNegativeX(unionIndexMap) then
		result = true
	end

	if self:_tryExtendPositiveZ(unionIndexMap) then
		result = true
	end

	if self:_tryExtendNegativeZ(unionIndexMap) then
		result = true
	end

	if result then
		self:_tryMergeInGroup(unionIndexMap)
	end
end

function BattleUnitCompTerrainRectangle:_tryExtendPositiveX(unionIndexMap)
	local minx, maxx, minz, maxz = self._rectangle:getRanges()
	local tox = maxx + 1

	for z = minz, maxz do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tox, z)

		if not unionIndexMap[unionIndex] then
			return
		end
	end

	for z = minz, maxz do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tox, z)

		unionIndexMap[unionIndex] = false
	end

	self._rectangle:setMaxx(tox)

	return true
end

function BattleUnitCompTerrainRectangle:_tryExtendNegativeX(unionIndexMap)
	local minx, maxx, minz, maxz = self._rectangle:getRanges()
	local tox = minx - 1

	for z = minz, maxz do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tox, z)

		if not unionIndexMap[unionIndex] then
			return
		end
	end

	for z = minz, maxz do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tox, z)

		unionIndexMap[unionIndex] = false
	end

	self._rectangle:setMinx(tox)

	return true
end

function BattleUnitCompTerrainRectangle:_tryExtendPositiveZ(unionIndexMap)
	local minx, maxx, minz, maxz = self._rectangle:getRanges()
	local toz = maxz + 1

	for x = minx, maxx do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, toz)

		if not unionIndexMap[unionIndex] then
			return
		end
	end

	for x = minx, maxx do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, toz)

		unionIndexMap[unionIndex] = false
	end

	self._rectangle:setMaxz(toz)

	return true
end

function BattleUnitCompTerrainRectangle:_tryExtendNegativeZ(unionIndexMap)
	local minx, maxx, minz, maxz = self._rectangle:getRanges()
	local toz = minz - 1

	for x = minx, maxx do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, toz)

		if not unionIndexMap[unionIndex] then
			return
		end
	end

	for x = minx, maxx do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, toz)

		unionIndexMap[unionIndex] = false
	end

	self._rectangle:setMinz(toz)

	return true
end

function BattleUnitCompTerrainRectangle:setGroupType(type)
	self._groupType = type
end

function BattleUnitCompTerrainRectangle:getGroupType()
	return self._groupType
end

function BattleUnitCompTerrainRectangle:toString()
	return self._rectangle:toString()
end

return BattleUnitCompTerrainRectangle
