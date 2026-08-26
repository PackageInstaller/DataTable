-- chunkname: @modules/logic/sdk/view/SDKExitGameView.lua

module("modules.logic.sdk.view.SDKExitGameView", package.seeall)

local SDKExitGameView = class("SDKExitGameView", BaseView)

function SDKExitGameView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_desc")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._btnlogout = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_logout")

	local btnCancelTips = gohelper.findChild(self.viewGO, "#btn_cancel/#go_pcbtn")
	local btnLogoutTips = gohelper.findChild(self.viewGO, "#btn_logout/#go_pcbtn")

	PCInputController.instance:showkeyTips(btnCancelTips, nil, nil, "Esc")
	PCInputController.instance:showkeyTips(btnLogoutTips, nil, nil, "Return")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SDKExitGameView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnlogout:AddClickListener(self._btnlogoutOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btncancelOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._btnlogoutOnClick, self)
end

function SDKExitGameView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnlogout:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btncancelOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._btnlogoutOnClick, self)
end

function SDKExitGameView:_btncancelOnClick()
	self:closeThis()
end

function SDKExitGameView:_btnlogoutOnClick()
	self:closeThis()

	if self.viewParam.exitCallback then
		self.viewParam.exitCallback()
	else
		LoginController.instance:logout()
	end
end

function SDKExitGameView:_editableInitView()
	return
end

function SDKExitGameView:onUpdateParam()
	return
end

function SDKExitGameView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.SDKExitGameView, self.closeThis, self)
end

function SDKExitGameView:onClose()
	return
end

function SDKExitGameView:onClickModalMask()
	self:closeThis()
end

function SDKExitGameView:onDestroyView()
	return
end

return SDKExitGameView
