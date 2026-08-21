-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopCheckerBoardMgr.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopCheckerBoardMgr", package.seeall)

local M = class("AirWorkShopCheckerBoardMgr", IBattleFlowComp)
local tempVec3 = Vector3.New()
local kSearchDirections = {
	Coordinates.New(1, 0),
	Coordinates.New(0, 1),
	Coordinates.New(-1, 0),
	Coordinates.New(0, -1)
}

function M:onInit()
	self._activeCheckerBoard = false
	self._visibleSignAmount = SignalAmount.New()
end

function M:onStart()
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false

	self._visibleSignAmount:clear()

	self._nodeArray = Array2D.New()
end

function M:onClear()
	self:_destroyActiveBaord()

	self._resMgr = false
	self._boardModel = false
	self._unitMgr = false
	self._nodeArray = false
end

function M:onResourceLoaded()
	local model = self.flow.model

	self:setActiveCheckerBoard(model:getBattleSceneCode())
end

function M:onEnterDone()
	self:_buildNodes()
	self:spreadCheckerBoard()
end

function M:_buildNodes()
	local boardModel = self._boardModel
	local boardMO = self._boardModel:getActiveBoardMO()
	local pathNodes = self._nodeArray

	pathNodes:setWidthAndHeight(boardMO:getWidth(), boardMO:getHeight())

	for _, cellMO in boardMO:ipairs() do
		local x, z = cellMO:getCoordinates()

		pathNodes:setElement(x, z, CheckerBoardPathNode.New(cellMO))
	end

	for _, node in pathNodes:ipairs() do
		local x, z = node:getCoordinates()

		for _, deltaCoordinates in pairs(kSearchDirections) do
			local dx, dz = deltaCoordinates:getXZ()

			dx = x + dx
			dz = z + dz

			if boardModel:isValideCoordinates(dx, dz) then
				local neighborNode = pathNodes:getElement(dx, dz)

				node:addNeighbor(neighborNode)
			end
		end
	end
end

function M:setActiveCheckerBoard(checkerBoardCode)
	self:_destroyActiveBaord()
	self._boardModel:setActiveBoardCode(checkerBoardCode)

	local boardMO = self._boardModel:getActiveBoardMO()

	self._activeCheckerBoard = self:_createCheckerBoard(boardMO)

	local position = boardMO:getInitPosition()

	VirtualCameraMgr.instance:setConfinerPosition(position.x, 0, position.z)
end

function M:spreadCheckerBoard()
	local activeBoard = self:getActiveCheckerBoard()
	local resultNodeArray = self._nodeArray
	local minx, maxx, minz, maxz = BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN, BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN

	for _, resultNode in resultNodeArray:ipairs() do
		local x, z = resultNode:getCoordinates()
		local layerColorIndex = BattleEnum.CellColor.NORMAL
		local fillColorIndex = BattleEnum.CellColor.NORMAL
		local layer = BattleEnum.CellLayer.STOPABLE

		fillColorIndex = BattleEnum.CellColor.STOPABLE
		layerColorIndex = BattleEnum.CellColor.STOPABLE

		if layerColorIndex ~= BattleEnum.CellColor.NORMAL then
			minx = math.min(minx, x)
			maxx = math.max(maxx, x)
			minz = math.min(minz, z)
			maxz = math.max(maxz, z)
		end

		activeBoard:SetCellColor(x, z, layer, layerColorIndex, fillColorIndex)
	end

	if useTween then
		local centerX, centerZ = unit.transform:getCoordinates()

		activeBoard:DOTriangulate(centerX, centerZ)
	else
		activeBoard:Triangulate()
	end
end

function M:exchangeUnitToUnionIndex(unit, unionIndex)
	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	printWarn("viking", "exchangeUnitToUnionIndex", unit.property:getName(), unionIndex)

	local oldUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex, unit.property:getTabType())

	if oldUnit then
		self._boardModel:removeUnit(unit)
		self:setUnitToUnionIndex(oldUnit, unitUnionIndex)
	end

	self:setUnitToUnionIndex(unit, unionIndex)
end

function M:setUnitToUnionIndex(unit, unionIndex)
	self._boardModel:setUnitToUnionIndex(unit, unionIndex)

	local position = self:getCellPosition(unionIndex)

	unit.mover:setPosDirectly(position.x, position.z)
	unit.property:setUnionIndex(unionIndex)
end

function M:removeUnit(unit)
	self._boardModel:removeUnit(unit)
end

function M:getCellPosition(unionIndex)
	local position = tempVec3
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local wx, wy, wz = self._activeCheckerBoard:GetCellPosition(x, z, 0, 0, 0)

	position:Set(wx, wy, wz)

	return position
end

function M:getCellPositionXYZ(unionIndex)
	local position = self:getCellPosition(unionIndex)

	return position:Get()
end

function M:setVisibleByKey(visible, key)
	if visible then
		self._visibleSignAmount:remove(key)
	else
		self._visibleSignAmount:addUnique(key)
	end

	visible = self._visibleSignAmount:isUnactive()

	self._activeCheckerBoard:SetVisible(visible)
end

function M:getActiveCheckerBoard()
	return self._activeCheckerBoard
end

function M:resetAllSign()
	local activeBoard = self._activeCheckerBoard
	local boardMO = self._boardModel:getActiveBoardMO()

	for _, cellMO in boardMO:ipairs() do
		local x, z = cellMO:getCoordinates()

		activeBoard:SetCellColor(x, z, BattleEnum.CellColor.NORMAL, BattleEnum.CellColor.NORMAL, BattleEnum.CellColor.NORMAL)
	end

	activeBoard:Triangulate()
end

function M:rebuildBoard()
	self._activeCheckerBoard:Triangulate()
end

function M:calculateWorldYOffset(px, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)
	local wx, wy, wz = self._activeCheckerBoard:GetCellPosition(x, z, 0, 0, 0)

	return wy
end

function M:calculateBaseWorldYOffset(px, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)

	return self._activeCheckerBoard:GetCheckerBoardBaseHeight(x, z)
end

function M:worldPosition2UnionIndex(px, py, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)

	if self._boardModel:isValideCoordinates(x, z) then
		return BoardIndexConverter.coordinatesToUnionIndex(x, z)
	end

	return -1
end

function M:interpolateWorldYOffset(px, pz)
	return self._activeCheckerBoard:InterpolateWorldLogicHeight(px, 0, pz)
end

function M:_destroyActiveBaord()
	if self._activeCheckerBoard then
		goutil.destroy(self._activeCheckerBoard.gameObject)

		self._activeCheckerBoard = false

		local heightMapProxy = SpaceX.HeightMapProxy

		heightMapProxy.SetActiveHeightMapProxy(nil)
		heightMapProxy.SetActiveCheckerBoard(nil)
	end
end

function M:_createCheckerBoard(boardMO)
	local resMgr = self._resMgr
	local boardInst = resMgr:getInst(BattleResourceName.CheckerBoard)

	BattleGameObjectRootUtil.addToSignsRoot(boardInst)

	local initPosition = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(boardInst.transform, initPosition.x, BattleConst.YOffsetBoard, initPosition.z)

	local checkerBoard = SpaceX.CheckerBoard.Get(boardInst)

	checkerBoard:ParseLuaConfig(boardMO:getOriginalConfig())

	local scene = SceneMgr.instance:getScene(SceneType.AirWorkShop)
	local heightMapProxy = SpaceX.HeightMapProxy

	heightMapProxy.SetActiveCheckerBoard(checkerBoard)
	checkerBoard:BuildCollider()
	checkerBoard:SetDrawCallBackFunc(self._onCellSpread, self)

	return checkerBoard
end

function M:_onCellSpread(x, z)
	return
end

return M
