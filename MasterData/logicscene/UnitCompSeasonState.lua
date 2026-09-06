-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/UnitCompSeasonState.lua

module("logicscene.scene.unit.component.season.UnitCompSeasonState", package.seeall)

local UnitCompSeasonState = class("UnitCompSeasonState", UnitComponentBase)

UnitCompSeasonState.selectResPath = "scene/season/board_saijiwanfa_selected.prefab"
UnitCompSeasonState.markResPath = "scene/season/board_saijiwanfa_mark.prefab"
UnitCompSeasonState.placedResPath = "scene/season/board_saijiwanfa_placed.prefab"
UnitCompSeasonState.levelResPath = "scene/season/board_saijiwanfa_level.prefab"

function UnitCompSeasonState:onInit()
	self._selectResObject = nil
	self._markResObject = nil
	self._placedResObject = nil
	self._levelResObject = nil
	self._isSelected = false
end

function UnitCompSeasonState:onDestroy()
	self:_clearSelectResObj()
	self:_clearMarkResObj()
	self:_clearPlacedResObj()
	self:_clearLevelResObj()

	self._unit = nil
end

function UnitCompSeasonState:setSelected(selected)
	self._isSelected = selected

	self:_updateSelectedStatus()
end

function UnitCompSeasonState:onUnitVisible(go)
	self:_updateSelectedStatus()
	self:updateMarkedStatus()
	self:updatePlacedStatus()
	self:updateLevelStatus()
end

function UnitCompSeasonState:onUnitInVisible(go)
	self:_clearSelectResObj()
	self:_clearMarkResObj()
	self:_clearPlacedResObj()
	self:_clearLevelResObj()
end

function UnitCompSeasonState:_updateSelectedStatus()
	if self._unit:isClipping() or not self._isSelected then
		self:_clearSelectResObj()

		return
	end

	if not self._selectResObject then
		self._selectResObject = self._unit.scene.resCache:newObject(UnitCompSeasonState.selectResPath)

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

function UnitCompSeasonState:_onSelectedResLoadedFinish()
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

function UnitCompSeasonState:_clearSelectResObj()
	if self._selectResObject then
		self._unit.scene.resCache:recycleObject(self._selectResObject)

		self._selectResObject = nil
	end
end

function UnitCompSeasonState:updateMarkedStatus()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local isMarked = SeasonModel.instance:isMark(gridId)

	if self._unit:isClipping() or not isMarked then
		self:_clearMarkResObj()

		return
	end

	if not self._markResObject then
		self._markResObject = self._unit.scene.resCache:newObject(UnitCompSeasonState.markResPath)

		self._markResObject:setParent(self._unit.go.transform)
		self._markResObject:setScale(1)
		self._markResObject:setLocalPos(0, -0.068, -0.003)
		self._markResObject:setSortingOrder(0)
	end
end

function UnitCompSeasonState:_clearMarkResObj()
	if self._markResObject then
		self._unit.scene.resCache:recycleObject(self._markResObject)

		self._markResObject = nil
	end
end

function UnitCompSeasonState:updatePlacedStatus()
	local scene = SceneMgr.instance:getCurScene()
	local isPlaced = self._unit.scene.gridUnitsMgr:isAimmingGrid()

	if self._unit:isClipping() or not isPlaced then
		self:_clearPlacedResObj()

		return
	end

	if not self._placedResObject then
		self._placedResObject = self._unit.scene.resCache:newObject(UnitCompSeasonState.placedResPath)

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

function UnitCompSeasonState:_onPlacedResLoadedFinish()
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

function UnitCompSeasonState:_clearPlacedResObj()
	if self._placedResObject then
		self._unit.scene.resCache:recycleObject(self._placedResObject)

		self._placedResObject = nil
	end
end

function UnitCompSeasonState:updateLevelStatus()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)
	local isShowLevel = self._unit.scene.gridUnitsMgr:isShowLevelGrid()

	if self._unit:isClipping() or not isShowLevel or evtCfg == nil or checknumber(evtCfg.showLevel) <= 0 then
		self:_clearLevelResObj()

		return
	end

	if not self._levelResObject then
		self._levelResObject = self._unit.scene.resCache:newObject(UnitCompSeasonState.levelResPath)

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

function UnitCompSeasonState:_onLevelResLoadedFinish()
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

function UnitCompSeasonState:_clearLevelResObj()
	if self._levelResObject then
		self._unit.scene.resCache:recycleObject(self._levelResObject)

		self._levelResObject = nil
	end
end

return UnitCompSeasonState
