-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSelectPositionView.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSelectPositionView", package.seeall)

local M = class("AirWorkSelectPositionView", AirWorkMapBaseView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	M.super.buildUI(self)

	self._mapRootGo = self:getGo("air_workshop_select_coordinate_tips_-1236083249")
	self._btnClose = self:getBtn("air_workshop_select_coordinate_tips_-170231369")
	self._btnSure = self:getBtn("1&btn_middle_-31477526")

	self:createMap()
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function M:onEnter()
	local currModel = AirWorkShopDefMgr.instance:getModel()

	self._mapData = currModel:getModiedMapMO()

	self:_setMapData()
end

function M:onExitFinished()
	M.super.onExitFinished(self)
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:_onGridClick(index)
	M.super.onGridClick(self, index)

	local x, y = AirWorkShopUtil.convertToXY(index)

	printWarn("=======_onGridClick click====", index, x, y)

	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang(string.format("是否把坐标（%s,%s）设为终点坐标", x, y)))

	dialog:setConfirmListener(function()
		local params = {}

		params.type = AirWorkShopEnum.ConditionType.Move
		params.x = x
		params.y = y

		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_POSITION_SELECT, params)
		self:_setGridData(index, AirWorkShopEnum.UnitType.ConditionMovePosition)
	end, self)
end

function M:_onClickClose()
	self:close()
end

return M
