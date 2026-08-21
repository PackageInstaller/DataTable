-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/record/AirWorkRecordVIew.lua

module("logic.extensions.airworkshop.flow.defflow.view.record.AirWorkRecordVIew", package.seeall)

local M = class("AirWorkRecordVIew", AirWorkMapBaseView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	M.super.buildUI(self)

	self._mapRootGo = self:getGo("air_workshop_level_record_tips_-1236083249")
	self._btnClose = self:getBtn("air_workshop_level_record_tips_-170231369")
	self._btnStatistic = self:getBtn("air_workshop_level_record_tips_-786141025")
	self._toggle = self:getUIComponent("air_workshop_level_record_tips_1131262218", UIComponentType.SpaceXToggle)

	goutil.setActive(self._btnStatistic.transform.parent.gameObject, true)
	self:createMap()
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStatistic:AddClickListener(self._onClickStatistic, self)
	self._toggle:AddListener(self._onToggle, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStatistic:RemoveClickListener()
	self._toggle:RemoveListener()
end

function M:onEnter()
	self:_addEvents(true)

	self._levelData = self:getFirstParam()
	self._mapData = self._levelData:getMapMO()

	self:_setMapData()
	AirWorkShopDefAgent.instance:sendGetAirMapCellKillRequest(self._levelData:getId())
	self:_refresh()
end

function M:onExitFinished()
	self:_addEvents(false)
	M.super.onExitFinished(self)
	ViewMgr.instance:close(ViewName.AirWorkShopShowKillView)
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:_addEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_CELL_KILLDATA_DONE, self._refresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_CELL_KILLDATA_DONE, self._refresh, self)
	end
end

function M:_refresh(e, params)
	self._cellKillMoList = AirWorkMapModel.instance:getCellKillData()

	self:_onToggle(nil, true)
end

function M:_getCellKillData(unionIndex)
	for i, v in ipairs(self._cellKillMoList) do
		if v:getUnionIndex() == unionIndex then
			return v
		end
	end
end

function M:_onGridClick(index)
	M.super.onGridClick(self, index)

	local x, y = AirWorkShopUtil.convertToXY(index)

	printWarn("=======_onGridClick click====", index, x, y)

	if self._showCellKill then
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, y)
		local cellKillData = self:_getCellKillData(unionIndex)

		if cellKillData then
			if not ViewMgr.instance:isOpen(ViewName.AirWorkShopShowKillView) then
				ViewMgr.instance:open(ViewName.AirWorkShopShowKillView, cellKillData)
			else
				GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_CELL_KILLDATA_CHANGE, cellKillData)
			end
		else
			FloatWordMgr.instance:show(lang("该坐标没有击杀数据"))
		end
	end
end

function M:_onToggle(toggle, isOn)
	self._showCellKill = isOn

	self:showKillData(self._cellKillMoList, isOn)

	if not isOn then
		ViewMgr.instance:close(ViewName.AirWorkShopShowKillView)
	end

	if not isOn then
		self:_setMapData()
	end
end

function M:_onClickStatistic()
	local params = {}

	params.mapId = self._levelData:getId()
	params.showTabCount = 3

	ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
end

function M:_onClickClose()
	self:close()
end

return M
