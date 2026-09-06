-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/UnitCompSeasonOccupied.lua

module("logicscene.scene.unit.component.season.UnitCompSeasonOccupied", package.seeall)

local UnitCompSeasonOccupied = class("UnitCompSeasonOccupied", UnitComponentBase)

UnitCompSeasonOccupied.occupiedResPath = "scene/season/board_saijiwanfa_occupied.prefab"
UnitCompSeasonOccupied.directions = {
	{
		{
			0,
			1
		},
		{
			1,
			0
		},
		{
			1,
			-1
		},
		{
			0,
			-1
		},
		{
			-1,
			-1
		},
		{
			-1,
			0
		}
	},
	{
		{
			0,
			1
		},
		{
			1,
			1
		},
		{
			1,
			0
		},
		{
			0,
			-1
		},
		{
			-1,
			0
		},
		{
			-1,
			1
		}
	}
}
UnitCompSeasonOccupied.hexVertices = {
	{
		-0.37,
		0.493
	},
	{
		0.37,
		0.493
	},
	{
		0.74,
		0
	},
	{
		0.37,
		-0.493
	},
	{
		-0.37,
		-0.493
	},
	{
		-0.74,
		0
	}
}

function UnitCompSeasonOccupied:onInit()
	self._occupiedResObject = nil
end

function UnitCompSeasonOccupied:onDestroy()
	self:_clearOccupiedResObj()

	self._unit = nil
end

function UnitCompSeasonOccupied:onUnitVisible(go)
	self:updateOccupiedStatus()
end

function UnitCompSeasonOccupied:onUnitInVisible(go)
	self:_clearOccupiedResObj()
end

function UnitCompSeasonOccupied:updateOccupiedStatus()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local isOccupied = SeasonModel.instance:isOccupied(gridId)

	if self._unit:isClipping() or not isOccupied then
		self:_clearOccupiedResObj()

		return
	end

	if not self._occupiedResObject then
		self._occupiedResObject = self._unit.scene.resCache:newObject(UnitCompSeasonOccupied.occupiedResPath)

		self._occupiedResObject:setParent(self._unit.go.transform)
		self._occupiedResObject:setScale(1)
		self._occupiedResObject:setLocalPos(0, 0, -0.01)
		self._occupiedResObject:setSortingOrder(self._unit:getSortingOrderOffset(1))

		self._occupiedResObject.loadedHandler = self._onOccupiedResLoadedFinish
		self._occupiedResObject.loadedHandlerTarget = self
	else
		self:_onOccupiedResLoadedFinish()
	end
end

function UnitCompSeasonOccupied:onSeasonMinimapOpenedOrClosed(opened)
	self:updateOccupiedStatus()
end

function UnitCompSeasonOccupied:prepareMiniMapReady()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local isOccupied = SeasonModel.instance:isOccupied(gridId)

	return isOccupied and self._occupiedResObject and self._occupiedResObject.go and self._occupiedResObject.go.activeSelf or true
end

function UnitCompSeasonOccupied:_onOccupiedResLoadedFinish()
	if not self._occupiedResObject then
		return
	end

	local go = self._occupiedResObject.go

	if goutil.isNil(go) then
		return
	end

	local occupied = goutil.findChild(go, "occupied")
	local minimap = goutil.findChild(go, "minimap")
	local isMinimapOpened = SeasonController.instance:isMinimapOpened()

	minimap:SetActive(isMinimapOpened)
	occupied:SetActive(not isMinimapOpened)

	if not self._edges then
		self._edges = {}

		for i = 1, 6 do
			local edge = goutil.findChild(go.transform, "occupied" .. i - 1)

			if edge then
				self._edges[i] = edge.gameObject

				GoUtil.SetSortingOrder(self._edges[i], -503)
			end
		end
	end

	for i = 1, 6 do
		local edge = self._edges[i]

		if isMinimapOpened then
			if edge then
				edge:SetActive(false)
			end
		else
			if edge then
				edge:SetActive(true)
			end

			self:_checkEdgesVisible(i)
		end
	end
end

function UnitCompSeasonOccupied:_isEdgeVisible(edgeIndex)
	if edgeIndex > 6 then
		edgeIndex = 1
	end

	if edgeIndex < 1 then
		edgeIndex = 6
	end

	local dirIndex = self._unit.row % 2 + 1
	local dirs = UnitCompSeasonOccupied.directions[dirIndex]
	local edge = self._edges[edgeIndex]

	if not edge then
		return false
	end

	local scene = SceneMgr.instance:getCurScene()
	local eRow = self._unit.row + dirs[edgeIndex][1]
	local eCol = self._unit.col + dirs[edgeIndex][2]
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(eRow, eCol)
	local gridUnit = scene.gridUnitsMgr:getGridUnit(eRow, eCol)

	return gridUnit == nil or not SeasonModel.instance:isOccupied(gridId)
end

function UnitCompSeasonOccupied:_checkEdgesVisible(edgeIndex)
	local edge = self._edges[edgeIndex]

	if not edge then
		return
	end

	local dirIndex = self._unit.row % 2 + 1
	local dirs = UnitCompSeasonOccupied.directions[dirIndex]
	local scene = SceneMgr.instance:getCurScene()
	local eRow = self._unit.row + dirs[edgeIndex][1]
	local eCol = self._unit.col + dirs[edgeIndex][2]

	if not scene or not scene.gridUnitsMgr then
		return
	end

	local gridUnit = scene.gridUnitsMgr:getGridUnit(eRow, eCol)
	local isVisible = self:_isEdgeVisible(edgeIndex)
	local spRenderer = edge:GetComponent(ComponentType.SpriteRenderer)

	spRenderer.enabled = isVisible

	local linkEdge0 = goutil.findChild(edge.transform, "0")
	local linkEdge1 = goutil.findChild(edge.transform, "1")

	if isVisible then
		linkEdge0:SetActive(false)
		linkEdge1:SetActive(false)

		return
	end

	local offsetY = self._unit:getPositionOffsetY()
	local ofsy = 0

	if gridUnit then
		ofsy = gridUnit:getPositionOffsetY()
	end

	if offsetY <= ofsy then
		linkEdge0:SetActive(false)
		linkEdge1:SetActive(false)

		return
	elseif edgeIndex == 1 and ofsy < offsetY then
		linkEdge0:SetActive(false)
		linkEdge1:SetActive(false)

		return
	end

	local isShowEdge0 = self:_isEdgeVisible(edgeIndex - 1)
	local isShowEdge1 = self:_isEdgeVisible(edgeIndex + 1)

	linkEdge0:SetActive(isShowEdge0)
	linkEdge1:SetActive(isShowEdge1)

	if not isShowEdge0 and not isShowEdge1 then
		return
	end

	local edgeVerts0, edgeVerts1 = self:_getEdgeVertices(edgeIndex)
	local nearIndex = edgeIndex + 3

	if nearIndex > 6 then
		nearIndex = nearIndex - 6
	end

	local nearEdgeVerts0, nearEdgeVerts1 = self:_getEdgeVertices(nearIndex)
	local gridX, gridY = SeasonPathFindingDataModel.instance:grid2Pos(self._unit.row, self._unit.col)
	local nearGridX, nearGridY = SeasonPathFindingDataModel.instance:grid2Pos(gridUnit.row, gridUnit.col)
	local wPos0X, wPos0Y = edgeVerts0[1] + gridX, edgeVerts0[2] + gridY + offsetY
	local wPos1X, wPos1Y = edgeVerts1[1] + gridX, edgeVerts1[2] + gridY + offsetY
	local nearWPos0X, nearWPos0Y = nearEdgeVerts0[1] + nearGridX, nearEdgeVerts0[2] + nearGridY + ofsy
	local nearWPos1X, nearWPos1Y = nearEdgeVerts1[1] + nearGridX, nearEdgeVerts1[2] + nearGridY + ofsy
	local lineDir0X, lineDir0Y = nearWPos1X - wPos0X, nearWPos1Y - wPos0Y
	local lineDir1X, lineDir1Y = nearWPos0X - wPos1X, nearWPos0Y - wPos1Y
	local angle0 = GoUtil.SignedAngleWithX(lineDir0X, lineDir0Y)
	local angle1 = GoUtil.SignedAngleWithX(lineDir1X, lineDir1Y)

	Framework.TransformUtil.SetEuler(linkEdge0.transform, 0, 0, angle0)
	Framework.TransformUtil.SetEuler(linkEdge1.transform, 0, 0, angle1)

	local length0 = math.sqrt(lineDir0X * lineDir0X + lineDir0Y * lineDir0Y)
	local length1 = math.sqrt(lineDir1X * lineDir1X + lineDir1Y * lineDir1Y)

	Framework.TransformUtil.SetEuler(linkEdge0.transform, 0, 0, angle0)
	Framework.TransformUtil.SetEuler(linkEdge1.transform, 0, 0, angle1)

	local scale0X = length0 / 0.6
	local scale1X = length1 / 0.6

	Framework.TransformUtil.SetLocalScale(linkEdge0.transform, scale0X, 1, 1)
	Framework.TransformUtil.SetLocalScale(linkEdge1.transform, scale1X, 1, 1)

	local center0X, center0Y = (wPos0X + nearWPos1X) * 0.5, (wPos0Y + nearWPos1Y) * 0.5
	local center1X, center1Y = (wPos1X + nearWPos0X) * 0.5, (wPos1Y + nearWPos0Y) * 0.5

	Framework.TransformUtil.SetPos(linkEdge0.transform, center0X, center0Y, 0)
	Framework.TransformUtil.SetPos(linkEdge1.transform, center1X, center1Y, 0)
end

function UnitCompSeasonOccupied:_clearOccupiedResObj()
	if self._occupiedResObject then
		self._unit.scene.resCache:recycleObject(self._occupiedResObject)

		self._occupiedResObject = nil
	end

	self._edges = nil
end

function UnitCompSeasonOccupied:_getEdgeVertices(edgeIndex)
	local nextIdx = edgeIndex + 1

	if nextIdx > #UnitCompSeasonOccupied.hexVertices then
		nextIdx = 1
	end

	return UnitCompSeasonOccupied.hexVertices[edgeIndex], UnitCompSeasonOccupied.hexVertices[nextIdx]
end

return UnitCompSeasonOccupied
