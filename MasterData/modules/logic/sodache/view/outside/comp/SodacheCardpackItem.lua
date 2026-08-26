-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheCardpackItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheCardpackItem", package.seeall)

local SodacheCardpackItem = class("SodacheCardpackItem", LuaCompBase)

function SodacheCardpackItem:init(go)
	self.txtLimit = gohelper.findChildText(go, "limit/txt_Limit")
	self.txtName = gohelper.findChildText(go, "name/txt_Name")
	self.txtPrice = gohelper.findChildText(go, "price/txt_Price")
	self.goCardItem = gohelper.findChild(go, "layout/go_CardItem")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function SodacheCardpackItem:onUpdateMO(mo)
	self.mo = mo
end

function SodacheCardpackItem:onSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self.goSelect, isSelect)
end

function SodacheCardpackItem:onClick()
	if self.isSelect then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem, self)
end

return SodacheCardpackItem
