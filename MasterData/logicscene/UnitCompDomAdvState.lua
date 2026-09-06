-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domainadventure/UnitCompDomAdvState.lua

module("logicscene.scene.unit.component.domainadventure.UnitCompDomAdvState", package.seeall)

local UnitCompDomAdvState = class("UnitCompDomAdvState", UnitComponentBase)

UnitCompDomAdvState.selectResPath = "scene/season/board_saijiwanfa_selected.prefab"
UnitCompDomAdvState.markResPath = "scene/season/board_saijiwanfa_mark.prefab"
UnitCompDomAdvState.placedResPath = "scene/season/board_saijiwanfa_placed.prefab"
UnitCompDomAdvState.levelResPath = "scene/season/board_saijiwanfa_level.prefab"

function UnitCompDomAdvState:onInit()
	self._selectResObject = nil
	self._markResObject = nil
	self._placedResObject = nil
	self._levelResObject = nil
	self._isSelected = false
end

function UnitCompDomAdvState:onDestroy()
	self:_clearSelectResObj()
	self:_clearMarkResObj()
	self:_clearPlacedResObj()
	self:_clearLevelResObj()

	self._unit = nil
end

function UnitCompDomAdvState:setSelected(selected)
	self._isSelected = selected

	self:_updateSelectedStatus()
end

function UnitCompDomAdvState:onUnitVisible(go)
	self:_updateSelectedStatus()
	self:updateMarkedStatus()
	self:updatePlacedStatus()
	self:updateLevelStatus()
end

function UnitCompDomAdvState:onUnitInVisible(go)
	self:_clearSelectResObj()
	self:_clearMarkResObj()
	self:_clearPlacedResObj()
	self:_clearLevelResObj()
end

function UnitCompDomAdvState:_updateSelectedStatus()
	if self._unit:isClipping() or not self._isSelected then
		self:_clearSelectResObj()

		return
	end

	if not self._selectResObject then
		self._selectResObject = self._unit.scene.resCache:newObject(UnitCompDomAdvState.selectResPath)

		self._selectResObject:setParent(self._unit.go.transform)
		self._selectResObject:setScale(1)
		self._selectResObject:setLocalPos(0, 0, -0.015)
		self._selectResObject:setSortingOrder(self._unit:getSortingOrderOffset(1))

		self._selectResObject.loadedHandler = self._onSelectedResLoadedFinish
		self._selectResObject.loadedHandlerTarget = self
	else
		self:_onSelectedResLoadedFinish()
	end
end

function UnitCompDomAdvState:_onSelectedResLoadedFinish()
	if not self._selectResObject then
		return
	end

	local go = self._selectResObject.go

	if goutil.isNil(go) then
		return
	end

	local selected = goutil.findChild(go, "selected")
	local selected_blocked = goutil.findChild(go, "selected_blocked")
	local isGridWalkable = SeasonPathFindingDataModel.instance:isGridWalkable(self._unit.row, self._unit.col)

	if selected then
		selected:SetActive(isGridWalkable or false)
	end

	if selected_blocked then
		selected_blocked:SetActive(not isGridWalkable)
	end
end

function UnitCompDomAdvState:_clearSelectResObj()
	if self._selectResObject then
		self._unit.scene.resCache:recycleObject(self._selectResObject)

		self._selectResObject = nil
	end
end

function UnitCompDomAdvState:updateMarkedStatus()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local isMarked = SeasonModel.instance:isMark(gridId)

	if self._unit:isClipping() or not isMarked then
		self:_clearMarkResObj()

		return
	end

	if not self._markResObject then
		self._markResObject = self._unit.scene.resCache:newObject(UnitCompDomAdvState.markResPath)

		self._markResObject:setParent(self._unit.go.transform)
		self._markResObject:setScale(1)
		self._markResObject:setLocalPos(0, -0.068, -0.003)
		self._markResObject:setSortingOrder(0)
	end
end

function UnitCompDomAdvState:_clearMarkResObj()
	if self._markResObject then
		self._unit.scene.resCache:recycleObject(self._markResObject)

		self._markResObject = nil
	end
end

function UnitCompDomAdvState:updatePlacedStatus()
	local isPlaced = false

	if self._unit:isClipping() or not isPlaced then
		self:_clearPlacedResObj()

		return
	end

	if not self._placedResObject then
		self._placedResObject = self._unit.scene.resCache:newObject(UnitCompDomAdvState.placedResPath)

		self._placedResObject:setParent(self._unit.go.transform)
		self._placedResObject:setScale(1)
		self._placedResObject:setLocalPos(0, 0, -0.018)
		self._placedResObject:setSortingOrder(self._unit:getSortingOrderOffset(1))

		self._placedResObject.loadedHandler = self._onPlacedResLoadedFinish
		self._placedResObject.loadedHandlerTarget = self
	else
		self:_onPlacedResLoadedFinish()
	end
end

function UnitCompDomAdvState:_onPlacedResLoadedFinish()
	if not self._placedResObject then
		return
	end

	local go = self._placedResObject.go

	if goutil.isNil(go) then
		return
	end

	local placed = goutil.findChild(go, "placed")
	local blocked = goutil.findChild(go, "blocked")
	local isGridWalkable = SeasonPathFindingDataModel.instance:isGridWalkable(self._unit.row, self._unit.col)

	if placed then
		placed:SetActive(isGridWalkable or false)
	end

	if blocked then
		blocked:SetActive(not isGridWalkable)
	end
end

function UnitCompDomAdvState:_clearPlacedResObj()
	if self._placedResObject then
		self._unit.scene.resCache:recycleObject(self._placedResObject)

		self._placedResObject = nil
	end
end

function UnitCompDomAdvState:updateLevelStatus()
	if not self._levelResObject then
		self._levelResObject = self._unit.scene.resCache:newObject(UnitCompDomAdvState.levelResPath)

		self._levelResObject:setParent(self._unit.go.transform)
		self._levelResObject:setScale(1)
		self._levelResObject:setLocalPos(0, 0, 0)
		self._levelResObject:setSortingOrder(1)

		self._levelResObject.loadedHandler = self._onLevelResLoadedFinish
		self._levelResObject.loadedHandlerTarget = self
	else
		self:_onLevelResLoadedFinish()
	end
end

function UnitCompDomAdvState:_onLevelResLoadedFinish()
	if not self._levelResObject then
		return
	end

	local go = self._levelResObject.go

	if goutil.isNil(go) then
		return
	end

	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId) or {}

	for i = 1, 6 do
		local img = goutil.findChild(go, "Lv_" .. i)

		GameUtil.SetActive(img, i == checknumber(evtCfg.showLevel))
	end
end

function UnitCompDomAdvState:_clearLevelResObj()
	if self._levelResObject then
		self._unit.scene.resCache:recycleObject(self._levelResObject)

		self._levelResObject = nil
	end
end

return UnitCompDomAdvState
