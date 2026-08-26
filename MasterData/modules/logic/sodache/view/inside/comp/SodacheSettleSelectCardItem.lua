-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheSettleSelectCardItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheSettleSelectCardItem", package.seeall)

local SodacheSettleSelectCardItem = class("SodacheSettleSelectCardItem", LuaCompBase)

function SodacheSettleSelectCardItem:ctor(cellParam)
	self.cellParam = cellParam
end

function SodacheSettleSelectCardItem:init(go)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self.onCardClick, self)
end

function SodacheSettleSelectCardItem:updateMo(mo)
	self.data = mo

	self.cardItem:updateMo(mo)
end

function SodacheSettleSelectCardItem:onCardClick()
	if self.cellParam.isBatch then
		self.cellParam:addUnselectItem(self.data.serverMo.configId, 1)
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
	else
		ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
			isAdd = false,
			cardMo = self.data,
			subView = SodacheCardDetailSettlePart.New(),
			selectMo = self.cellParam
		})
	end
end

return SodacheSettleSelectCardItem
