-- chunkname: @modules/logic/settings/view/SettingsLanguageView.lua

module("modules.logic.settings.view.SettingsLanguageView", package.seeall)

local SettingsLanguageView = class("SettingsLanguageView", BaseView)

function SettingsLanguageView:onInitView()
	self._btndownload = gohelper.findChildButtonWithAudio(self.viewGO, "download/#btn_download")
	self._godownload = gohelper.findChild(self.viewGO, "download/#btn_download/#go_download")
	self._godownloading = gohelper.findChild(self.viewGO, "download/#btn_download/#go_downloading")
	self._txtdownloadingprogress = gohelper.findChildText(self.viewGO, "download/#btn_download/#go_downloading/#txt_downloadingprogress")
	self._gotxtlang = gohelper.findChild(self.viewGO, "#go_lang/#go_txtlang")
	self._govoicelang = gohelper.findChild(self.viewGO, "#go_lang/#go_voicelang")
	self._godropnode = gohelper.findChild(self.viewGO, "dropnode")
	self._gostoryvoicelang = gohelper.findChild(self.viewGO, "#go_lang/#go_storyvoicelang")
	self._godesc = gohelper.findChild(self.viewGO, "#go_lang/#go_voicelang/#go_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_lang/#go_voicelang/#go_desc/#txt_desc")
	self._btncustomvoice = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lang/#go_voicelang/#btn_go")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsLanguageView:addEvents()
	self._btndownload:AddClickListener(self._btndownloadOnClick, self)
	self._btncustomvoice:AddClickListener(self._btnCustomRoleVoiceOnClick, self)
end

function SettingsLanguageView:removeEvents()
	self._btndownload:RemoveClickListener()
	self._btncustomvoice:RemoveClickListener()
end

function SettingsLanguageView:_btndownloadOnClick()
	SettingsVoicePackageController.instance:openVoicePackageView()
end

function SettingsLanguageView:_btnCustomRoleVoiceOnClick()
	SettingsRoleVoiceController.instance:openSettingRoleVoiceView()
end

function SettingsLanguageView:_editableInitView()
	self._voiceDropDownGo = gohelper.findChild(self._godropnode, "dropvoicelang")
	self._txtvoiceDrop = gohelper.findChildText(self._voiceDropDownGo, "Label")
	self._voiceClick = gohelper.getClickWithAudio(self._voiceDropDownGo, AudioEnum.UI.play_ui_set_click)

	self._voiceClick:AddClickListener(self._onvoiceClick, self)

	self._voiceDropDownItemListGo = gohelper.findChild(self._voiceDropDownGo, "Template")
	self._voiceDropDownItemContainer = gohelper.findChild(self._voiceDropDownItemListGo, "Viewport/Content")
	self._voiceItemGo = gohelper.findChild(self._voiceDropDownItemContainer, "Item")

	gohelper.setActive(self._voiceItemGo, false)

	self._voiceDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._voiceDropDownItemListGo)

	self._voiceDropDownTouchEventMgr:SetIgnoreUI(true)
	self._voiceDropDownTouchEventMgr:SetOnlyTouch(true)
	self._voiceDropDownTouchEventMgr:SetOnClickCb(self._hideVoice, self)

	self._voiceItemList = {}
	self._langItemList = {}

	self:_refreshVoiceDropDown()

	self._langDropDownGo = gohelper.findChild(self._godropnode, "droplang")
	self._txtLangDrop = gohelper.findChildText(self._langDropDownGo, "Label")
	self._langClick = gohelper.getClickWithAudio(self._langDropDownGo, AudioEnum.UI.play_ui_set_click)

	self._langClick:AddClickListener(self._onlangDropClick, self)

	self._langDropDownItemListGo = gohelper.findChild(self._langDropDownGo, "Template")
	self._langDropDownItemContainer = gohelper.findChild(self._langDropDownItemListGo, "Viewport/Content")
	self._langItemGo = gohelper.findChild(self._langDropDownItemContainer, "Item")

	gohelper.setActive(self._langItemGo, false)

	self._langDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._langDropDownItemListGo)

	self._langDropDownTouchEventMgr:SetIgnoreUI(true)
	self._langDropDownTouchEventMgr:SetOnlyTouch(true)
	self._langDropDownTouchEventMgr:SetOnClickCb(self._hideLang, self)
	self:_refreshLangDropDown()

	self.trVoiceDropArrow = gohelper.findChildComponent(self._voiceDropDownGo, "arrow", typeof(UnityEngine.Transform))
	self.trLangDropArrow = gohelper.findChildComponent(self._langDropDownGo, "arrow", typeof(UnityEngine.Transform))

	local curLang = self._allLangTypes[self._curLangTxtIndex + 1]
	local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLang)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(lanIndex)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", lanIndex - 1)
end

function SettingsLanguageView:_onChangeLangTxt()
	self:_refreshVoiceDropDownStr()
end

function SettingsLanguageView:_refreshVoiceDropDown()
	self._allVoiceTypes = {}
	self._allStoryVoiceTypes = {}
	self._allStoryVoiceTypesStr = {}

	local curLang = GameConfig:GetCurVoiceShortcut()

	self._curVoiceIndex = 0
	self._curStoryVoiceIndex = 0

	local supportLangList = SettingsVoicePackageModel.instance:getSupportVoiceLangs()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	for i = 1, #supportLangList do
		local lang = supportLangList[i]

		if lang == defaultLang then
			table.insert(self._allVoiceTypes, 1, lang)
		else
			local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload)

			if isOpen then
				table.insert(self._allVoiceTypes, lang)
			end
		end
	end

	local index = tabletool.indexOf(self._allVoiceTypes, curLang)

	self._curVoiceIndex = (index or 1) - 1

	self:_refreshVoiceDropDownStr()
end

function SettingsLanguageView:_refreshLangDropDown()
	local _supportedLangShortcuts = GameConfig:GetSupportedLangShortcuts()

	self._allLangTypes = {}
	self._allLangTypesStr = {}

	local curLang = GameConfig:GetCurLangShortcut()

	self._curLangTxtIndex = 0

	for i = 0, _supportedLangShortcuts.Length - 1 do
		local shortcut = _supportedLangShortcuts[i]

		if OpenConfig.instance:isOpenLangTxt(shortcut) then
			table.insert(self._allLangTypes, shortcut)
			table.insert(self._allLangTypesStr, SettingsConfig.instance:getSettingLang(shortcut))

			if shortcut == curLang then
				logNormal("cur lang index = " .. #self._allLangTypes)

				self._curLangTxtIndex = #self._allLangTypes - 1
			end
		end
	end

	self:_refreshLangDropDownStr()
end

function SettingsLanguageView:_refreshLangDropDownStr()
	local curLang = GameConfig:GetCurLangShortcut()

	for i, _lang in ipairs(self._allLangTypes) do
		local txt = self._allLangTypesStr[i]

		if _lang == curLang then
			self._txtLangDrop.text = string.format("<color=#c3beb6ff>%s</color>", txt)
			txt = string.format("<color=#efb785ff>%s</color>", txt)
		else
			txt = string.format("<color=#c3beb6ff>%s</color>", txt)
		end

		local item = self._langItemList[i]

		if item == nil then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._langItemGo, "Item" .. i)
			item.goselected = gohelper.findChild(item.go, "BG")
			item.goxian = gohelper.findChild(item.go, "xian")
			item.txt = gohelper.findChildText(item.go, "Text")
			item.btn = gohelper.getClickWithAudio(item.go, AudioEnum.UI.play_ui_plot_common)

			item.btn:AddClickListener(function(tabTable)
				transformhelper.setLocalScale(self.trLangDropArrow, 1, 1, 1)
				self:_onChangeLangTxtType(i - 1)
			end, item)

			self._langItemList[i] = item
		end

		item.txt.text = txt

		gohelper.setActive(item.goselected, _lang == curLang)
		gohelper.setActive(item.go, true)
		gohelper.setActive(item.goxian, i ~= #self._allLangTypes)
	end

	for i = #self._allLangTypes + 1, #self._allLangTypes do
		gohelper.setActive(self._allLangTypes[i].go, false)
	end

	local contentHeight = #self._allLangTypes * 84

	recthelper.setHeight(self._langDropDownItemListGo.transform, contentHeight)
end

function SettingsLanguageView:_refreshVoiceDropDownStr()
	local curLang = GameConfig:GetCurVoiceShortcut()

	for i, _lang in ipairs(self._allVoiceTypes) do
		local txt = luaLang(_lang)
		local packInfo = SettingsVoicePackageModel.instance:getPackInfo(_lang)

		if _lang == curLang then
			self._curVoiceIndex = i - 1
			self._txtvoiceDrop.text = string.format("<color=#c3beb6ff>%s</color>", txt)
			txt = string.format("<color=#efb785ff>%s</color>", txt)
		elseif packInfo and packInfo:needDownload() then
			local leftSize, size, units = packInfo:getLeftSizeMBorGB()

			txt = string.format("<color=#c3beb666>%s%s</color>", txt, string.format("(%.2f%s)", leftSize, units))
		else
			txt = string.format("<color=#c3beb6ff>%s</color>", txt)
		end

		local item = self._voiceItemList[i]

		if item == nil then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._voiceItemGo, "Item" .. i)
			item.goselected = gohelper.findChild(item.go, "BG")
			item.goxian = gohelper.findChild(item.go, "xian")
			item.txt = gohelper.findChildText(item.go, "Text")
			item.btn = gohelper.getClickWithAudio(item.go, AudioEnum.UI.play_ui_plot_common)

			item.btn:AddClickListener(function(tabTable)
				transformhelper.setLocalScale(self.trVoiceDropArrow, 1, 1, 1)
				self:_onChangeVoiceType(i - 1)
			end, item)

			self._voiceItemList[i] = item
		end

		item.txt.text = txt

		gohelper.setActive(item.goselected, _lang == curLang)
		gohelper.setActive(item.go, true)
		gohelper.setActive(item.goxian, i ~= #self._allVoiceTypes)
	end

	for i = #self._allVoiceTypes + 1, #self._voiceItemList do
		gohelper.setActive(self._voiceItemList[i].go, false)
	end

	local contentHeight = #self._allVoiceTypes * 84

	recthelper.setHeight(self._voiceDropDownItemListGo.transform, contentHeight)
	self:_updateVoiceTips()
end

function SettingsLanguageView:_onChangeVoiceType(index)
	logNormal("_onChangeVoiceType index = " .. index)

	if self._curVoiceIndex == index then
		return
	end

	self._toChangeVoiceTypeIdx = index

	local voiceType = self._allVoiceTypes[index + 1]
	local langStr = luaLang(voiceType)

	GameFacade.showMessageBox(MessageBoxIdDefine.SettingAllRoleVoice, MsgBoxEnum.BoxType.Yes_No, self._doChangeVoiceTypeAction, nil, nil, self, nil, nil, langStr)
end

function SettingsLanguageView:_doChangeVoiceTypeAction()
	local index = self._toChangeVoiceTypeIdx
	local curVoiceType = self._allVoiceTypes[index + 1]
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curVoiceType)

	if packInfo and packInfo:needDownload() then
		SettingsVoicePackageController.instance:tryDownload(packInfo, true)
	else
		self.addEventCb(self, AudioMgr.instance, AudioMgr.Evt_ChangeFinish, self._onChangeFinish, self)

		self._curVoiceIndex = index

		if curVoiceType then
			SettingsVoicePackageController.instance:switchVoiceType(curVoiceType, "in_settings")
			self:_refreshVoiceDropDownStr()

			local allCharMos = HeroModel.instance:getAllHero()

			for _, charMo in pairs(allCharMos) do
				local heroId = charMo.heroId
				local langId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)

				if not usingDefaultLang then
					SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(curVoiceType, charMo.heroId)
				end
			end
		else
			logError("_onChangeVoiceType error  index =" .. self._curVoiceIndex)
		end
	end

	gohelper.setActive(self._voiceDropDownItemListGo, false)
end

function SettingsLanguageView:_updateVoiceTips()
	local curLang = GameConfig:GetCurVoiceShortcut()
	local tips = SettingsConfig.instance:getVoiceTips(curLang)

	self._txtdesc.text = tips

	gohelper.setActive(self._godesc, string.nilorempty(tips) == false)
end

function SettingsLanguageView:_onChangeFinish()
	self.removeEventCb(self, AudioMgr.instance, AudioMgr.Evt_ChangeFinish, self._onChangeFinish, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
end

function SettingsLanguageView:_onChangeStoryVoiceType(index)
	logNormal("_onChangeStoryVoiceType index = " .. index)

	if self._curStoryVoiceIndex == index then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	self._curStoryVoiceIndex = index

	local curVoiceType = self._allStoryVoiceTypes[self._curStoryVoiceIndex + 1]

	if curVoiceType then
		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, curVoiceType)

		local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curVoiceType)

		PlayerPrefsHelper.setNumber("StoryAudioLanType", lanIndex - 1)
		PlayerPrefsHelper.save()
		self:_refreshLangDropDownStr()
	else
		logError("_onChangeVoiceType error  index =" .. self._curStoryVoiceIndex)
	end
end

function SettingsLanguageView:_onChangeLangTxtType(index)
	logNormal("_onChangeLangTxtType index = " .. index)

	if self._curLangTxtIndex == index then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	self._curLangTxtIndex = index

	local curLang = self._allLangTypes[self._curLangTxtIndex + 1]

	LangSettings.instance:SetCurLangType(curLang, self._onChangeLangTxtType2, self)
end

function SettingsLanguageView:_onChangeLangTxtType2(index)
	local curLang = GameConfig:GetCurLangShortcut()
	local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLang)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(lanIndex)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", lanIndex - 1)
	self:_refreshLangDropDownStr()
	SettingsController.instance:changeLangTxt()
end

function SettingsLanguageView:onUpdateParam()
	return
end

function SettingsLanguageView:onOpen()
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadFinish, self._refreshVoiceDropDown, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._refreshVoiceDropDown, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, self._refreshVoiceDropDown, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, self._onPackItemStateChange, self)
	self.addEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, self._refreshVoiceDropDownStr, self)
	self.addEventCb(self, SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
	gohelper.setActive(self._btndownload.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload))
	gohelper.setActive(self._govoicelang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsVoiceLang))
	gohelper.setActive(self._gotxtlang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsTxtLang))
	gohelper.setActive(self._gostoryvoicelang, false)
	gohelper.setActive(self._godownload, true)
	gohelper.setActive(self._godownloading, false)
end

function SettingsLanguageView:_onPackItemStateChange()
	self:_refreshVoiceDropDownStr()
end

function SettingsLanguageView:_onlangDropClick()
	transformhelper.setLocalScale(self.trLangDropArrow, 1, -1, 1)
	gohelper.setActive(self._langDropDownItemListGo, true)
end

function SettingsLanguageView:_onvoiceClick()
	SettingsVoicePackageController.instance:onSettingVoiceDropDown()
	transformhelper.setLocalScale(self.trVoiceDropArrow, 1, -1, 1)
	gohelper.setActive(self._voiceDropDownItemListGo, true)
end

function SettingsLanguageView:_hideVoice()
	transformhelper.setLocalScale(self.trVoiceDropArrow, 1, 1, 1)
	gohelper.setActive(self._voiceDropDownItemListGo, false)
end

function SettingsLanguageView:_hideLang()
	transformhelper.setLocalScale(self.trLangDropArrow, 1, 1, 1)
	gohelper.setActive(self._langDropDownItemListGo, false)
end

function SettingsLanguageView:_onstoryVoiceClick()
	self:_cleanXian(self._storyVoiceDropDown)
end

function SettingsLanguageView:_cleanXian(dropdown)
	local dropdownListTrs = gohelper.findChild(dropdown.gameObject, "Dropdown List").transform
	local contentTrs = gohelper.findChild(dropdown.gameObject, "Dropdown List/Viewport/Content").transform
	local contentHeight = recthelper.getHeight(contentTrs)

	recthelper.setHeight(dropdownListTrs, contentHeight)

	local langContentTrs = gohelper.findChild(dropdown.gameObject, "Dropdown List/Viewport/Content").transform

	if langContentTrs then
		local lastIndex = langContentTrs.childCount - 1
		local lastGO = langContentTrs:GetChild(lastIndex).gameObject
		local xian = gohelper.findChild(lastGO, "xian")

		gohelper.setActive(xian, false)
	end
end

function SettingsLanguageView:onClose()
	self.removeEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadFinish, self._refreshVoiceDropDown, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, self._refreshVoiceDropDown, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, self._refreshVoiceDropDown, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, self._refreshVoiceDropDownStr, self)
	self.removeEventCb(self, SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, self._refreshVoiceDropDownStr, self)
	self.removeEventCb(self, SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
end

function SettingsLanguageView:onDestroyView()
	self._voiceClick:RemoveClickListener()
	self._langClick:RemoveClickListener()

	if not gohelper.isNil(self._voiceDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(self._voiceDropDownTouchEventMgr)
	end

	if not gohelper.isNil(self._langDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(self._langDropDownTouchEventMgr)
	end

	if self._voiceItemList and #self._voiceItemList > 0 then
		for i = 1, #self._voiceItemList do
			self._voiceItemList[i].btn:RemoveClickListener()
		end
	end

	if self._langItemList and #self._langItemList > 0 then
		for i = 1, #self._langItemList do
			self._langItemList[i].btn:RemoveClickListener()
		end
	end
end

return SettingsLanguageView
