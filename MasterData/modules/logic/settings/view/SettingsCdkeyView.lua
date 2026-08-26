-- chunkname: @modules/logic/settings/view/SettingsCdkeyView.lua

module("modules.logic.settings.view.SettingsCdkeyView", package.seeall)

local SettingsCdkeyView = class("SettingsCdkeyView", BaseView)

function SettingsCdkeyView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._inputcdkey = gohelper.findChildTextMeshInputField(self.viewGO, "#input_cdkey")
	self._goplaceholdertext = gohelper.findChildText(self.viewGO, "#input_cdkey/Text Area/Placeholder")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_sure")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsCdkeyView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._inputcdkey:AddOnEndEdit(self._onInputCdkeyEndEdit, self)
	self._inputcdkey:AddOnValueChanged(self._onValueChanged, self)
end

function SettingsCdkeyView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._inputcdkey:RemoveOnEndEdit()
	self._inputcdkey:RemoveOnValueChanged()
end

function SettingsCdkeyView:_btncloseOnClick()
	self:closeThis()
end

function SettingsCdkeyView:_btnsureOnClick()
	local cdKey = self._inputcdkey:GetText()

	if string.nilorempty(cdKey) then
		GameFacade.showToast(ToastEnum.SettingsCdkeyIsNull)

		return
	end

	PlayerRpc.instance:sendUseCdKeyRequset(cdKey)
end

function SettingsCdkeyView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	SLFramework.UGUI.UIClickListener.Get(self._inputcdkey.gameObject):AddClickListener(self._hidePlaceholderText, self)
	self.addEventCb(self, SettingsController.instance, SettingsEvent.OnUseCdkReplay, self.onUseCdkReplay, self)
end

function SettingsCdkeyView:_hidePlaceholderText()
	ZProj.UGUIHelper.SetColorAlpha(self._goplaceholdertext, 0)
end

function SettingsCdkeyView:_onValueChanged(text)
	local len = GameUtil.utf8len(text)

	if len > 50 then
		self._inputcdkey:SetText(GameUtil.utf8sub(text, 1, 50))
	end
end

function SettingsCdkeyView:_onInputCdkeyEndEdit()
	ZProj.UGUIHelper.SetColorAlpha(self._goplaceholdertext, 0.6)
end

function SettingsCdkeyView:onUpdateParam()
	return
end

function SettingsCdkeyView:onOpen()
	return
end

function SettingsCdkeyView:onUseCdkReplay()
	self._inputcdkey:SetText("")
end

function SettingsCdkeyView:onClose()
	SLFramework.UGUI.UIClickListener.Get(self._inputcdkey.gameObject):RemoveClickListener()
end

function SettingsCdkeyView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return SettingsCdkeyView
