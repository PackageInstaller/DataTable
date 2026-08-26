-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageFullView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageFullView", package.seeall)

local SceneUIPackageFullView = class("SceneUIPackageFullView", SceneUIPackageBaseView)

function SceneUIPackageFullView:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_buy")
	self._gosingle = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_single")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/#txt_original_price")
	self._godoubleprice = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_doubleprice")
	self._txtoriginalprice1 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	self._txtoriginalprice2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	self._gofree = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_free")
	self._godiscount = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount2/#txt_discount")
	self._gotips = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_tips/#txt_tips")
	self._gocostclick = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_costclick")
	self._goowned = gohelper.findChild(self.viewGO, "root/#go_owned")
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneUIPackageFullView:addEvents()
	SceneUIPackageFullView.super.addEvents(self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshView, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function SceneUIPackageFullView:removeEvents()
	SceneUIPackageFullView.super.removeEvents(self)
	self._btnbuy:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshView, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function SceneUIPackageFullView:_btnbuyOnClick()
	if not self._goodsCo then
		return
	end

	ViewMgr.instance:openView(ViewName.SceneUIPackageGoodsTipView, {
		canJump = true,
		goodsId = self._goodsCo.id
	})
end

function SceneUIPackageFullView:_editableInitView()
	SceneUIPackageFullView.super._editableInitView(self)
	gohelper.setActive(self._gosingle, false)

	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/txt_materialNum")
	self._imagematerialicon = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_single/icon/simage_material")
end

function SceneUIPackageFullView:onOpen()
	SceneUIPackageFullView.super.onOpen(self)

	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	if self._goodsCo then
		self._txtoriginalprice.text = self._goodsCo.originalCost
		self._txtmaterialNum.text = string.format("%s%s", StoreModel.instance:getCostStr(self._goodsCo.price))

		gohelper.setActive(self._txtoriginalprice.gameObject, self._goodsCo.originalCost > 0)
		gohelper.setActive(self._imagematerialicon.gameObject, false)
	end
end

function SceneUIPackageFullView:refreshReceive()
	local hasScene = SceneUIPackageModel.instance:hasScene(self._actId)
	local hasUI = SceneUIPackageModel.instance:hasUI(self._actId)
	local canBuy = SceneUIPackageModel.instance:canBuy(self._actId)

	gohelper.setActive(self._goframereceive, hasUI)
	gohelper.setActive(self._gobackgroundreceive, hasScene)
	gohelper.setActive(self._gorewardreceive, not canBuy)
	gohelper.setActive(self._goowned, not canBuy)
	gohelper.setActive(self._btnbuy.gameObject, canBuy)
	gohelper.setActive(self._gosingle.gameObject, canBuy)
end

function SceneUIPackageFullView:refreshView()
	SceneUIPackageFullView.super.refreshView(self)
end

function SceneUIPackageFullView:onDestroyView()
	SceneUIPackageFullView.super.onDestroyView(self)
end

return SceneUIPackageFullView
