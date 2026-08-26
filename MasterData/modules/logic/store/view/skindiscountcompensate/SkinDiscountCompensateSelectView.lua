-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateSelectView.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateSelectView", package.seeall)

local SkinDiscountCompensateSelectView = class("SkinDiscountCompensateSelectView", BaseView)

function SkinDiscountCompensateSelectView:onInitView()
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "#scroll_List")
	self._goItem = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Close")
	self._btnSelected = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Selected")
	self._btnCantSelected = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CantSelected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinDiscountCompensateSelectView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnSelected:AddClickListener(self._btnSelectedOnClick, self)
	self._btnCantSelected:AddClickListener(self._btnCantSelectedOnClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.DecorateSkinSelectItemClick, self.onClickItem, self)
end

function SkinDiscountCompensateSelectView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSelected:RemoveClickListener()
	self._btnCantSelected:RemoveClickListener()
	self.removeEventCb(self, StoreController.instance, StoreEvent.DecorateSkinSelectItemClick, self.onClickItem, self)
end

function SkinDiscountCompensateSelectView:_btnCloseOnClick()
	self:closeThis()
end

function SkinDiscountCompensateSelectView:_btnSelectedOnClick()
	if self.skinId == nil then
		return
	end

	if self.type ~= SkinDiscountCompensateEnum.SelectDisplayType.Select then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.DecorateSkinSelectTips, MsgBoxEnum.BoxType.Yes_No, self.useItem, nil, nil, self)
end

function SkinDiscountCompensateSelectView:_btnCantSelectedOnClick()
	if self.type ~= SkinDiscountCompensateEnum.SelectDisplayType.Select then
		return
	end
end

function SkinDiscountCompensateSelectView:_editableInitView()
	self._textTitle = gohelper.findChildTextMesh(self.viewGO, "txt_Descr")
	self._textName = gohelper.findChildTextMesh(self.viewGO, "Title/txt_Title")

	NavigateMgr.instance:addEscape(ViewName.SkinDiscountCompensateSelectView, self._btnCloseOnClick, self)
end

function SkinDiscountCompensateSelectView:onUpdateParam()
	return
end

function SkinDiscountCompensateSelectView:onOpen()
	self.actId = self.viewParam.actId or ActivityEnum.Activity.V3a3_SkinDiscount
	self.type = self.viewParam.type or SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly
	self.itemId = self.viewParam.itemId

	SkinDiscountCompensateListModel.instance:initList(self.itemId)

	local mo = SkinDiscountCompensateListModel.instance:getByIndex(1)

	self:updateCompensate(mo.id)
	self:updateSelect()
end

function SkinDiscountCompensateSelectView:onClose()
	return
end

function SkinDiscountCompensateSelectView:onClickItem(skinId, selectIndex)
	if self.type ~= SkinDiscountCompensateEnum.SelectDisplayType.Select then
		return
	end

	if skinId == self.skinId then
		return
	end

	SkinDiscountCompensateListModel.instance:selectCell(selectIndex, true)

	self.skinId = skinId

	self:updateSelect()
	self:updateCompensate(skinId)
end

function SkinDiscountCompensateSelectView:updateSelect()
	local canSelect = self.type == SkinDiscountCompensateEnum.SelectDisplayType.Select
	local isSelect = self.skinId ~= nil

	gohelper.setActive(self._btnCantSelected, canSelect and not isSelect)
	gohelper.setActive(self._btnSelected, canSelect and isSelect)
end

function SkinDiscountCompensateSelectView:updateCompensate(skinId)
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local compensateParam = string.splitToNumber(skinConfig.compensate, "#")

	if compensateParam then
		if not compensateParam[3] then
			local num = 0
			local titleStr = luaLang("v3a3_skindiscount_compensate")

			self._textTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(titleStr, tostring(num))

			local config = ItemConfig.instance:getItemCo(self.itemId)

			self._textName.text = config.name
		end
	end
end

function SkinDiscountCompensateSelectView:checkActOpen()
	local actInfo = ActivityModel.instance:getActMO(self.actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return false
	end

	return true
end

function SkinDiscountCompensateSelectView:useItem()
	ItemRpc.instance:simpleSendUseItemRequest(self.itemId, 1, self.skinId, self.closeThis, self)
end

function SkinDiscountCompensateSelectView:onDestroyView()
	return
end

return SkinDiscountCompensateSelectView
