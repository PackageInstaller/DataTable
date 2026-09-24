-- chunkname: @modules/logic/settings/view/SettingsCurrencyView.lua

module("modules.logic.settings.view.SettingsCurrencyView", package.seeall)

local SettingsCurrencyView = class("SettingsCurrencyView", BaseView)

function SettingsCurrencyView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_sure")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsCurrencyView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function SettingsCurrencyView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
end

function SettingsCurrencyView:_btncloseOnClick()
	self:closeThis()
end

function SettingsCurrencyView:_btnsureOnClick()
	self:closeThis()
end

function SettingsCurrencyView:_editableInitView()
	self._paidItem = self:_create_SettingsCurrencyViewItem(gohelper.findChild(self.viewGO, "layout/go_item1"))
	self._nonPaidItem = self:_create_SettingsCurrencyViewItem(gohelper.findChild(self.viewGO, "layout/go_item2"))
	self._totalItem = self:_create_SettingsCurrencyViewItem(gohelper.findChild(self.viewGO, "layout/go_item3"))
end

function SettingsCurrencyView:onUpdateParam()
	self:_refreshItems()
end

function SettingsCurrencyView:_getPFT()
	local p = PayModel.instance:getPayDiamond()
	local np = PayModel.instance:getNonPaidDiamond()
	local t = PayModel.instance:getTotalDiamond()

	return p, np, t
end

function SettingsCurrencyView:_refreshItems()
	local p, np, t = self:_getPFT()

	self._paidItem:setTextNum(p)
	self._nonPaidItem:setTextNum(np)
	self._totalItem:setTextNum(t)
end

function SettingsCurrencyView:onOpen()
	self:onUpdateParam()
	self.addEventCb(self, PayController.instance, PayEvent.onReceiveGetPayDiamondInfoReply, self._onReceiveGetPayDiamondInfoReply, self)
end

function SettingsCurrencyView:onClose()
	self.removeEventCb(self, PayController.instance, PayEvent.onReceiveGetPayDiamondInfoReply, self._onReceiveGetPayDiamondInfoReply, self)
end

function SettingsCurrencyView:_onReceiveGetPayDiamondInfoReply()
	self:_refreshItems()
end

function SettingsCurrencyView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_paidItem")
	GameUtil.onDestroyViewMember(self, "_nonPaidItem")
	GameUtil.onDestroyViewMember(self, "_totalItem")
end

function SettingsCurrencyView:_create_SettingsCurrencyViewItem(srcGo, index)
	local item = SettingsCurrencyViewItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

return SettingsCurrencyView
