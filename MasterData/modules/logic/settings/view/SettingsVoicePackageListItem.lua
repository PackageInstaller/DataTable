-- chunkname: @modules/logic/settings/view/SettingsVoicePackageListItem.lua

module("modules.logic.settings.view.SettingsVoicePackageListItem", package.seeall)

local SettingsVoicePackageListItem = class("SettingsVoicePackageListItem", ListScrollCellExtend)

function SettingsVoicePackageListItem:onInitView()
	self._txtname1 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_name")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_name")
	self._txtsize1 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_size")
	self._txtsize2 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_size")
	self._txtVersion = gohelper.findChildText(self.viewGO, "#txt_version")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_unselected")
	self._gocur1 = gohelper.findChild(self.viewGO, "#go_selected/#txt_selected")
	self._gocur2 = gohelper.findChild(self.viewGO, "#go_unselected/#txt_selected")
	self._goNowIcon1 = gohelper.findChild(self.viewGO, "#go_selected/#txt_name/#go_icon")
	self._goNowIcon2 = gohelper.findChild(self.viewGO, "#go_unselected/#txt_name/#go_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsVoicePackageListItem:addEvents()
	return
end

function SettingsVoicePackageListItem:removeEvents()
	return
end

function SettingsVoicePackageListItem:_btndownloadOnClick()
	local status = self._mo:getStatus()

	logWarn("SettingsVoicePackageListItem _btndownloadOnClick self._mo.lang = " .. self._mo.lang .. " status = " .. status)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)

	if status == SettingsVoicePackageController.NotDownload or status == SettingsVoicePackageController.NeedUpdate then
		SettingsVoicePackageController.instance:startDownload(self._mo)
	end
end

function SettingsVoicePackageListItem:_btnstopdownloadOnClick()
	SettingsVoicePackageController.instance:stopDownload(self._mo)
end

function SettingsVoicePackageListItem:_editableInitView()
	self._gotogclick = gohelper.findChild(self.viewGO, "#go_togclick")
	self._btn = gohelper.getClickWithAudio(self._gotogclick)
end

function SettingsVoicePackageListItem:_editableAddEvents()
	self._btn:AddClickListener(self._onClick, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._onPackItemStateChange, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, self._updateSelecet, self)
end

function SettingsVoicePackageListItem:_editableRemoveEvents()
	self._btn:RemoveClickListener()
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._onPackItemStateChange, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, self._updateSelecet, self)
end

function SettingsVoicePackageListItem:_onPackItemStateChange(packName, failReason)
	if self._mo.lang ~= packName then
		return
	end

	self:_updateStatus()
end

function SettingsVoicePackageListItem:onUpdateMO(mo)
	self._mo = mo

	local txtName = luaLang(mo.nameLangId)
	local defaultVoiceShortcut = GameConfig:GetDefaultVoiceShortcut()
	local isDefaultVoice = self._mo.lang == defaultVoiceShortcut

	if HotUpdateVoiceMgr.IsGuoFu then
		local isForceVoice = HotUpdateVoiceMgr.ForceSelect[self._mo.lang]

		if isDefaultVoice or isForceVoice then
			txtName = formatLuaLang("voice_package_default", txtName)
			self._txtname2.alpha = 0.8
		else
			self._txtname2.alpha = 1
		end

		self._txtname1.text = txtName
		self._txtname2.text = txtName

		local cur = GameConfig:GetCurVoiceShortcut()

		self:_updateSelecet(cur)

		local isCurVoice = cur == self._mo.lang

		gohelper.setActive(self._gocur1, isCurVoice)
		gohelper.setActive(self._gocur2, isCurVoice)
		gohelper.setActive(self._goNowIcon1, isCurVoice)
		gohelper.setActive(self._goNowIcon2, isCurVoice)
		self:_updateStatus()

		if self._txtVersion then
			self._txtVersion.text = self:_getLangCurVersion(self._mo.lang, defaultVoiceShortcut)
		end
	end
end

function SettingsVoicePackageListItem:_getLangCurVersion(langShortcut, defaultShortcut)
	if not ProjBooter.instance:isUseBigZip() then
		return ""
	end

	if HotUpdateVoiceMgr.IsGuoFu and langShortcut == defaultShortcut then
		langShortcut = HotUpdateVoiceMgr.LangZh
	end

	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
	local voiceBranch = optionalUpdateInst.VoiceBranch
	local localVersion = optionalUpdateInst:GetLocalVersion(langShortcut)

	if string.nilorempty(localVersion) then
		return ""
	end

	return string.format("V.%s.%s", tostring(voiceBranch), tostring(localVersion))
end

function SettingsVoicePackageListItem:_updateStatus(curSize, allSize)
	local status = self._mo:getStatus()

	if self._mo:needDownload() then
		local foramtStr = status == SettingsVoicePackageController.NeedUpdate and luaLang("voice_package_update_5") or "(%s)"
		local leftSize, size, units = self._mo:getLeftSizeMBorGB()
		local sizeStr = string.format("%.2f%s", leftSize, units)
		local str = string.format(foramtStr, sizeStr)

		self._txtsize1.text = str
		self._txtsize2.text = str
	else
		self._txtsize1.text = ""
		self._txtsize2.text = ""
	end
end

function SettingsVoicePackageListItem:_onClick()
	SettingsVoicePackageController.instance:dispatchEvent(SettingsEvent.OnChangeSelecetDownloadVoicePack, self._mo.lang)
end

function SettingsVoicePackageListItem:_updateSelecet(lang)
	local seleceted = lang == self._mo.lang

	gohelper.setActive(self._goselected, seleceted)
	gohelper.setActive(self._gounselected, seleceted == false)
end

function SettingsVoicePackageListItem:onSelect(isSelect)
	return
end

function SettingsVoicePackageListItem:onDestroyView()
	return
end

return SettingsVoicePackageListItem
