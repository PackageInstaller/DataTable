-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheSettleUnselectCardItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheSettleUnselectCardItem", package.seeall)

local SodacheSettleUnselectCardItem = class("SodacheSettleUnselectCardItem", LuaCompBase)

function SodacheSettleUnselectCardItem:ctor(cellParam)
	self.cellParam = cellParam
end

function SodacheSettleUnselectCardItem:init(go)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self.onCardClick, self)
end

function SodacheSettleUnselectCardItem:updateMo(mo)
	self.data = mo

	self.cardItem:updateMo(mo)
end

function SodacheSettleUnselectCardItem:onCardClick()
	if self.cellParam.isBatch then
		self.cellParam:addSelectItem(self.data.serverMo.configId, 1, true)
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
	else
		if self.cellParam:getItemSelectMaxCount(self.data.serverMo.configId) <= 0 then
			if self.cellParam.isUseCost then
				GameFacade.showToast(ToastEnum.SodacheToastId373010)
			else
				GameFacade.showToast(ToastEnum.SodacheToastId373011)
			end

			return
		end

		ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
			isAdd = true,
			cardMo = self.data,
			subView = SodacheCardDetailSettlePart.New(),
			selectMo = self.cellParam
		})
	end
end

return SodacheSettleUnselectCardItem
