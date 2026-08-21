-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/panelview/LeaveMsgPanel.lua

module("logic.extensions.leavemsg.panelview.LeaveMsgPanel", package.seeall)

local M = class("LeaveMsgPanel")

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._btnReset = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_1553723755"))
	self._btnSave = UIComponentType.ButtonAdapter(registry:findUIElement("2&btn_middle_-31477526"))
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(registry:findUIElement("message_panel_893996442", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(registry:findUIElement("message_panel_-263973292", UIComponentType.SpaceXToggle))

	self._goPanel = {
		[LeaveMsgEnum.MsgType.Word] = registry:findUIElement("message_panel_23588631"),
		[LeaveMsgEnum.MsgType.Voice] = registry:findUIElement("message_panel_1290313819")
	}
	self._btnSubject1 = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_-17392861"))
	self._txtSubject1 = registry:findUIElement("message_panel_-812733767", UIComponentType.TextMeshProUGUI)
	self._btnWord1 = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_415047792"))
	self._txtWord1 = registry:findUIElement("message_panel_-1822927190", UIComponentType.TextMeshProUGUI)
	self._btnAddDialogue = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_1144058806"))
	self._goDialogue2 = registry:findUIElement("message_panel_1376072566")
	self._btnConjunction = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_-2002453108"))
	self._txtConjunction = registry:findUIElement("message_panel_-223002240", UIComponentType.TextMeshProUGUI)
	self._btnSubject2 = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_1786607310"))
	self._txtSubject2 = registry:findUIElement("message_panel_1654731126", UIComponentType.TextMeshProUGUI)
	self._btnWord2 = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_929480988"))
	self._txtWord2 = registry:findUIElement("message_panel_242706206", UIComponentType.TextMeshProUGUI)
	self._btnVoiceHero = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_-1676248603"))
	self._txtVoiceHero = registry:findUIElement("message_panel_-1183476807", UIComponentType.TextMeshProUGUI)
	self._btnVoiceRes = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_-1542493491"))
	self._txtVoiceRes = registry:findUIElement("message_panel_1968745156", UIComponentType.TextMeshProUGUI)
	self._goPanelEmojiRoot = goutil.findChild(mainGO, "msgItem6").gameObject
	self._btnEmoji = UIComponentType.ButtonAdapter(registry:findUIElement("message_panel_-1532945029"))
	self._goNoneEmoji = registry:findUIElement("message_panel_1189938949")
	self._imgEmoji = registry:findUIElement("message_panel_1085194026", UIComponentType.Image)
end

function M:destroyUI()
	self._activeIndex = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:bindEvents()
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnSubject1:AddClickListener(self._onClickSubject1, self)
	self._btnWord1:AddClickListener(self._onClickWord1, self)
	self._btnAddDialogue:AddClickListener(self._onClickAddDialogue, self)
	self._btnConjunction:AddClickListener(self._onClickConjunction, self)
	self._btnSubject2:AddClickListener(self._onClickSubject2, self)
	self._btnWord2:AddClickListener(self._onClickWord2, self)
	self._btnVoiceHero:AddClickListener(self._onClickVoiceHero, self)
	self._btnVoiceRes:AddClickListener(self._onClickVoiceRes, self)
	self._btnEmoji:AddClickListener(self._onClickEmoji, self)
	self:setEvent(true)
end

function M:unbindEvents()
	self._btnReset:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnSubject1:RemoveClickListener()
	self._btnWord1:RemoveClickListener()
	self._btnAddDialogue:RemoveClickListener()
	self._btnConjunction:RemoveClickListener()
	self._btnSubject2:RemoveClickListener()
	self._btnWord2:RemoveClickListener()
	self._btnVoiceHero:RemoveClickListener()
	self._btnVoiceRes:RemoveClickListener()
	self._btnEmoji:RemoveClickListener()
	self:setClickSaveFunction(nil, nil)
	self:setClickResetFunction(nil, nil)
	self:setEvent(false)
end

function M:onEnter(isNormal)
	return
end

function M:onExit(isNormal)
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
	else
		GlobalDispatcher:removeEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
	end
end

function M:_handleEditAllPreview(e, isAllFinish, previewStr, emoji)
	local context = self:getContext()
	local textPartCount = context:getParagraphCount()

	goutil.setActive(self._btnAddDialogue.gameObject, textPartCount <= 1)
	goutil.setActive(self._goDialogue2, textPartCount > 1)
	self:refreshSubView()
end

function M:setEmojiRootShow(show)
	goutil.setActive(self._goPanelEmojiRoot, show)
end

function M:setContext(data)
	if data then
		self._context = data
	else
		self._context = LeaveMsgMO.New()
	end

	local context = self:getContext()
	local textPartCount = context:getParagraphCount()

	goutil.setActive(self._btnAddDialogue.gameObject, textPartCount <= 1)
	goutil.setActive(self._goDialogue2, textPartCount > 1)

	local pageType = context:getPageType()

	pageType = pageType or context:getVoice() > 0 and LeaveMsgEnum.MsgType.Voice or LeaveMsgEnum.MsgType.Word

	if pageType == self._activeIndex then
		self._activeIndex = nil
	end

	self:selectTab(pageType)
end

function M:getContext()
	return self._context
end

function M:getPreviewMsg(split, emptyMarkColor)
	if self._context then
		return self._context:getPreviewMsg(split, emptyMarkColor)
	end
end

function M:setClickSaveFunction(fun, handler)
	self._clickSaveFunc = fun
	self._clickSaveHandler = handler
end

function M:setClickResetFunction(fun, handler)
	self._clickResetFunc = fun
	self._clickResetHandler = handler
end

function M:getPageType()
	local context = self:getContext()

	return context:getPageType()
end

function M:getCurPageVoice()
	if self:getPageType() == LeaveMsgEnum.MsgType.Voice then
		return self:getContext():getVoice()
	else
		return nil
	end
end

function M:playVoice()
	local voice = self:getCurPageVoice()

	if voice and voice > 0 then
		self:getContext():playVoice()
	end
end

function M:selectTab(tab)
	tab = tab or LeaveMsgEnum.MsgType.Word

	self._toggleTabControl:selectTab(tab)
end

function M:getTabIndex()
	return self._activeIndex
end

function M:setPage(tabIndex)
	local context = self:getContext()
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	context:setPageType(tabIndex)

	if needReflash then
		for _type, go in pairs(self._goPanel) do
			goutil.setActive(go, _type == self._activeIndex)
		end

		self:refreshSubView()
		context:dispatchCurPreview()
	end
end

function M:refreshSubView()
	local context = self:getContext()
	local pageType = context:getPageType()

	if pageType == LeaveMsgEnum.MsgType.Word then
		self:refreshViewWord()
	elseif pageType == LeaveMsgEnum.MsgType.Voice then
		self:refreshViewVoice()
	end
end

function M:refreshViewWord()
	local context = self:getContext()

	self._txtSubject1.text = context:getMsgTabContent(1, LeaveMsgEnum.MsgPartType.Subject)
	self._txtWord1.text = context:getMsgTabContent(1, LeaveMsgEnum.MsgPartType.Word)
	self._txtConjunction.text = context:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Joiner)
	self._txtSubject2.text = context:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Subject)
	self._txtWord2.text = context:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Word)

	self:refreshEmoji()
end

function M:refreshViewVoice()
	local context = self:getContext()
	local voiceId = context:getVoice()
	local heroId = context:getVoiceHero()
	local heroName = "..."

	if heroId > 0 then
		heroId = heroId < 2000000 and heroId + 2000000 or heroId
		heroName = ContainmentUtil.getHeroName(heroId)
	end

	local voiceName = "..."

	if voiceId > 0 then
		local audioId = voiceId % 1000
		local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)

		voiceName = cfg and cfg.audioName or voiceName
	end

	self._txtVoiceHero.text = heroName
	self._txtVoiceRes.text = voiceName

	self:refreshEmoji()
end

function M:refreshEmoji()
	local context = self:getContext()
	local emoji = context:getEmoji()

	if not self._emojiId or self._emojiId and self._emojiId ~= emoji then
		goutil.setActive(self._goNoneEmoji, emoji <= 0)
		goutil.setActive(self._imgEmoji.gameObject, emoji > 0)

		if emoji > 0 then
			local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

			IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
		end
	end

	self._emojiId = emoji
end

function M:_onClickReset()
	if self._clickResetFunc then
		if self._clickResetHandler then
			self._clickResetFunc(self._clickResetHandler)
		else
			self._clickResetFunc()
		end
	end
end

function M:_onClickSave()
	if self._clickSaveFunc then
		local context = self:getContext()

		if self._clickSaveHandler then
			self._clickSaveFunc(self._clickSaveHandler, context)
		else
			self._clickSaveFunc(context)
		end
	end
end

function M:_onClickSubject1()
	ToolTipsMgr.showLeaveMsgSubjectTips(self:getContext(), 1)
end

function M:_onClickWord1()
	ToolTipsMgr.showLeaveMsgWordTips(self:getContext(), 1)
end

function M:_onClickAddDialogue()
	goutil.setActive(self._btnAddDialogue.gameObject, false)
	goutil.setActive(self._goDialogue2, true)
end

function M:_onClickConjunction()
	ToolTipsMgr.showLeaveMsgConjunctionTips(self:getContext())
end

function M:_onClickSubject2()
	ToolTipsMgr.showLeaveMsgSubjectTips(self:getContext(), 2)
end

function M:_onClickWord2()
	ToolTipsMgr.showLeaveMsgWordTips(self:getContext(), 2)
end

function M:_onClickVoiceHero()
	ToolTipsMgr.showLeaveMsgVoiceHeroTips(self:getContext())
end

function M:_onClickVoiceRes()
	local heroId = self._heroId

	ToolTipsMgr.showLeaveMsgVoiceResTips(self:getContext())
end

function M:_onClickEmoji()
	ToolTipsMgr.showLeaveMsgEmojiTips(self:getContext())
end

return M
