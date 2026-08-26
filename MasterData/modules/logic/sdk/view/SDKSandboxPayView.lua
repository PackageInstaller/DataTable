-- chunkname: @modules/logic/sdk/view/SDKSandboxPayView.lua

module("modules.logic.sdk.view.SDKSandboxPayView", package.seeall)

local SDKSandboxPayView = class("SDKSandboxPayView", BaseView)

function SDKSandboxPayView:onInitView()
	self._txtgoodsName = gohelper.findChildText(self.viewGO, "goodsName/#txt_goodsName")
	self._txtcost = gohelper.findChildText(self.viewGO, "cost/#txt_cost")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")
	self._btnsdk = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_sdk")
	self._txtbalance = gohelper.findChildText(self.viewGO, "balance/#txt_balance")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SDKSandboxPayView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnsdk:AddClickListener(self._btnsdkOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SDKSandboxPayView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnsdk:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SDKSandboxPayView:_btnbuyOnClick()
	ChargeRpc.instance:sendSandboxChargeRequset(self.payInfo.gameOrderId)
	self:closeThis()
end

function SDKSandboxPayView:_btnsdkOnClick()
	local payInfo = StatModel.instance:getPayInfo()

	SDKMgr.instance:payGoods(payInfo)
	self:closeThis()
end

function SDKSandboxPayView:_btncloseOnClick()
	self:closeThis()
end

function SDKSandboxPayView:_editableInitView()
	return
end

function SDKSandboxPayView:onUpdateParam()
	return
end

function SDKSandboxPayView:onOpen()
	self.payInfo = self.viewParam.payInfo

	local config = StoreConfig.instance:getChargeGoodsConfig(self.payInfo.goodsId)

	self._txtcost.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(self.payInfo.amount / 100))
	self._txtgoodsName.text = self.payInfo.goodsName
	self._txtbalance.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(PayModel.instance:getSandboxBalance() / 100))
end

function SDKSandboxPayView:onClose()
	return
end

function SDKSandboxPayView:onDestroyView()
	return
end

return SDKSandboxPayView
