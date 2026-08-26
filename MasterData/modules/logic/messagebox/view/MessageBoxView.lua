-- chunkname: @modules/logic/messagebox/view/MessageBoxView.lua

module("modules.logic.messagebox.view.MessageBoxView", package.seeall)

local MessageBoxView = class("MessageBoxView", BaseView)

function MessageBoxView:onInitView()
	self._simagehuawen1 = gohelper.findChildSingleImage(self.viewGO, "tipbg/#simage_huawen1")
	self._simagehuawen2 = gohelper.findChildSingleImage(self.viewGO, "tipbg/#simage_huawen2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txttitleCn = gohelper.findChildText(self.viewGO, "topTip/txtCn")

	if MessageBoxController.instance.enableClickAudio then
		self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
		self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	else
		self._btnyes = gohelper.findChildButton(self.viewGO, "#btn_yes")
		self._btnno = gohelper.findChildButton(self.viewGO, "#btn_no")
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MessageBoxView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btnnoOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._btnyesOnClick, self)
	self.addEventCb(self, MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, self._onCloseSpecificMessageBoxView, self)
end

function MessageBoxView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btnnoOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._btnyesOnClick, self)
	self.removeEventCb(self, MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, self._onCloseSpecificMessageBoxView, self)
end

local closeType = MsgBoxEnum.CloseType
local boxType = MsgBoxEnum.BoxType

function MessageBoxView:_btnyesOnClick()
	self:_closeInvokeCallback(closeType.Yes)
end

function MessageBoxView:_btnnoOnClick()
	self:_closeInvokeCallback(closeType.No)
end

function MessageBoxView:_closeInvokeCallback(result)
	if not MessageBoxController.instance:_showNextMsgBox() then
		self:closeThis()
	end

	if result == closeType.Yes then
		if self.viewParam.yesCallback then
			self.viewParam.yesCallback(self.viewParam.yesCallbackObj)
		end
	elseif self.viewParam.noCallback then
		self.viewParam.noCallback(self.viewParam.noCallbackObj)
	end
end

function MessageBoxView:_onCloseSpecificMessageBoxView(messageBoxId)
	if not messageBoxId or not self.viewParam or not self.viewParam.messageBoxId then
		return
	end

	if self.viewParam.messageBoxId == messageBoxId then
		self:_btnnoOnClick()
	end
end

function MessageBoxView:_editableInitView()
	self._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	self._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	self._goNo = self._btnno.gameObject
	self._goYes = self._btnyes.gameObject
	self._keyTipsNo = gohelper.findChild(self._goNo, "#go_pcbtn")
	self._keyTipsYes = gohelper.findChild(self._goYes, "#go_pcbtn")

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	self._txtYes = gohelper.findChildText(self._goYes, "yes")
	self._txtNo = gohelper.findChildText(self._goNo, "no")
	self._txtYesen = gohelper.findChildText(self._goYes, "yesen")
	self._txtNoen = gohelper.findChildText(self._goNo, "noen")

	PCInputController.instance:showkeyTips(self._keyTipsNo, nil, nil, "Esc")
	PCInputController.instance:showkeyTips(self._keyTipsYes, nil, nil, "Return")
end

function MessageBoxView:onUpdateParam()
	self:onOpen()
end

function MessageBoxView:onDestroyView()
	self._simagehuawen1:UnLoadImage()
	self._simagehuawen2:UnLoadImage()
end

function MessageBoxView:onOpen()
	if not string.nilorempty(self.viewParam.msg) and self.viewParam.extra and #self.viewParam.extra > 0 then
		local tip = self.viewParam.msg

		tip = GameUtil.getSubPlaceholderLuaLang(tip, self.viewParam.extra)
		self._txtdesc.text = tip
	elseif not self.viewParam.msg then
		self._txtdesc.text = ""
	end

	if not string.nilorempty(self.viewParam.title) then
		self._txttitleCn.text = self.viewParam.title
	end

	self:_updateCurrency()

	if self.viewParam.openCallback then
		if self.viewParam.openCallbackObj then
			self.viewParam.openCallback(self.viewParam.openCallbackObj, self)
		else
			self.viewParam.openCallback(self)
		end
	end

	if not self.viewParam.yesStr then
		local yesStr = luaLang("confirm")

		if not self.viewParam.noStr then
			local noStr = luaLang("cancel")

			if not self.viewParam.yesStrEn then
				local yesStrEn = "CONFIRM"

				if not self.viewParam.noStrEn then
					self._txtYes.text = yesStr
					self._txtNo.text = noStr
					self._txtYesen.text = yesStrEn
					self._txtNoen.text = "CANCEL"

					if self.viewParam.msgBoxType == boxType.Yes then
						gohelper.setActive(self._goNo, false)
						gohelper.setActive(self._goYes, true)
						recthelper.setAnchorX(self._goYes.transform, 0)
					elseif self.viewParam.msgBoxType == boxType.NO then
						gohelper.setActive(self._goYes, false)
						gohelper.setActive(self._goNo, true)
						recthelper.setAnchorX(self._goNo.transform, 0)
					elseif self.viewParam.msgBoxType == boxType.Yes_No then
						gohelper.setActive(self._goNo, true)
						gohelper.setActive(self._goYes, true)
						recthelper.setAnchorX(self._goYes.transform, 248)
						recthelper.setAnchorX(self._goNo.transform, -248)
					end

					NavigateMgr.instance:addEscape(ViewName.MessageBoxView, self._onEscapeBtnClick, self)
				end
			end
		end
	end
end

function MessageBoxView:_updateCurrency()
	if self.viewParam.currencyParam and #self.viewParam.currencyParam > 0 then
		self.viewContainer:setCurrencyByParams(self.viewParam.currencyParam)
	end
end

function MessageBoxView:_onEscapeBtnClick()
	if self._goNo.gameObject.activeInHierarchy then
		self:_closeInvokeCallback(closeType.No)
	end
end

function MessageBoxView:onClose()
	return
end

return MessageBoxView
