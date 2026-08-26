-- chunkname: @modules/logic/turnback/view/TurnbackPickEquipView.lua

module("modules.logic.turnback.view.TurnbackPickEquipView", package.seeall)

local TurnbackPickEquipView = class("TurnbackPickEquipView", BaseView)

function TurnbackPickEquipView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._scrollequiplist = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_equiplist")
	self._goitem = gohelper.findChild(self.viewGO, "root/#scroll_equiplist/viewport/content/#go_item")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/TipsBG/#txt_Tips")
	self._imageiconequip = gohelper.findChildImage(self.viewGO, "root/TipsBG/#txt_Tips/#image_iconequip")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackPickEquipView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self.addEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickListChanged, self.refreshSelectCount, self)
	self.addEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickComplete, self.closeThis, self)
end

function TurnbackPickEquipView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickListChanged, self.refreshSelectCount, self)
	self.removeEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickComplete, self.closeThis, self)
end

function TurnbackPickEquipView:_btnconfirmOnClick()
	TurnbackPickEquipController.instance:tryChoice(self.viewParam)
end

function TurnbackPickEquipView:_editableInitView()
	gohelper.setActive(self._goitem, false)
end

function TurnbackPickEquipView:onUpdateParam()
	return
end

function TurnbackPickEquipView:onOpen()
	self._swapCo = TurnbackPickEquipListModel.instance:getSwapItemCo()
	self._itemCo = ItemConfig.instance:getItemConfig(self._swapCo[1], self._swapCo[2])

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(self._swapCo[2])
	local currencyname = currencyCo.icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconequip, currencyname .. "_1")
	self:refreshSelectCount()
end

function TurnbackPickEquipView:refreshSelectCount()
	local selectCount = TurnbackPickEquipListModel.instance:getSelectCount()
	local maxCount = TurnbackPickEquipListModel.instance:getMaxSelectCount()

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectCount,
		maxCount
	})

	local allLimit = TurnbackPickEquipListModel.instance:checkAllLimit()

	gohelper.setActive(self._imageiconequip.gameObject, allLimit)
	gohelper.setActive(self._txtnum.gameObject, not allLimit)

	if allLimit then
		local param1 = self._swapCo[3]
		local param2 = self._itemCo.name
		local text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("p_turnback3_equipchooseview_txt6"), param1, param2)

		self._txtTips.text = allLimit and text or luaLang("p_turnback3_equipchooseview_txt7")

		ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, false)
	else
		self._txtTips.text = luaLang("p_turnback3_equipchooseview_txt7")

		ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
	end
end

function TurnbackPickEquipView:onClose()
	return
end

function TurnbackPickEquipView:onDestroyView()
	return
end

return TurnbackPickEquipView
