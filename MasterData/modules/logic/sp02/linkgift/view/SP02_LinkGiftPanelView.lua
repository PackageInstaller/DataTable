-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftPanelView.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftPanelView", package.seeall)

local SP02_LinkGiftPanelView = class("SP02_LinkGiftPanelView", SP02_LinkGiftBaseView)

function SP02_LinkGiftPanelView:onInitView()
	SP02_LinkGiftPanelView.super.onInitView(self)

	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
end

function SP02_LinkGiftPanelView:addEvents()
	SP02_LinkGiftPanelView.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SP02_LinkGiftPanelView:removeEvents()
	SP02_LinkGiftPanelView.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
end

function SP02_LinkGiftPanelView:_btncloseOnClick()
	self:closeThis()
end

function SP02_LinkGiftPanelView:onOpenFinish()
	SP02_LinkGiftPanelView.super.onOpenFinish(self)

	local goodsMo = StoreModel.instance:getGoodsMO(self.curChangeGoodsId)

	if goodsMo then
		StoreController.instance:statOpenChargeGoods(goodsMo.belongStoreId, goodsMo.config)
	end
end

return SP02_LinkGiftPanelView
