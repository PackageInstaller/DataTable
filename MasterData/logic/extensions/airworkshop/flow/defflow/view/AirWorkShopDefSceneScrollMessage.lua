-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollMessage.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollMessage", package.seeall)

local M = class("AirWorkShopDefSceneScrollMessage", AirWorkShopDefSceneScrollBuildingBase)

function M:_updateCurBuildings()
	BattleTableUtil.clearTable(self._curBuildingCOList)

	for i, buildCO in ipairs(self._buildingCOList) do
		table.insert(self._curBuildingCOList, buildCO)
	end
end

function M:_getAllBuildingList()
	return AirWorkShopDefSceneModel.instance:getAvailableMessageCOList()
end

function M:_getUnitTagType()
	return AirWorkShopEnum.TabEnum.Message
end

function M:onBeginDragHeadItem(headItem, screenX, screenY)
	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	if not AirWorkShopDefSceneModel.instance:isEnableAdjustment() then
		return
	end

	if self._isDraging then
		return
	end

	if AirWorkShopDefSceneModel.instance:isDragging() then
		return
	end

	if AirWorkShopDefOperateUtil.isUnitReachLimit(self:_getUnitTagType()) then
		FloatWordMgr.instance:show(lang("tip_airwork_reach_limit"))

		return
	end

	self._isDraging = true
	self._selectedAnimation = true

	self:_setSceneDragEnable(false)

	self._dragUnit = self:_createDragUnit(headItem:getBuildingId())

	AirWorkShopDefSceneModel.instance:setDragging(true)
	self:setSelectedId(headItem:getBuildingId(), true)
	self:onDragHeadItem(headItem, screenX, screenY)
end

function M:_afterEndDrag(dragUnit, unionIndex)
	AirWorkShopDefSceneUtil.playPlaceEffect(dragUnit)
end

return M
