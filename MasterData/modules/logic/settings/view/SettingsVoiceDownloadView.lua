-- chunkname: @modules/logic/settings/view/SettingsVoiceDownloadView.lua

module("modules.logic.settings.view.SettingsVoiceDownloadView", package.seeall)

local SettingsVoiceDownloadView = class("SettingsVoiceDownloadView", BaseView)

function SettingsVoiceDownloadView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "view/main/#txt_title2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "view/main/#txt_desc")
	self._txtloading = gohelper.findChildText(self.viewGO, "view/main/#txt_loading")
	self._gobtnloading = gohelper.findChild(self.viewGO, "view/#go_btnloading")
	self._btncanceldownload = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_btnloading/#btn_cancel")
	self._goon = gohelper.findChild(self.viewGO, "view/#go_btnloading/#btn_cancel/#go_on")
	self._gooff = gohelper.findChild(self.viewGO, "view/#go_btnloading/#btn_cancel/#go_off")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_btnloading/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end

	SettingsVoicePackageController.instance:register()
end

function SettingsVoiceDownloadView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncanceldownload:AddClickListener(self._btncanceldownloadOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function SettingsVoiceDownloadView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncanceldownload:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
end

function SettingsVoiceDownloadView:_btncloseOnClick()
	return
end

function SettingsVoiceDownloadView:_btncanceldownloadOnClick()
	if not self._succ then
		SettingsVoicePackageController.instance:stopDownload(self._mo)
	end

	self:closeThis()
end

function SettingsVoiceDownloadView:_btnswitchOnClick()
	if self._mo.lang == "res-HD" then
		self:closeThis()
		SettingsModel.instance:setVideoHDMode(true)
		SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeHDType)

		return
	end

	SettingsVoicePackageController.instance:switchVoiceType(self._mo.lang, "in_voiceview")

	local allCharMos = HeroModel.instance:getAllHero()

	for _, charMo in pairs(allCharMos) do
		local heroId = charMo.heroId
		local langId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)

		if not usingDefaultLang then
			SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(self._mo.lang, charMo.heroId)
		end
	end

	ToastController.instance:showToast(182)
	self:closeThis()
end

function SettingsVoiceDownloadView:_editableInitView()
	self._imgloading = gohelper.findChildImage(self.viewGO, "view/main/loadingline/#img_loading")

	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._txtcancel = gohelper.findChildText(self.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancel")
	self._txtcancelEn = gohelper.findChildText(self.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancelen")
	self._txtconfirm = gohelper.findChildText(self.viewGO, "view/#go_btnloading/#btn_confirm/#txt_confirm")
	self._goCanceldownload = self._btncanceldownload.gameObject
end

function SettingsVoiceDownloadView:onUpdateParam()
	return
end

function SettingsVoiceDownloadView:onOpen()
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, self._refreshDownloadProgress, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, self._refreshUnzipProgress, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, self._onDownloadPackSuccess, self)
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadProgressRefresh, self._refreshDownloadProgress, self)
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadFinish, self._onDownloadPackSuccess, self)
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownladErrorMsg, self._onDownladErrorMsg, self)

	self._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UnzipProgress, self._refreshUnzipProgress, self)

	self._mo = self.viewParam.packItemMO
	self._txttitle2.text = formatLuaLang("voice_package_update_3", luaLang(self._mo.nameLangId))
	self._txtcancel.text = luaLang("voice_package_cancel_download")
	self._txtcancelEn.text = "CANCEL"

	gohelper.setActive(self._txtdesc.gameObject, false)
	gohelper.setActive(self._btnswitch.gameObject, false)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
end

function SettingsVoiceDownloadView:onClose()
	self._eventMgrInst:ClearLuaListener()
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, self._refreshDownloadProgress, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, self._refreshUnzipProgress, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, self._onDownloadPackSuccess, self)
	self.removeEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadProgressRefresh, self._refreshDownloadProgress, self)
	self.removeEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadFinish, self._onDownloadPackSuccess, self)
	self.removeEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownladErrorMsg, self._onDownladErrorMsg, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
end

function SettingsVoiceDownloadView:_refreshDownloadProgress(packName, curSize, allSize)
	curSize = string.format("%0.2f", curSize / 1024 / 1024)
	allSize = string.format("%0.2f", allSize / 1024 / 1024)
	self._imgloading.fillAmount = curSize / allSize

	local tag = {
		curSize .. "MB",
		allSize .. "MB"
	}

	self._txtloading.text = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_4"), tag)
end

function SettingsVoiceDownloadView:_refreshUnzipProgress(progress)
	self._imgloading.fillAmount = progress
	self._txtloading.text = luaLang("voice_package_unzip")

	gohelper.setActive(self._goCanceldownload, false)
end

function SettingsVoiceDownloadView:_onDownloadPackSuccess()
	self._succ = true
	self._txtcancel.text = luaLang("cancel")
	self._txtcancelEn.text = "CANCEL"
	self._txtconfirm.text = luaLang("confirm")
	self._imgloading.fillAmount = 1
	self._txtloading.text = ""

	gohelper.setActive(self._btncanceldownload.gameObject, true)

	if self._mo.lang == "res-HD" then
		gohelper.setActive(self._txtdesc.gameObject, false)
		gohelper.setActive(self._btncanceldownload, false)
	else
		gohelper.setActive(self._txtdesc.gameObject, true)
	end

	gohelper.setActive(self._btnswitch.gameObject, true)
end

function SettingsVoiceDownloadView:_onReconnectSucc()
	if self._errorMsgInfo then
		if self._errorMsgInfo.yesCallback then
			self._errorMsgInfo.yesCallback(self._errorMsgInfo.yesCallbackObj)
		end

		self._errorMsgInfo = nil
	end
end

function SettingsVoiceDownloadView:_onDownladErrorMsg(msgInfo)
	self._errorMsgInfo = msgInfo

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", luaLang("cancel"), "CANCEL", function()
		self._errorMsgInfo = nil

		if msgInfo.yesCallback then
			msgInfo.yesCallback(msgInfo.yesCallbackObj)
		end
	end, function()
		if msgInfo.noCallback then
			msgInfo.noCallback(msgInfo.noCallbackObj)
		end

		self:closeThis()
	end, nil, nil, nil, nil, luaLang(self._mo.nameLangId), msgInfo.extra)
end

function SettingsVoiceDownloadView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return SettingsVoiceDownloadView
