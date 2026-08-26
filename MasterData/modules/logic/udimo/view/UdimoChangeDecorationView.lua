-- chunkname: @modules/logic/udimo/view/UdimoChangeDecorationView.lua

module("modules.logic.udimo.view.UdimoChangeDecorationView", package.seeall)

local UdimoChangeDecorationView = class("UdimoChangeDecorationView", BaseView)

function UdimoChangeDecorationView:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._goContent = gohelper.findChild(self.viewGO, "Right/#scroll_list/Viewport/Content")
	self._goItem = gohelper.findChild(self.viewGO, "Right/#scroll_list/Viewport/Content/#go_Item")

	local goClick = gohelper.findChild(self.viewGO, "#btn_click")

	self._click = SLFramework.UGUI.UIClickListener.Get(goClick)
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function UdimoChangeDecorationView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._click:AddClickListener(self._btnclickOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self.onEscapeBtnClick, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnClickDecorationEntity, self._onClickDecorationEntity, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnSelectDecorationItem, self._onSelectDecorationItem, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.RefreshDecorationSelectPos, self._onRefreshSelectPos, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnUdimoCameraTweening, self._onCameraTweening, self)
end

function UdimoChangeDecorationView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._click:RemoveClickListener()
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnClickDecorationEntity, self._onClickDecorationEntity, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnSelectDecorationItem, self._onSelectDecorationItem, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.RefreshDecorationSelectPos, self._onRefreshSelectPos, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnUdimoCameraTweening, self._onCameraTweening, self)
end

function UdimoChangeDecorationView:_btnGetOnClick(index)
	return
end

function UdimoChangeDecorationView:_btnSelectOnClick(index)
	local decorationId = self:_getDecorationIdByIndex(index)

	UdimoController.instance:selectDecoration(decorationId)
end

function UdimoChangeDecorationView:_getDecorationIdByIndex(index)
	if self._decorationItemList then
		return self._decorationItemList and self._decorationItemList.id
	end
end

function UdimoChangeDecorationView:_btnCloseOnClick()
	self._dressSelectedDecoration(self, self._closeListAfterDress, self)
end

function UdimoChangeDecorationView:_dressSelectedDecoration(cb, cbObj)
	local selectedDecorationId = UdimoItemModel.instance:getSelectedDecorationId()
	local curUseDecoration = UdimoItemModel.instance:getUseDecoration(self._posIndex)

	UdimoController.instance:useDecoration(selectedDecorationId, curUseDecoration, cb, cbObj)
end

function UdimoChangeDecorationView:_closeListAfterDress(cmd, resultCode, msg)
	UdimoController.instance:selectDecoration()
	self:_onClickDecorationEntity()
end

function UdimoChangeDecorationView:_btnclickOnClick(param, pos, delta)
	local decorationEntity = UdimoHelper.getRaycastDecorationEntity(pos)

	if decorationEntity then
		decorationEntity:onClick()
	elseif self._posIndex then
		self:_btnCloseOnClick()
	else
		self:onEscapeBtnClick()
	end
end

function UdimoChangeDecorationView:onEscapeBtnClick()
	self._dressSelectedDecoration(self, self.closeThis, self)
end

function UdimoChangeDecorationView:_onClickDecorationEntity(decorationId, worldPos)
	self._posIndex = decorationId and UdimoConfig.instance:getDecorationPos(decorationId) or nil

	self:setDecorationItemList()
	self:_onRefreshSelectPos(worldPos)
	self:refresh(true)
end

function UdimoChangeDecorationView:setDecorationItemList()
	self:clearDecorationItemList()

	if not self._posIndex then
		return
	end

	local decorationList = UdimoConfig.instance:getAllDecorationList(self._posIndex)

	gohelper.CreateObjList(self, self._onCreateDecorationItem, decorationList, self._goContent, self._goItem)
end

function UdimoChangeDecorationView:_onCreateDecorationItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.id = data

	local txtNum1 = gohelper.findChildText(item.go, "#go_Locked/#txt_Num")
	local txtNum2 = gohelper.findChildText(item.go, "#go_UnDress/#txt_Num")
	local txtNum3 = gohelper.findChildText(item.go, "#go_DressUp/#txt_Num")

	txtNum1.text = index
	txtNum2.text = index
	txtNum3.text = index

	local name = UdimoConfig.instance:getDecorationName(item.id)
	local txtName1 = gohelper.findChildText(item.go, "#go_Locked/#txt_Name")
	local txtName2 = gohelper.findChildText(item.go, "#go_UnDress/#txt_Name")
	local txtName3 = gohelper.findChildText(item.go, "#go_DressUp/#txt_Name")

	txtName1.text = name
	txtName2.text = name
	txtName3.text = name
	item.btnSelect = gohelper.findChildClickWithDefaultAudio(item.go, "#btn_select")
	item.goLocked = gohelper.findChild(item.go, "#go_Locked")
	item.goUnDress = gohelper.findChild(item.go, "#go_UnDress")
	item.goDressUp = gohelper.findChild(item.go, "#go_DressUp")
	item.simageIcon1 = gohelper.findChildSingleImage(item.go, "#go_Locked/#simage_Icon")
	item.simageIcon2 = gohelper.findChildSingleImage(item.go, "#go_UnDress/#simage_Icon")
	item.simageIcon3 = gohelper.findChildSingleImage(item.go, "#go_DressUp/#simage_Icon")

	local img = UdimoConfig.instance:getDecorationImg(item.id)

	if not string.nilorempty(img) then
		local lockImgPath = ResUrl.getUdimoSingleBg(string.format("decorate/%s_0", img))
		local unlockedImgPath = ResUrl.getUdimoSingleBg(string.format("decorate/%s_1", img))

		item.simageIcon1:LoadImage(lockImgPath)
		item.simageIcon2:LoadImage(unlockedImgPath)
		item.simageIcon3:LoadImage(unlockedImgPath)
	end

	item.btnGet = gohelper.findChildButtonWithAudio(item.go, "#go_Locked/#btn_Get")
	item.goPath = gohelper.findChild(item.go, "#go_Locked/#go_Path")
	item.txtPath = gohelper.findChildText(item.go, "#go_Locked/#go_Path/#txt_Path")
	item.goSelected = gohelper.findChild(item.go, "#go_Selected")

	item.btnSelect:AddClickListener(self._btnSelectOnClick, self, index)
	item.btnGet:AddClickListener(self._btnGetOnClick, self, index)

	self._decorationItemList[index] = item
end

function UdimoChangeDecorationView:_onSelectDecorationItem()
	self:refreshDecorationItem()
end

function UdimoChangeDecorationView:_onChangeDecoration()
	self:refreshDecorationItem()
end

function UdimoChangeDecorationView:_onRefreshSelectPos(worldPos)
	if worldPos then
		if self._selectedPosV3 then
			self._selectedPosV3:Set(worldPos.x, worldPos.y, worldPos.z)
		else
			self._selectedPosV3 = Vector3.New(worldPos.x, worldPos.y, worldPos.z)
		end
	end

	self:refreshSelectedGOPos()
end

function UdimoChangeDecorationView:_onCameraTweening()
	self:refreshSelectedGOPos()
end

function UdimoChangeDecorationView:_editableInitView()
	self.viewTrans = self.viewGO.transform
	self._transSelected = self._goSelected.transform

	gohelper.setActive(self._goItem, false)

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function UdimoChangeDecorationView:onUpdateParam()
	return
end

function UdimoChangeDecorationView:onOpen()
	self:refresh()
end

function UdimoChangeDecorationView:refresh(isPlay)
	self:refreshDecorationItem()
	self:refreshDecorationListShow(isPlay)
	self:refreshSelectedGOActive()
end

function UdimoChangeDecorationView:refreshDecorationItem()
	if not self._decorationItemList then
		return
	end

	local selectedDecorationId = UdimoItemModel.instance:getSelectedDecorationId()

	for _, decorationItem in ipairs(self._decorationItemList) do
		local decorationId = decorationItem.id
		local isSelected = selectedDecorationId == decorationId
		local isUnlock = UdimoItemModel.instance:isUnlockDecoration(decorationId)

		if isUnlock then
			gohelper.setActive(decorationItem.goLocked, false)
			gohelper.setActive(decorationItem.goDressUp, isSelected)
			gohelper.setActive(decorationItem.goUnDress, not isSelected)
		else
			gohelper.setActive(decorationItem.goLocked, true)
			gohelper.setActive(decorationItem.goDressUp, false)
			gohelper.setActive(decorationItem.goUnDress, false)
		end

		gohelper.setActive(decorationItem.goSelected, isSelected)
	end
end

function UdimoChangeDecorationView:refreshDecorationListShow(isPlay)
	if isPlay then
		if self._posIndex then
			gohelper.setActive(self._goRight, true)
			self.animatorPlayer:Play(UIAnimationName.Open)
		else
			self.animatorPlayer:Play("put", self._hideDecorationList, self)
		end
	else
		gohelper.setActive(self._goRight, self._posIndex)
	end
end

function UdimoChangeDecorationView:_hideDecorationList()
	gohelper.setActive(self._goRight, false)
end

function UdimoChangeDecorationView:refreshSelectedGOActive()
	if self._posIndex then
		AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_zhuanban)
	end

	gohelper.setActive(self._goSelected, self._posIndex)
end

function UdimoChangeDecorationView:refreshSelectedGOPos()
	if self._selectedPosV3 then
		local rectPos = recthelper.worldPosToAnchorPos(self._selectedPosV3, self.viewTrans)

		recthelper.setAnchor(self._transSelected, rectPos.x, rectPos.y)
	end
end

function UdimoChangeDecorationView:clearDecorationItemList()
	if self._decorationItemList then
		for _, decorationItem in ipairs(self._decorationItemList) do
			decorationItem.btnSelect:RemoveClickListener()
			decorationItem.btnGet:RemoveClickListener()
			decorationItem.simageIcon1:UnLoadImage()
			decorationItem.simageIcon2:UnLoadImage()
			decorationItem.simageIcon3:UnLoadImage()
		end
	end

	self._decorationItemList = {}
end

function UdimoChangeDecorationView:onClose()
	self._posIndex = nil

	self:clearDecorationItemList()
end

function UdimoChangeDecorationView:onDestroyView()
	UdimoController.instance:selectDecoration()

	self._selectedPosV3 = nil
end

return UdimoChangeDecorationView
