-- chunkname: @modules/logic/settings/view/KeyMapAlertView.lua

module("modules.logic.settings.view.KeyMapAlertView", package.seeall)

local KeyMapAlertView = class("KeyMapAlertView", BaseView)

function KeyMapAlertView:onInitView()
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end

	self._toastConfig = lua_toast.configDict

	self.viewGO:SetActive(false)
end

function KeyMapAlertView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function KeyMapAlertView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function KeyMapAlertView:_btncancelOnClick()
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function KeyMapAlertView:_btnconfirmOnClick()
	self:save()
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function KeyMapAlertView:onUpdateParam()
	return
end

function KeyMapAlertView:onOpen()
	if self.viewParam then
		self._mo = self.viewParam.value
		self._modifyKey = self._mo[PCInputModel.Configfield.key]

		self:setInputKey()
	end
end

function KeyMapAlertView:onBtnReset()
	SettingsKeyListModel.instance:Reset(self._mo[PCInputModel.Configfield.hud])
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function KeyMapAlertView:onDestroyView()
	TaskDispatcher.cancelTask(self.getKey, self)
end

function KeyMapAlertView:listenInputKey()
	TaskDispatcher.runRepeat(self.getKey, self, 0)
	PCInputController.instance:PauseListen()
end

function KeyMapAlertView:getKey()
	local activtiyId = self._mo[PCInputModel.Configfield.hud]

	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) then
		TaskDispatcher.cancelTask(self.getKey, self)
		TaskDispatcher.runDelay(PCInputController.resumeListen, PCInputController.instance, 0.5)

		local key = PCInputController.instance:getCurrentPresskey()

		if PCInputModel.instance:checkKeyCanModify(activtiyId, key) then
			local repeatkey = self:checkedKey(key)

			if repeatkey then
				self:setKeyOccupied(repeatkey, key)
			else
				self:setKey(key)
			end
		else
			self:setCantModify(key)
		end
	end
end

function KeyMapAlertView:checkedKey(key)
	return SettingsKeyListModel.instance:checkDunplicateKey(self._mo[PCInputModel.Configfield.hud], key)
end

function KeyMapAlertView:setInputKey()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyChange, MsgBoxEnum.BoxType.NO, self._btnconfirmOnClick, self._btncancelOnClick, nil, self, self, nil, self._mo.description)
	self:listenInputKey()
end

function KeyMapAlertView:setKey(key)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyConfirm, MsgBoxEnum.BoxType.Yes_No, self._btnconfirmOnClick, self._btncancelOnClick, nil, self, self, nil, self._mo.description, PCInputController.instance:KeyNameToDescName(key))

	self._modifyKey = key
end

function KeyMapAlertView:setCantModify(key)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

	if not key then
		return
	end

	ToastController.instance:showToast(ToastEnum.PCKeyCantModify, PCInputController.instance:KeyNameToDescName(key))
end

function KeyMapAlertView:setKeyOccupied(repeatKey, key)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)

	if repeatKey[PCInputModel.Configfield.hud] == self._mo[PCInputModel.Configfield.hud] and repeatKey[PCInputModel.Configfield.id] == self._mo[PCInputModel.Configfield.id] then
		ToastController.instance:showToast(ToastEnum.pcKeyTipsOccupied)
		ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeySwap, MsgBoxEnum.BoxType.Yes_No, function()
		self:swapKey(repeatKey, key)
	end, self._btncancelOnClick, nil, nil, nil, nil, PCInputController.instance:KeyNameToDescName(key), repeatKey.description)
end

function KeyMapAlertView:swapKey(repeatKey, key)
	local oldkey = self._mo[PCInputModel.Configfield.key]

	SettingsKeyListModel.instance:modifyKey(self._mo[PCInputModel.Configfield.hud], self._mo[PCInputModel.Configfield.id], key)
	SettingsKeyListModel.instance:modifyKey(repeatKey[PCInputModel.Configfield.hud], repeatKey[PCInputModel.Configfield.id], oldkey)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function KeyMapAlertView:save()
	SettingsKeyListModel.instance:modifyKey(self._mo[PCInputModel.Configfield.hud], self._mo[PCInputModel.Configfield.id], self._modifyKey)
end

return KeyMapAlertView
