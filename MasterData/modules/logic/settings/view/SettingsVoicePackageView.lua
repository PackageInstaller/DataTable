-- chunkname: @modules/logic/settings/view/SettingsVoicePackageView.lua

module("modules.logic.settings.view.SettingsVoicePackageView", package.seeall)

local SettingsVoicePackageView = class("SettingsVoicePackageView", BaseView)

function SettingsVoicePackageView:onInitView()
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "view/#scroll_content")
	self._btndownload = gohelper.findChildButtonWithAudio(self.viewGO, "view/btn/#btn_downloadall")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._btndelete = gohelper.findChildButtonWithAudio(self.viewGO, "view/btn/#btn_delete")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")
	self._txttips = gohelper.findChildText(self.viewGO, "view/#txt_desc")
	self._goon = gohelper.findChild(self.viewGO, "view/btn/#btn_delete/#go_on")
	self._gooff = gohelper.findChild(self.viewGO, "view/btn/#btn_delete/#go_off")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsVoicePackageView:addEvents()
	self._btndownload:AddClickListener(self._btndownloadOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndelete:AddClickListener(self._btndeleteOnClick, self)
end

function SettingsVoicePackageView:removeEvents()
	self._btndownload:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btndelete:RemoveClickListener()
end

function SettingsVoicePackageView:_btndeleteOnClick()
	if self._isNowOrDefault == false then
		local packInfo = SettingsVoicePackageModel.instance:getPackInfo(self._selectType)

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DeleteVoicePack, MsgBoxEnum.BoxType.Yes_No, function()
			SettingsVoicePackageController.instance:deleteVoicePack(self._selectType)
		end, nil, nil, nil, nil, nil, luaLang(packInfo.nameLangId))
	end
end

function SettingsVoicePackageView:_btncloseOnClick()
	self:closeThis()
end

function SettingsVoicePackageView:_btndownloadOnClick()
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(self._selectType)
	local data = {}

	data.entrance = "package_manage"
	data.update_amount = packInfo:getLeftSizeMBNum()
	data.download_voice_pack_list = {
		packInfo.lang
	}
	data.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
	data.current_language = GameConfig:GetCurLangShortcut()
	data.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, data)
	self:closeThis()
	SettingsVoicePackageController.instance:tryDownload(packInfo)
end

function SettingsVoicePackageView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._downOrderList = {}
end

function SettingsVoicePackageView:onUpdateParam()
	self:_refreshButton()
end

function SettingsVoicePackageView:onOpen()
	self:_updateSelecet(GameConfig:GetCurVoiceShortcut())
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._refreshButton, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, self._updateSelecet, self)
end

function SettingsVoicePackageView:onClose()
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._refreshButton, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, self._updateSelecet, self)
end

function SettingsVoicePackageView:_updateSelecet(selectType)
	self._selectType = selectType

	self:_refreshButton()
end

function SettingsVoicePackageView:_refreshButton()
	self._isNowOrDefault = self._selectType == GameConfig:GetCurVoiceShortcut() or self._selectType == GameConfig:GetDefaultVoiceShortcut()

	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(self._selectType)

	gohelper.setActive(self._btndownload, packInfo and packInfo:needDownload())
	gohelper.setActive(self._btndelete, packInfo and packInfo:hasLocalFile() and not HotUpdateVoiceMgr.ForceSelect[self._selectType])
	gohelper.setActive(self._goon, self._isNowOrDefault == false)
	gohelper.setActive(self._gooff, self._isNowOrDefault)
end

function SettingsVoicePackageView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return SettingsVoicePackageView
