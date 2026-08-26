-- chunkname: @modules/logic/store/view/decorate/DecorateSkinSelectView.lua

module("modules.logic.store.view.decorate.DecorateSkinSelectView", package.seeall)

local DecorateSkinSelectView = class("DecorateSkinSelectView", BaseView)

function DecorateSkinSelectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.goUnSelect = gohelper.findChild(self.viewGO, "bottom/unselect")
	self.goSelected = gohelper.findChild(self.viewGO, "bottom/selected")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/selected/#btn_confirmselect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateSkinSelectView:addEvents()
	self.addClickCb(self, self._btnclose, self._btncloseOnClick, self)
	self.addClickCb(self, self.btnConfirm, self.onClickConfirm, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.DecorateSkinSelectItemClick, self.onClickItem, self)
end

function DecorateSkinSelectView:removeEvents()
	self:removeClickCb(self._btnclose)
	self:removeClickCb(self.btnConfirm)
	self.removeEventCb(self, StoreController.instance, StoreEvent.DecorateSkinSelectItemClick, self.onClickItem, self)
end

function DecorateSkinSelectView:_btncloseOnClick()
	self:closeThis()
end

function DecorateSkinSelectView:onClickConfirm()
	if self.skinId == nil then
		return
	end

	local isOwned = HeroModel.instance:checkHasSkin(self.skinId)

	if isOwned then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.DecorateSkinSelectTips, MsgBoxEnum.BoxType.Yes_No, self.useItem, nil, nil, self)
end

function DecorateSkinSelectView:useItem()
	ItemRpc.instance:simpleSendUseItemRequest(self.itemId, 1, self.skinId)
	self:closeThis()
end

function DecorateSkinSelectView:onClickItem(skinId)
	self.skinId = skinId

	self:updateSelect()
end

function DecorateSkinSelectView:_editableInitView()
	return
end

function DecorateSkinSelectView:onUpdateParam()
	return
end

function DecorateSkinSelectView:onOpen()
	self.itemId = self.viewParam and self.viewParam.itemId

	self:refreshView()
end

function DecorateSkinSelectView:refreshView()
	DecorateSkinSelectListModel.instance:refreshList(self.itemId)
	self:updateSelect()
end

function DecorateSkinSelectView:updateSelect()
	local isSelect = self.skinId ~= nil

	gohelper.setActive(self.goUnSelect, not isSelect)
	gohelper.setActive(self.goSelected, isSelect)

	if isSelect then
		local isOwned = HeroModel.instance:checkHasSkin(self.skinId)

		ZProj.UGUIHelper.SetGrayscale(self.btnConfirm.gameObject, isOwned)
	end
end

function DecorateSkinSelectView:onClose()
	return
end

function DecorateSkinSelectView:onDestroyView()
	return
end

return DecorateSkinSelectView
