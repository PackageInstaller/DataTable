-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/layout/AirWorkLayoutBuildingPanel.lua

module("logic.extensions.airworkshop.flow.defflow.view.layout.AirWorkLayoutBuildingPanel", package.seeall)

local M = class("AirWorkLayoutBuildingPanel")

function M:ctor(container)
	self._go = container.gameObject
	self._imgQuality = goutil.findChild(self._go, "backpack_item/imgQuality")
	self._imgIcon = goutil.findChild(self._go, "backpack_item/imgIcon")
	self._txtType = goutil.findChildTextComponent(self._go, "txt1")
	self._txtPosition = goutil.findChildTextComponent(self._go, "txtPosition")
	self._btnRecovery = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnRecovery"))

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnRecovery:AddClickListener(self._onClickRecovery, self)
end

function M:_unbindEvents()
	self._btnRecovery:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data, index)
	self._data = data or {}

	local buildingCo = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioBuilding, self._data:getId())

	self._txtType.text = buildingCo.name
	self._txtPosition.text = string.format("(%s,%s)", AirWorkShopUtil.convertToXY(index))

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, buildingCo.icon)
end

function M:_onClickRecovery()
	local buildingCo = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioBuilding, self._data:getId())
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang(string.format("是否确定要回收%s？", buildingCo.name)))

	dialog:setConfirmListener(function()
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_LAYOUT_CHANGE, self._data)
	end, self)
end

return M
