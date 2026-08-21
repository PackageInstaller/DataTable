-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/layout/AirWorkLayoutRolePanel.lua

module("logic.extensions.airworkshop.flow.defflow.view.layout.AirWorkLayoutRolePanel", package.seeall)

local M = class("AirWorkLayoutRolePanel")

function M:ctor(container)
	self._go = container.gameObject
	self._itemHero = goutil.findChild(self._go, "hero_item")
	self._txtType = goutil.findChildTextComponent(self._go, "txt1")
	self._txtPosition = goutil.findChildTextComponent(self._go, "txtPosition")
	self._btnDown = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnLower"))
	self._btnEdit = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnEdit"))

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnDown:AddClickListener(self._onClickDown, self)
	self._btnEdit:AddClickListener(self._onClickEdit, self)
end

function M:_unbindEvents()
	self._btnDown:RemoveClickListener()
	self._btnEdit:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
	self._shower:unbindEvents()
end

function M:updateData(data, index)
	self._data = data or {}
	self._txtType.text = self._data:getUnitType() == AirWorkShopEnum.UnitType.Hero and "防守角色" or "伏兵角色"
	self._txtPosition.text = string.format("(%s,%s)", AirWorkShopUtil.convertToXY(index))
	self._shower = Astral.LuaComponentContainer.Add(self._itemHero, HeroHeadItem)

	local heroId = self._data:getId()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self._shower:setHeroMO(heroData)
end

function M:_onClickDown()
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("下阵后会清除所有设置，是否继续进行操作？"))

	dialog:setConfirmListener(function()
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_LAYOUT_CHANGE, self._data)
	end, self)
end

function M:_onClickEdit()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._data:getEntityId())

	ViewMgr.instance:open(ViewName.AirWorkShopDefMessageSetView, unit.property:getUnitMO())
end

return M
