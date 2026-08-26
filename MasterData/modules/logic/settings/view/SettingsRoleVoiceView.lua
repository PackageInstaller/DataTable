-- chunkname: @modules/logic/settings/view/SettingsRoleVoiceView.lua

module("modules.logic.settings.view.SettingsRoleVoiceView", package.seeall)

local SettingsRoleVoiceView = class("SettingsRoleVoiceView", BaseView)

function SettingsRoleVoiceView:_refreshVoiceItemList()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()
	local dataList = self:_getVoiceItemList()

	for i, data in ipairs(dataList) do
		local item

		if i > #self._voiceItemObjList then
			item = self:_create_SettingsRoleVoiceViewLangBtn(i)

			table.insert(self._voiceItemObjList, item)
		else
			item = self._voiceItemObjList[i]
		end

		item:onUpdateMO(data)
		item:setActive(true)
		item:setSelected(defaultLang == data.lang)
	end

	for i = #dataList + 1, #self._voiceItemObjList do
		local item = self._voiceItemObjList[i]

		item:setActive(false)
	end
end

function SettingsRoleVoiceView:_getVoiceItemList()
	self._tmpVoiceItemList = self._tmpVoiceItemList or self:_voiceItemList()

	return self._tmpVoiceItemList
end

function SettingsRoleVoiceView:_voiceItemList()
	if not self.viewParam then
		return self:_getVoiceItemDataList()
	end

	return self.viewParam.voiceItemList or self:_getVoiceItemDataList()
end

function SettingsRoleVoiceView:_getVoiceItemDataList()
	local list = {}
	local supportLangList = SettingsVoicePackageModel.instance:getSupportVoiceLangs()

	for i = 1, #supportLangList do
		local shortcutLangStr = supportLangList[i]
		local packInfo = SettingsVoicePackageModel.instance:getPackInfo(shortcutLangStr)
		local available = packInfo and not packInfo:needDownload() or false

		table.insert(list, {
			lang = shortcutLangStr,
			langId = LangSettings.shortCut2LangIdxTab[shortcutLangStr],
			available = available
		})
	end

	return list
end

function SettingsRoleVoiceView:_create_SettingsRoleVoiceViewLangBtn()
	local itemClass = SettingsRoleVoiceViewLangBtn
	local go = gohelper.cloneInPlace(self._golangoverseas, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, {
		parent = self,
		baseViewContainer = self.viewContainer
	})
end

function SettingsRoleVoiceView:setcurSelectLang(langId)
	self._curSelectLang = langId or 0

	for _, item in ipairs(self._voiceItemObjList or {}) do
		item:refreshSelected(langId)
	end
end

function SettingsRoleVoiceView:_refreshLangOptionSelectState_overseas(langId, active)
	for _, item in ipairs(self._voiceItemObjList or {}) do
		item:refreshLangOptionSelectState(langId, active)
	end
end

function SettingsRoleVoiceView:_refreshLangMode_overseas(langId)
	if not self._selectedCharMos or #self._selectedCharMos == 0 then
		return
	end

	for _, item in ipairs(self._voiceItemObjList or {}) do
		local heroId = self._selectedCharMos[1].heroId
		local isIn = SettingsRoleVoiceModel.instance:isHeroSp01(heroId)

		item:refreshLangMode(langId, (not isIn and (item:getLangId() == LangSettings.jp or item:getLangId() == LangSettings.kr) or nil) and false)
	end
end

function SettingsRoleVoiceView:afterSelectedNewLang()
	if not self._batchEditMode then
		local voiceValue = SettingsModel.instance:getVoiceValue()

		self:_refreshLangOptionSelectState(self._curSelectLang, voiceValue == 0)
		self:_playGreetingVoice()
	else
		self:_refreshLangOptionSelectState(self._curSelectLang, true)
	end
end

function SettingsRoleVoiceView:onInitView()
	self._golangoverseas = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang_overseas")
	self._voiceItemObjList = {}

	self:_refreshVoiceItemList()

	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._goops = gohelper.findChild(self.viewGO, "characterinfo/#go_ops")
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._langInfoAnimator = gohelper.onceAddComponent(self._gocharacterinfo, gohelper.Type_Animator)
	self._selectCharInfoAnimator = gohelper.onceAddComponent(self._gononecharacter, gohelper.Type_Animator)
	self._btnbatchedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit")
	self._btnselectall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	self._gobatcheditUnSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn1")
	self._gobatcheditSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn2")
	self._goselectAllBtn = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	self._goselectAllUnSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn1")
	self._goselectAllSelected = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn2")
	self._btnCN = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/click")
	self._btnEN = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/click")
	self._goCNUnSelected = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/unselected")
	self._goCNSelected = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected")
	self._goCNSelectPoint = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected/point")
	self._goENUnSelected = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/unselected")
	self._goENSelected = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected")
	self._goENSelectPoint = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected/point")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_ops/#btn_cancel")
	self._txtchoose = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/#txt_choose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsRoleVoiceView:addEvents()
	self._btnbatchedit:AddClickListener(self._btnbatcheditOnClick, self)
	self._btnselectall:AddClickListener(self._btnselectallOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnCN:AddClickListener(self._btnCNOnClick, self)
	self._btnEN:AddClickListener(self._btnENOnClick, self)
end

function SettingsRoleVoiceView:removeEvents()
	self._btnbatchedit:RemoveClickListener()
	self._btnselectall:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnCN:RemoveClickListener()
	self._btnEN:RemoveClickListener()
end

function SettingsRoleVoiceView:_btnbatcheditOnClick()
	self._batchEditMode = not self._batchEditMode

	gohelper.setActive(self._gobatcheditUnSelected, not self._batchEditMode)
	gohelper.setActive(self._gobatcheditSelected, self._batchEditMode)
	gohelper.setActive(self._goselectAllBtn, self._batchEditMode)

	if not self._batchEditMode then
		self._selectAll = false

		self:_refreshAllBtnState()
	end

	self.viewContainer:clearSelectedItems()

	if not self._voiceEnd then
		self:_stopVoice()
	end

	self:_onSelectedChar(false, false)
	self.viewContainer:setBatchEditMode(self._batchEditMode)
end

function SettingsRoleVoiceView:_btnselectallOnClick()
	self._selectAll = not self._selectAll

	if self._selectAll then
		self.viewContainer:selectedAllItems()

		local allItemMos = CharacterBackpackCardListModel.instance:getCharacterCardList()

		for idx, mo in ipairs(allItemMos) do
			self._selectedCharMos[#self._selectedCharMos + 1] = mo
		end

		self:_refreshOptionView(#self._selectedCharMos > 0)
	else
		self.viewContainer:clearSelectedItems()
		self:_onSelectedChar(false, false)
	end

	self:_refreshAllBtnState()
end

function SettingsRoleVoiceView:_btnCNOnClick()
	if self._curSelectLang == LangSettings.zh then
		return
	end

	local curSelectLangStr = LangSettings.shortcutTab[LangSettings.zh]
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curSelectLangStr)

	if packInfo and packInfo:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	self._curSelectLang = LangSettings.zh

	self:_refreshLangMode(self._curSelectLang)

	if not self._batchEditMode then
		local voiceValue = SettingsModel.instance:getVoiceValue()

		self:_refreshLangOptionSelectState(self._curSelectLang, voiceValue == 0)
		self:_playGreetingVoice()
	else
		self:_refreshLangOptionSelectState(self._curSelectLang, true)
	end
end

function SettingsRoleVoiceView:_btnENOnClick()
	if self._curSelectLang == LangSettings.en then
		return
	end

	local curSelectLangStr = LangSettings.shortcutTab[LangSettings.en]
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curSelectLangStr)

	if packInfo and packInfo:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	self._curSelectLang = LangSettings.en

	self:_refreshLangMode(self._curSelectLang)

	if not self._batchEditMode then
		local voiceValue = SettingsModel.instance:getVoiceValue()

		self:_refreshLangOptionSelectState(self._curSelectLang, voiceValue == 0)
		self:_playGreetingVoice()
	else
		self:_refreshLangOptionSelectState(self._curSelectLang, true)
	end
end

function SettingsRoleVoiceView:_btnconfirmOnClick()
	local hasChanged = false

	if self._curSelectLang == 0 then
		hasChanged = false
	else
		for _, charMo in ipairs(self._selectedCharMos) do
			local heroId = charMo.heroId
			local langId, langStr = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)

			if self._curSelectLang ~= langId then
				hasChanged = true

				break
			end
		end
	end

	if hasChanged then
		SettingsRoleVoiceController.instance:setCharVoiceLangPrefValue(self._selectedCharMos, self._curSelectLang)
	end

	self.viewContainer:clearSelectedItems()
	self:_onSelectedChar(false, false)
end

function SettingsRoleVoiceView:_btncancelOnClick()
	self.viewContainer:clearSelectedItems()
	self:_onSelectedChar(false, false)
end

function SettingsRoleVoiceView:_editableInitView()
	self._voiceEnd = true
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_redlight")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
	gohelper.setActive(self._gocharacterinfo, false)
end

function SettingsRoleVoiceView:onOpen()
	self.addEventCb(self, SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleSelected, self._onSelectedChar, self)
	self.addEventCb(self, SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleFiltered, self._onCharFiltered, self)
	self:_refreshOptionView(false)
	self:_refreshBtnStateView(false, false)
	self:_refreshLangOptionDownloadState(LangSettings.zh, self._goCNUnSelected)
	self:_refreshLangOptionDownloadState(LangSettings.en, self._goENUnSelected)
end

function SettingsRoleVoiceView:onClose()
	GameUtil.onDestroyViewMemberList(self, "_voiceItemObjList")

	if not self._voiceEnd then
		self:_stopVoice()
	end

	TaskDispatcher.cancelTask(self._playVoice, self)
end

function SettingsRoleVoiceView:onDestroyView()
	return
end

function SettingsRoleVoiceView:_onSelectedChar(charMo, selected)
	if self._selectAll and not selected then
		self._selectAll = false

		self:_refreshAllBtnState()
	end

	if self._batchEditMode then
		if not charMo then
			self._selectedCharMos = {}

			self:setcurSelectLang(0)
		elseif selected then
			self._selectedCharMos = self._selectedCharMos or {}

			if #self._selectedCharMos == 0 then
				self:setcurSelectLang(0)
			end

			self._selectedCharMos[#self._selectedCharMos + 1] = charMo
		else
			tabletool.removeValue(self._selectedCharMos, charMo)
		end
	else
		self._selectedCharMos = selected and {
			charMo
		} or {}

		if not selected and not self._voiceEnd then
			self:_stopVoice()
		end
	end

	self:_refreshOptionView(#self._selectedCharMos > 0)
end

function SettingsRoleVoiceView:_onCharFiltered()
	if not self._voiceEnd then
		self:_stopVoice()
	end

	self.viewContainer:clearSelectedItems()
	self:_onSelectedChar(false, false)
end

function SettingsRoleVoiceView:_refreshOptionView(selected)
	if selected then
		gohelper.setActive(self._gocharacterinfo, true)

		local var_25_0

		if selected then
			var_25_0 = UIAnimationName.Open or UIAnimationName.Close
		end
	end

	self._langInfoAnimator:Play(var_25_0)
	self._selectCharInfoAnimator:Play((selected or nil) and (UIAnimationName.Close or UIAnimationName.Open))
	gohelper.setActive(self._goops, selected)
	gohelper.setActive(self._gononecharacter, not selected)

	if self._batchEditMode then
		self._txtchoose.text = luaLang("p_herovoiceedityiew_selectcharlistlang")

		self:_refreshLangMode(self._curSelectLang)
	elseif selected then
		self._curSelectLang = 0

		for _, charMo in ipairs(self._selectedCharMos) do
			if #self._selectedCharMos == 1 then
				local heroId = charMo.heroId
				local langId, langStr = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)

				self._curSelectLang = langId
			end
		end

		self:setcurSelectLang(self._curSelectLang)

		local charMo = self._selectedCharMos[1]

		self._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_herovoiceeditview_selectcharlang"), {
			charMo.config.name
		})

		local voiceValue = SettingsModel.instance:getVoiceValue()

		self:_refreshLangOptionSelectState(self._curSelectLang, voiceValue == 0)
		self:_playGreetingVoice()
		self:_refreshLangMode(self._curSelectLang)
	end
end

function SettingsRoleVoiceView:_refreshBtnStateView(batchEdit, selectAll)
	gohelper.setActive(self._gobatcheditUnSelected, not batchEdit)
	gohelper.setActive(self._gobatcheditSelected, batchEdit)
	gohelper.setActive(self._goselectAllBtn, batchEdit)
	gohelper.setActive(self._goselectAllSelected, selectAll)
	gohelper.setActive(self._goselectAllUnSelected, not selectAll)
end

function SettingsRoleVoiceView:_refreshLangMode(langId)
	do return self:_refreshLangMode_overseas(langId) end

	gohelper.setActive(self._goCNUnSelected, langId ~= LangSettings.zh)
	gohelper.setActive(self._goCNSelected, langId == LangSettings.zh)
	gohelper.setActive(self._goENUnSelected, langId ~= LangSettings.en)
	gohelper.setActive(self._goENSelected, langId == LangSettings.en)
end

function SettingsRoleVoiceView:_refreshAllBtnState()
	gohelper.setActive(self._goselectAllSelected, self._selectAll)
	gohelper.setActive(self._goselectAllUnSelected, not self._selectAll)
end

function SettingsRoleVoiceView:_refreshLangOptionSelectState(langId, active)
	do return self:_refreshLangOptionSelectState_overseas(langId, active) end

	if langId == LangSettings.en then
		gohelper.setActive(self._goENSelectPoint, active)
	elseif langId == LangSettings.zh then
		gohelper.setActive(self._goCNSelectPoint, active)
	end
end

function SettingsRoleVoiceView:_refreshLangOptionDownloadState(langId, btnGo)
	local curSelectLangStr = LangSettings.shortcutTab[langId]
	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(curSelectLangStr)

	if packInfo and packInfo:needDownload() then
		local optionText = gohelper.findChildText(btnGo, "info1")
		local optionPoint = gohelper.findChildImage(btnGo, "point")

		optionText.alpha = 0.4

		local color = optionPoint.color

		color.a = 0.4
		optionPoint.color = color
	end
end

function SettingsRoleVoiceView:isBatchEditMode()
	return self._batchEditMode
end

function SettingsRoleVoiceView:_playVoice()
	local lang = LangSettings.shortcutTab[self._curSelectLang]
	local emitter = self:_getVoiceEmitter()

	if not self._voiceEnd then
		self:_stopVoice()

		self._voiceEarlyStop = true

		TaskDispatcher.runDelay(self._playVoice, self, 0.33)
	else
		local audioCfg = AudioConfig.instance:getAudioCOById(self._curVoiceCfg.audio)

		self._voiceBnkName = audioCfg.bankName
		self._voiceEnd = false

		ZProj.AudioManager.Instance:LoadBank(self._voiceBnkName, lang)
		emitter:Emitter(self._curVoiceCfg.audio, lang, self._onEmitterCallback, self)
		ZProj.AudioManager.Instance:UnloadBank(self._voiceBnkName)
	end
end

function SettingsRoleVoiceView:_playGreetingVoice()
	if self._selectedCharMos and #self._selectedCharMos == 1 then
		local voiceCfgs = CharacterDataConfig.instance:getCharacterVoicesCo(self._selectedCharMos[1].heroId)
		local charSkinId = self._selectedCharMos[1].skin
		local greetingVoiceCfg, noSkinIdVoiceCfg

		for _, cfg in pairs(voiceCfgs) do
			if cfg.type == CharacterEnum.VoiceType.Greeting then
				local skins = cfg.skins

				if not skins or string.nilorempty(skins) then
					noSkinIdVoiceCfg = cfg
				else
					local skinList = string.splitToNumber(skins, "#")

					for _, skinId in ipairs(skinList) do
						if skinId == charSkinId then
							greetingVoiceCfg = cfg

							break
						end
					end
				end

				if greetingVoiceCfg then
					break
				end
			end
		end

		self._curVoiceCfg = greetingVoiceCfg and greetingVoiceCfg or noSkinIdVoiceCfg

		self:_playVoice()
	end
end

function SettingsRoleVoiceView:_stopVoice()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)

	self._voiceEnd = true

	self:_unloadBnk()
end

function SettingsRoleVoiceView:_getVoiceEmitter()
	self._emitter = self._emitter or ZProj.AudioEmitter.Get(self.viewGO)

	return self._emitter
end

function SettingsRoleVoiceView:_onEmitterCallback(callbackType, value)
	if callbackType == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
		self:_emitterVoiceEnd()
	end
end

function SettingsRoleVoiceView:_emitterVoiceEnd()
	if self._voiceEarlyStop then
		self._voiceEarlyStop = false
	else
		self._voiceEnd = true

		self:_unloadBnk()
		self:_refreshLangOptionSelectState(self._curSelectLang, true)
	end
end

function SettingsRoleVoiceView:_unloadBnk()
	if self._voiceBnkName then
		ZProj.AudioManager.Instance:UnloadBank(self._voiceBnkName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

return SettingsRoleVoiceView
