-- chunkname: @modules/logic/box/equiplvup/view/EquipLvUpChooseView.lua

module("modules.logic.box.equiplvup.view.EquipLvUpChooseView", package.seeall)

local EquipLvUpChooseView = class("EquipLvUpChooseView", BaseView)

function EquipLvUpChooseView:onInitView()
	self._txtTips = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips")
	self._imageicon = gohelper.findChildImage(self.viewGO, "pickchoice/TipsBG/tip/#image_icon")
	self._txtTips1 = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips1")
	self._txtnum = gohelper.findChildText(self.viewGO, "pickchoice/Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "pickchoice/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "pickchoice/#btn_cancel")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._goclick = gohelper.findChild(self.viewGO, "#go_item/select/#go_click")
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "#scroll")
	self._gohas = gohelper.findChild(self.viewGO, "#scroll/Viewport/Content/#go_has")
	self._gohasroot = gohelper.findChild(self.viewGO, "#scroll/Viewport/Content/#go_has/#go_hasroot")
	self._golock = gohelper.findChild(self.viewGO, "#scroll/Viewport/Content/#go_lock")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll/Viewport/Content/#go_lock/title/#txt_locked")
	self._golockroot = gohelper.findChild(self.viewGO, "#scroll/Viewport/Content/#go_lock/#go_lockroot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipLvUpChooseView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self.addEventCb(self, EquipLvUpController.instance, EquipLvUpEvent.OnSelectEquip, self._refreshSelectEquip, self)
end

function EquipLvUpChooseView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, EquipLvUpController.instance, EquipLvUpEvent.OnSelectEquip, self._refreshSelectEquip, self)
end

function EquipLvUpChooseView:_btnconfirmOnClick()
	if not EquipLvUpModel.instance:getSelectEquip() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EquipLvUpConfirmUseTip, MsgBoxEnum.BoxType.Yes_No, self._confirmUse, nil, nil, self)
end

function EquipLvUpChooseView:_confirmUse()
	local equipUid = EquipLvUpModel.instance:getSelectEquip()

	EquipLvUpController.instance:useItem(self._itemId, equipUid, self._useItemFunc, self)
end

function EquipLvUpChooseView:_btncancelOnClick()
	self:closeThis()
end

function EquipLvUpChooseView:_editableInitView()
	return
end

function EquipLvUpChooseView:onUpdateParam()
	return
end

function EquipLvUpChooseView:onOpen()
	self._itemId = self.viewParam.itemId

	EquipLvUpChooseListModel.instance:setEquipList(self._itemId)

	local canLvUpList = EquipLvUpChooseListModel.instance:getCanLvUpList()

	if canLvUpList then
		gohelper.CreateObjList(self, self.onCreateItem, canLvUpList, self._gohasroot, self._goitem, EquipLvUpChooseItem)
	end

	gohelper.setActive(self._gohas, canLvUpList and #canLvUpList > 0)

	local maxLvEquipList = EquipLvUpChooseListModel.instance:getMaxLvEquipList()

	if maxLvEquipList then
		gohelper.CreateObjList(self, self.onCreateItem, maxLvEquipList, self._golockroot, self._goitem, EquipLvUpChooseItem)
	end

	gohelper.setActive(self._golock, maxLvEquipList and #maxLvEquipList > 0)
	self:_refreshSelectEquip()
	gohelper.setActive(self._goitem, false)
end

function EquipLvUpChooseView:_refreshSelectEquip()
	local isGray = EquipLvUpModel.instance:getSelectEquip() == nil

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, isGray)
end

function EquipLvUpChooseView:onCreateItem(item, data, index)
	item:onUpdateMO(data, index)
end

function EquipLvUpChooseView:_useItemFunc()
	local equipUid = EquipLvUpModel.instance:getSelectEquip()
	local mo = EquipModel.instance:getEquip(equipUid)

	EquipCategoryListModel.instance.curCategoryIndex = 2

	ViewMgr.instance:openView(ViewName.EquipView, {
		useLvUpItem = true,
		equipMO = mo,
		defaultTabIds = {
			[2] = 2
		}
	})
	GameFacade.showToast(ToastEnum.EquipStrengthen)
	self:closeThis()
end

function EquipLvUpChooseView:onClose()
	return
end

function EquipLvUpChooseView:onDestroyView()
	return
end

return EquipLvUpChooseView
