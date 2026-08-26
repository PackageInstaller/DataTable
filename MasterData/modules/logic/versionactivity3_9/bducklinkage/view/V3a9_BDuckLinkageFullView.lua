-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkageFullView.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkageFullView", package.seeall)

local V3a9_BDuckLinkageFullView = class("V3a9_BDuckLinkageFullView", V3a9_BDuckLinkageBaseView)

function V3a9_BDuckLinkageFullView:_editableInitView()
	V3a9_BDuckLinkageFullView.super._editableInitView(self)

	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/Btn/#btn_buy")
	self._txtCost = gohelper.findChildTextMesh(self.viewGO, "root/Btn/#btn_buy/#txt_cost")
end

function V3a9_BDuckLinkageFullView:refreshUI()
	V3a9_BDuckLinkageFullView.super.refreshUI(self)
	self:refreshPrice()
end

function V3a9_BDuckLinkageFullView:addEvents()
	V3a9_BDuckLinkageFullView.super.addEvents(self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V3a9_BDuckLinkageFullView:removeEvents()
	V3a9_BDuckLinkageFullView.super.removeEvents(self)
	self._btnbuy:RemoveClickListener()
end

function V3a9_BDuckLinkageFullView:_btnbuyOnClick()
	local storeGoodsMo = StoreModel.instance:getGoodsMO(self.chargeConfig.id)

	if not storeGoodsMo then
		return
	end

	local isSoldOut = storeGoodsMo:isSoldOut()

	if isSoldOut then
		return
	end

	PayController.instance:startPay(self.chargeConfig.id)
end

function V3a9_BDuckLinkageFullView:checkParam()
	V3a9_BDuckLinkageFullView.super.checkParam(self)

	if self.viewParam.parent then
		gohelper.setParent(self.viewGO, self.viewParam.parent)
	end
end

function V3a9_BDuckLinkageFullView:refreshPrice()
	V3a9_BDuckLinkageFullView.super.refreshPrice(self)

	local storeGoodsMo = StoreModel.instance:getGoodsMO(self.chargeConfig.id)
	local isSoldOut = storeGoodsMo and storeGoodsMo:isSoldOut()

	gohelper.setActive(self._goowened, isSoldOut)
	gohelper.setActive(self._btnbuy, not isSoldOut)

	if not isSoldOut then
		self._txtCost.text = PayModel.instance:getProductPrice(self.chargeConfig.id)
	end
end

return V3a9_BDuckLinkageFullView
