-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopUnitOperator.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopUnitOperator", package.seeall)

local M = class("BattleUnitOperator", IAirWorkShopFlowComp)

function M:onInit()
	return
end

function M:onStart()
	self._model = self.flow.model or false
	self._settingModel = self.flow.settingModel or false
	self._boardMgr = self.flow.boardMgr or false
	self._unitMgr = self.flow.unitMgr or false
	self._boardModel = self.flow.boardModel or false
	self._pathFinder = self.flow.pathFinder or false
	self._hotAreaChecker = self.flow.hotAreaChecker or false

	self:_onReset()
	self:_setEvents(true)
end

function M:onClear()
	self:_onReset()
	self:_setEvents(false)
end

function M:_onReset()
	self._focusUnit = false
end

function M:_setEvents(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_EDIT_TAB_UPDATE, self._onTabUpdate, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_EDIT_TAB_UPDATE, self._onTabUpdate, self)
	end
end

function M:_onTabUpdate()
	AirWorkShopDefOperateUtil.clearSceneFocusUnit()
end

function M:onTouchCell(unionIndex, isDoubleClick)
	printWarn("viking", "onTouchCell", unionIndex)
	self:clearFocusUnit()

	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if unit then
		if not AirWorkShopDefOperateUtil.isUnitVisible(unit) then
			AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, unit.property:getTabType())
		end

		self._focusUnit = unit

		unit.uiProxy:setOperatorVisible(true)
		self._hotAreaChecker:tryMoveCameraInHotArea(unionIndex, unionIndex)

		if self._focusUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Building then
			local entityCode = self._focusUnit.property:getEntityCode()
			local entityCO = AirWorkShopConfig.instance:getBuildingCO(entityCode)

			AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, entityCO.terrainId)
		else
			AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, false)
		end
	else
		self:onTouchEmpty()
	end
end

function M:onTouchEmpty(isDoubleClick)
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_CLICK_EMPTY_PLACE)
	self:clearFocusUnit()
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, false)
	printWarn("viking", "onTouchEmpty")
end

function M:exitEditMode()
	self:clearFocusUnit()
end

function M:clearFocusUnit()
	if self._focusUnit then
		self._focusUnit.uiProxy:setOperatorVisible(false)

		self._focusUnit = false
	end
end

return M
