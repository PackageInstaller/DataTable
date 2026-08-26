-- chunkname: @modules/logic/messagebox/view/MessageOptionBoxView.lua

module("modules.logic.messagebox.view.MessageOptionBoxView", package.seeall)

local MessageOptionBoxView = class("MessageOptionBoxView", BaseView)

function MessageOptionBoxView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "tipContent/#txt_desc")
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "tipContent/#toggle_option")
	self._txtoption = gohelper.findChildText(self.viewGO, "tipContent/#toggle_option/#txt_option")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "tipContent/btnContent/#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "tipContent/btnContent/#btn_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MessageOptionBoxView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._toggleoption:AddOnValueChanged(self._toggleOptionOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

function MessageOptionBoxView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._toggleoption:RemoveOnValueChanged()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

local closeType = MsgBoxEnum.CloseType
local boxType = MsgBoxEnum.BoxType

function MessageOptionBoxView:_btnyesOnClick()
	self:_closeInvokeCallback(closeType.Yes)
end

function MessageOptionBoxView:_btnnoOnClick()
	self:_closeInvokeCallback(closeType.No)
end

function MessageOptionBoxView:_toggleOptionOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function MessageOptionBoxView:_closeInvokeCallback(result)
	if result == closeType.Yes then
		if self._toggleoption.isOn then
			self:saveOptionData()
		end

		if self.viewParam.yesCallback then
			self.viewParam.yesCallback(self.viewParam.yesCallbackObj)
		end
	elseif self.viewParam.noCallback then
		self.viewParam.noCallback(self.viewParam.noCallbackObj)
	end

	self:closeThis()
end

function MessageOptionBoxView:_onOpenViewFinish(viewName)
	if viewName == ViewName.MessageBoxView or viewName == ViewName.TopMessageBoxView then
		self:closeThis()
	end
end

function MessageOptionBoxView:_editableInitView()
	self._goNo = self._btnno.gameObject
	self._goYes = self._btnyes.gameObject

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	self._txtYes = gohelper.findChildText(self._goYes, "yes")
	self._txtNo = gohelper.findChildText(self._goNo, "no")
	self._txtYesen = gohelper.findChildText(self._goYes, "yesen")
	self._txtNoen = gohelper.findChildText(self._goNo, "noen")
	self._toggleoption.isOn = false
end

function MessageOptionBoxView:onUpdateParam()
	self:onOpen()
end

function MessageOptionBoxView:onOpen()
	if self.viewParam.openCallback then
		if self.viewParam.openCallbackObj then
			self.viewParam.openCallback(self.viewParam.openCallbackObj, self)
		else
			self.viewParam.openCallback(self)
		end
	end

	self:refreshDesc()
	self:refreshBtn()
	self:refreshOptionUI()
end

function MessageOptionBoxView:refreshDesc()
	if not string.nilorempty(self.viewParam.msg) and self.viewParam.extra and #self.viewParam.extra > 0 then
		local tip = self.viewParam.msg

		tip = GameUtil.getSubPlaceholderLuaLang(tip, self.viewParam.extra)
		self._txtdesc.text = tip
	elseif not self.viewParam.msg then
		self._txtdesc.text = ""
	end
end

function MessageOptionBoxView:refreshBtn()
	if not self.viewParam.yesStr then
		local yesStr = luaLang("confirm")

		if not self.viewParam.noStr then
			local noStr = luaLang("cancel")

			if not self.viewParam.yesStrEn then
				local yesStrEn = "CONFIRM"

				if not self.viewParam.noStrEn then
					self._txtYes.text = self.viewParam.yesStr
					self._txtNo.text = noStr
					self._txtYesen.text = yesStrEn
					self._txtNoen.text = "CANCEL"

					if self.viewParam.msgBoxType == boxType.Yes then
						gohelper.setActive(self._goNo, false)
						gohelper.setActive(self._goYes, true)
					elseif self.viewParam.msgBoxType == boxType.NO then
						gohelper.setActive(self._goYes, false)
						gohelper.setActive(self._goNo, true)
					elseif self.viewParam.msgBoxType == boxType.Yes_No then
						gohelper.setActive(self._goNo, true)
						gohelper.setActive(self._goYes, true)
					end

					NavigateMgr.instance:addEscape(ViewName.MessageOptionBoxView, self._onEscapeBtnClick, self)
				end
			end
		end
	end
end

function MessageOptionBoxView:_onEscapeBtnClick()
	if self._goNo.gameObject.activeInHierarchy then
		self:_closeInvokeCallback(closeType.No)
	end
end

function MessageOptionBoxView:refreshOptionUI()
	gohelper.setActive(self._toggleoption.gameObject, true)

	self.optionType = self.viewParam.optionType
	self.optionExParam = self.viewParam.optionExParam
	self.messageBoxId = self.viewParam.messageBoxId

	if self.optionType == MsgBoxEnum.optionType.Daily then
		self._txtoption.text = luaLang("messageoptionbox_daily")
	elseif self.viewParam.optionType == MsgBoxEnum.optionType.NotShow then
		self._txtoption.text = luaLang("messageoptionbox_notshow")
	else
		gohelper.setActive(self._toggleoption.gameObject, false)
	end
end

function MessageOptionBoxView:saveOptionData()
	if self.optionType <= 0 or not self._toggleoption.isOn then
		return
	end

	local key = MessageBoxController.instance:getOptionLocalKey(self.messageBoxId, self.optionType, self.optionExParam)

	if self.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(key)
	elseif self.optionType == MsgBoxEnum.optionType.NotShow then
		PlayerPrefsHelper.setString(key, self.optionType)
	end
end

function MessageOptionBoxView:onClose()
	return
end

function MessageOptionBoxView:onDestroyView()
	return
end

return MessageOptionBoxView
