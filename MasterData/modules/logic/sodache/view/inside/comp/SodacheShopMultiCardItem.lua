-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheShopMultiCardItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheShopMultiCardItem", package.seeall)

local SodacheShopMultiCardItem = class("SodacheShopMultiCardItem", LuaCompBase)

function SodacheShopMultiCardItem:ctor(param)
	self.cellParam = param
end

function SodacheShopMultiCardItem:init(go)
	self._anim = gohelper.findChildAnim(go, "Info/Right/go_Count")
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self._onItemClick, self)
	self.cardItem:showInfo({
		true,
		true,
		false
	})
end

function SodacheShopMultiCardItem:updateMo(mo)
	local isAdd = not not (self.cellParam.isMultSelect and self.mo and self.mo.cardMo.serverMo.configId == mo.cardMo.serverMo.configId and self.mo.count < mo.count)

	self.mo = mo

	self.cardItem:updateMo(mo.cardMo)
	self.cardItem:setCount(mo.count)

	if isAdd then
		self._anim:Play("buy", 0, 0)
	end
end

function SodacheShopMultiCardItem:_onItemClick()
	if self.cellParam.isMultSelect then
		self.cellParam:addGoodCount(self.mo.shopMo, -1)
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
	else
		ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
			cardMo = self.mo.cardMo
		})
	end
end

return SodacheShopMultiCardItem
