-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheWarehouseItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheWarehouseItem", package.seeall)

local SodacheWarehouseItem = class("SodacheWarehouseItem", ListScrollCell)

function SodacheWarehouseItem:init(go)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self.onClick, self)
end

function SodacheWarehouseItem:onUpdateMO(mo)
	self.mo = mo

	self.cardItem:updateMo(mo)
end

function SodacheWarehouseItem:onSelect(isSelect)
	self.isSelect = isSelect

	self.cardItem:setActiveSelect(isSelect)
end

function SodacheWarehouseItem:onClick()
	if self.isSelect then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickWarehouseItem, self._index)
end

return SodacheWarehouseItem
