-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/treasureraider/UnitCompTreasureRaiderGridState.lua

module("logicscene.scene.unit.component.treasureraider.UnitCompTreasureRaiderGridState", package.seeall)

local UnitCompTreasureRaiderGridState = class("UnitCompTreasureRaiderGridState", UnitComponentBase)

UnitCompTreasureRaiderGridState.RoutePath = "scene/tiling/treasure_raider/treasure_raider_path.prefab"

function UnitCompTreasureRaiderGridState:onInit()
	self._routePathResObject = nil
end

function UnitCompTreasureRaiderGridState:onDestroy()
	self:_clearRoutePathResObj()
end

function UnitCompTreasureRaiderGridState:onUnitVisible(go)
	self:updateRoutePathStatus()
end

function UnitCompTreasureRaiderGridState:onUnitInVisible(go)
	self:_clearRoutePathResObj()
end

function UnitCompTreasureRaiderGridState:updateMovePath(movePathMap)
	self._movePathMap = movePathMap

	self:updateRoutePathStatus()
end

function UnitCompTreasureRaiderGridState:updateRoutePathStatus()
	local tool = self._unit.scene:getTool()
	local gridId = tool:grid2Id(self._unit.row, self._unit.col)

	if self._unit:isClipping() or not tool:isMovePathGrid(gridId) or not self._movePathMap or not self._movePathMap[gridId] then
		self:_clearRoutePathResObj()

		return
	end

	if not self._routePathResObject then
		self._routePathResObject = self._unit.scene.resCache:newObject(UnitCompTreasureRaiderGridState.RoutePath)

		self._routePathResObject:setParent(self._unit.go.transform)
		self._routePathResObject:setScale(1)
		self._routePathResObject:setLocalPos(0, 0, -0.015)
		self._routePathResObject:setSortingOrder(self._unit:getSortingOrderOffset(SeasonLayerTypes.LAYER_GROUND_DOWN))

		self._routePathResObject.loadedHandler = self._onSelectedResLoadedFinish
		self._routePathResObject.loadedHandlerTarget = self
	else
		self:_onRoutePathResLoadedFinish()
	end
end

function UnitCompTreasureRaiderGridState:_onRoutePathResLoadedFinish()
	return
end

function UnitCompTreasureRaiderGridState:_clearRoutePathResObj()
	if self._routePathResObject then
		self._unit.scene.resCache:recycleObject(self._routePathResObject)

		self._routePathResObject = nil
	end
end

return UnitCompTreasureRaiderGridState
