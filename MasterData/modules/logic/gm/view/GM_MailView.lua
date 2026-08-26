-- chunkname: @modules/logic/gm/view/GM_MailView.lua

module("modules.logic.gm.view.GM_MailView", package.seeall)

local GM_MailView = class("GM_MailView", BaseView)
local sf = string.format
local kYellow = "#FFFF00"
local kRed = "#FF0000"
local kGreen = "#00FF00"
local kBlue = "#0000FF"

function GM_MailView.register()
	GM_MailView.MailView_register(MailView)
	GM_MailView.MailCategoryListItem_register(MailCategoryListItem)
end

function GM_MailView.MailView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_MailViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_MailViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		MailCategroyModel.instance:onModelUpdate()
	end
end

function GM_MailView.MailCategoryListItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshInfo")

	function T._refreshInfo(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshInfo", ...)

		if not GM_MailView.s_ShowAllTabId then
			return
		end

		local mo = selfObj._mo
		local desc1_us = sf("mailId=%s", gohelper.getRichColorText(mo.mailId, kRed))
		local desc1_s = sf("mailId=%s", gohelper.getRichColorText(mo.mailId, kYellow))
		local desc2_us = sf("incr=%s", gohelper.getRichColorText(mo.id, kBlue))

		selfObj._txtmailTitleSelect.text = desc1_s
		selfObj._txtmailTitleUnSelect.text = desc1_us
		selfObj._txtmailTimeSelect.text = sf("incr=%s", gohelper.getRichColorText(mo.id, kGreen))
		selfObj._txtmailTimeUnSelect.text = desc2_us
	end
end

function GM_MailView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_MailView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_MailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_MailView:onOpen()
	self:_refreshItem1()
end

function GM_MailView:onDestroyView()
	return
end

GM_MailView.s_ShowAllTabId = false

function GM_MailView:_refreshItem1()
	self._item1Toggle.isOn = GM_MailView.s_ShowAllTabId
end

function GM_MailView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_MailView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.MailView_ShowAllTabIdUpdate, isOn)
end

return GM_MailView
