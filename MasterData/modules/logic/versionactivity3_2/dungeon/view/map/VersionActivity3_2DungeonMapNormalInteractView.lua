-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapNormalInteractView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapNormalInteractView", package.seeall)

local VersionActivity3_2DungeonMapNormalInteractView = class("VersionActivity3_2DungeonMapNormalInteractView", BaseViewExtended)

function VersionActivity3_2DungeonMapNormalInteractView:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self._gointeractitem, "#btn_close")
	self._txttitle = gohelper.findChildText(self._gointeractitem, "rotate/#go_title/#txt_title")
	self._simagedescbg = gohelper.findChildSingleImage(self._gointeractitem, "rotate/desc_container/#simage_descbg")
	self._txtdesc = gohelper.findChildText(self._gointeractitem, "rotate/desc_container/#txt_desc")
	self._godesc = self._txtdesc.gameObject
	self._gochat = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	self._gochatusericon = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/usericon")
	self._txtchatname = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/name")
	self._txtchatdesc = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/info")
	self.goRewardContainer = gohelper.findChild(self._gointeractitem, "rotate/reward_container")
	self.goRewardContent = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent")
	self.goRewardItem = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	self:initNoneContainer()
	self:initFightContainer()
	self:initDialogueContainer()
	self:initTalkContainer()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:initNoneContainer()
	self.goNone = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_none")
	self.txtNone = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_none/#txt_none")
	self.noneBtn = gohelper.findButtonWithAudio(self.goNone)
end

function VersionActivity3_2DungeonMapNormalInteractView:initFightContainer()
	self.goFight = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight")
	self.goFightTip = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip")
	self.txtRemainFightNumber = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/#txt_remainfightnumber")
	self.fightTipClickArea = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/clickarea")
	self.txtFight = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#txt_fight")
	self.goFightCost = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost")
	self.txtFightCost = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#txt_cost")
	self.simageCostIcon = gohelper.findChildSingleImage(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#simage_costicon")
	self.fightBtn = gohelper.findButtonWithAudio(self.goFight)
end

function VersionActivity3_2DungeonMapNormalInteractView:initDialogueContainer()
	self.goDialogue = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_dialogue")
	self.txtDialogue = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	self.enterDialogueBtn = gohelper.findButtonWithAudio(self.goDialogue)
end

function VersionActivity3_2DungeonMapNormalInteractView:initTalkContainer()
	self.goTalk = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk")
	self._gonext = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self._gointeractitem, "rotate/option_container/#go_talk/#go_next/#btn_next")
	self._gooptions = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_options")
	self._gotalkitem = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_options/#go_talkitem")

	gohelper.setActive(self._gotalkitem, false)

	self._gofinishtalk = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk")
	self._btnfinishtalk = gohelper.findChildButtonWithAudio(self._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk/#btn_finishtalk")
end

function VersionActivity3_2DungeonMapNormalInteractView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.noneBtn:AddClickListener(self._onClickNoneBtn, self)
	self.fightBtn:AddClickListener(self._onClickFightBtn, self)
	self.enterDialogueBtn:AddClickListener(self._onClickEnterDialogueBtn, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfinishtalk:AddClickListener(self._btnfinishtalkOnClick, self)
	self.addEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self.showInteractUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	self.addEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.beforeJump, self)
end

function VersionActivity3_2DungeonMapNormalInteractView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.noneBtn:RemoveClickListener()
	self.fightBtn:RemoveClickListener()
	self.enterDialogueBtn:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfinishtalk:RemoveClickListener()
	self.removeEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self.showInteractUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	self.removeEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.removeEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.beforeJump, self)
end

function VersionActivity3_2DungeonMapNormalInteractView:_editableInitView()
	self._handleTypeMap = {
		[DungeonEnum.ElementType.None] = self.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = self.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = self.refreshDialogueUI,
		[DungeonEnum.ElementType.Story] = self.refreshTalkUI
	}
	self.type2goDict = {
		[DungeonEnum.ElementType.None] = self.goNone,
		[DungeonEnum.ElementType.Fight] = self.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = self.goDialogue,
		[DungeonEnum.ElementType.Story] = self.goTalk
	}
	self.rewardItemList = {}
	self._optionBtnList = self:getUserDataTb_()
	self.mapSceneElementsView = self.viewContainer.mapSceneElements
	self.rootClick = gohelper.findChildClickWithDefaultAudio(self._gointeractroot, "close_block")

	self.rootClick:AddClickListener(self.onClickRoot, self)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	gohelper.setActive(self.goRewardItem, false)
end

function VersionActivity3_2DungeonMapNormalInteractView:showInteractUI(mapElement)
	if self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(true)

	self._mapElement = mapElement
	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go
	self.isFinish = false
	self._isRecheck = false

	self:show()
	self:refreshUI()
end

function VersionActivity3_2DungeonMapNormalInteractView:onRecheck(elementCo)
	if self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(true)

	self._config = elementCo
	self.isFinish = false
	self._isRecheck = true

	self:show()
	self:refreshUI()
end

function VersionActivity3_2DungeonMapNormalInteractView:show()
	if self._show then
		return
	end

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function VersionActivity3_2DungeonMapNormalInteractView:hide()
	if not self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	self._show = false
	self.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)

	if self._isRecheck and not self.isFinish then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshUI()
	self._rawType = self._config.type

	local type = self._config.type

	if type == DungeonEnum.ElementType.V3a2Note then
		type = DungeonEnum.ElementType.None
	end

	for t, go in pairs(self.type2goDict) do
		gohelper.setActive(go, t == type)
	end

	self._txttitle.text = self._config.title

	local handleFunc = self._handleTypeMap[type]

	if handleFunc then
		handleFunc(self)
	else
		logError("element type undefined!")
	end

	self:refreshRewards()
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshRewards()
	local rewardStr = self._config.reward

	if string.nilorempty(rewardStr) then
		gohelper.setActive(self.goRewardContainer, false)

		return
	end

	gohelper.setActive(self.goRewardContainer, true)

	local rewardList = GameUtil.splitString2(rewardStr, true)

	for index, reward in ipairs(rewardList) do
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = self:createRewardItem()

			table.insert(self.rewardItemList, rewardItem)
		end

		gohelper.setActive(rewardItem.go, true)
		rewardItem.icon:isShowCount(false)
		rewardItem.icon:setMOValue(reward[1], reward[2], reward[3])

		rewardItem.txtCount.text = reward[3]
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:createRewardItem()
	local rewardItem = self:getUserDataTb_()

	rewardItem.go = gohelper.cloneInPlace(self.goRewardItem)
	rewardItem.goIcon = gohelper.findChild(rewardItem.go, "itemicon")
	rewardItem.goCount = gohelper.findChild(rewardItem.go, "countbg")
	rewardItem.txtCount = gohelper.findChildText(rewardItem.go, "countbg/count")
	rewardItem.goRare = gohelper.findChild(rewardItem.go, "rare")
	rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

	gohelper.setActive(rewardItem.goRare, false)

	return rewardItem
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshNoneUI()
	self.txtNone.text = self._config.acceptText
	self._txtdesc.text = self._config.desc

	self:setIsChat(false)
end

function VersionActivity3_2DungeonMapNormalInteractView:setFinishText()
	local finishText = self._config.finishText

	self._txtdesc.text = string.nilorempty(finishText) and self._config.desc or finishText
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshFightUI()
	local episodeId = tonumber(self._config.param)

	self.isFinish = DungeonModel.instance:hasPassLevel(episodeId)

	if self.isFinish and not self._isRecheck then
		self.txtFight.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtFight.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end

	self:setIsChat(false)
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshDialogueUI()
	self.dialogueId = tonumber(self._config.param)
	self.isFinish = DialogueModel.instance:isFinishDialogue(self.dialogueId)

	if self.isFinish and not self._isRecheck then
		self.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtDialogue.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end

	self:setIsChat(false)
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshTalkUI()
	self._sectionStack = {}
	self._dialogId = tonumber(self._config.param)

	self:_playSection(0)
end

function VersionActivity3_2DungeonMapNormalInteractView:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function VersionActivity3_2DungeonMapNormalInteractView:_setSectionData(sectionId, dialogIndex)
	self._sectionList = DungeonConfig.instance:getDialog(self._dialogId, sectionId)
	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function VersionActivity3_2DungeonMapNormalInteractView:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	self._dialogIndex = self._dialogIndex + 1

	if config.type == "dialog" then
		self:_showDialog("dialog", config.content, config.speaker, config.audio)
	end

	if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
		local prevSectionInfo = table.remove(self._sectionStack)

		self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
	end

	local showOption = false
	local nextConfig = self._sectionList[self._dialogIndex]

	if nextConfig and nextConfig.type == "options" then
		self._dialogIndex = self._dialogIndex + 1

		for _, v in pairs(self._optionBtnList) do
			gohelper.setActive(v[1], false)
		end

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		for i, v in ipairs(optionList) do
			self:_addDialogOption(i, sectionIdList[i], v)
		end

		showOption = true
	end

	local hasNext = not nextConfig or nextConfig.type ~= "dialogend"

	self:_refreshDialogBtnState(showOption, hasNext)
end

function VersionActivity3_2DungeonMapNormalInteractView:_showDialog(type, text, speaker, audio)
	DungeonMapModel.instance:addDialog(type, text, speaker, audio)
	gohelper.setActive(self._gochatusericon, not speaker)

	local hasSpeaker = not string.nilorempty(speaker)

	if hasSpeaker then
		self._txtchatname.text = speaker .. ":" or ""
	end

	self._txtchatdesc.text = text

	self:setIsChat(true)
end

function VersionActivity3_2DungeonMapNormalInteractView:setIsChat(isChat)
	gohelper.setActive(self._godesc, not isChat)
	gohelper.setActive(self._gochat, isChat)
end

function VersionActivity3_2DungeonMapNormalInteractView:_addDialogOption(index, sectionId, text)
	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local optionGo = gohelper.cloneInPlace(self._gotalkitem)

			gohelper.setActive(optionGo, true)

			local optionTxt = gohelper.findChildText(optionGo, "txt_talkitem")

			optionTxt.text = text

			local btnOption = gohelper.findChildButtonWithAudio(optionGo, "btn_talkitem")

			btnOption:AddClickListener(self._onOptionClick, self, {
				sectionId,
				text
			})

			if not self._optionBtnList[index] then
				local btnItem = self:getUserDataTb_()

				btnItem[1] = optionGo
				btnItem[2] = btnOption
				self._optionBtnList[index] = btnItem
			end
		end
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:_onOptionClick(param)
	local sectionId = param[1]
	local text = string.format("<color=#c95318>\"%s\"</color>", param[2])

	self:_showDialog("option", text)

	if #self._sectionList >= self._dialogIndex then
		table.insert(self._sectionStack, {
			self._sectionId,
			self._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(sectionId)
	self:_playSection(sectionId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivity3_2DungeonMapNormalInteractView:_refreshDialogBtnState(showOption, hasNext)
	gohelper.setActive(self._gooptions, showOption)

	if showOption then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(self._gonext, false)
		gohelper.setActive(self._gofinishtalk, false)

		self._curBtnGo = self._gooptions

		return
	end

	hasNext = hasNext and (#self._sectionStack > 0 or #self._sectionList >= self._dialogIndex)

	if hasNext then
		self._curBtnGo = self._gonext

		gohelper.setActive(self._gonext, hasNext)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		self._curBtnGo = self._gofinishtalk
	end

	gohelper.setActive(self._gonext, hasNext)
	gohelper.setActive(self._gofinishtalk, not hasNext)
end

function VersionActivity3_2DungeonMapNormalInteractView:onClickRoot()
	self:hide()

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:_btncloseOnClick()
	self:hide()

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:_onClickNoneBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	self:finishElement()
end

function VersionActivity3_2DungeonMapNormalInteractView:_onClickFightBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if self.isFinish then
		self:finishElement()

		return
	end

	local episodeId = tonumber(self._config.param)

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not config then
		logError("episode config not exist , episodeId : " .. tostring(episodeId))

		return
	end

	VersionActivityFixedDungeonModel.instance:setLastEpisodeId(self.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function VersionActivity3_2DungeonMapNormalInteractView:_onClickEnterDialogueBtn()
	if self.isFinish and not self._isRecheck then
		self:hide()
		self:finishElement()

		return
	end

	gohelper.setActive(self._gointeractroot, false)
	DialogueController.instance:enterDialogue(self.dialogueId, function()
		if self._isRecheck then
			self:hide()
			DungeonController.instance:onAgainOpenRecheckView(self._config.id)
		else
			gohelper.setActive(self._gointeractroot, true)
		end
	end)
end

function VersionActivity3_2DungeonMapNormalInteractView:finishElement(dialogIds)
	local elementId = self._config.id

	DungeonMapModel.instance:addFinishedElement(elementId)
	DungeonMapModel.instance:removeElement(elementId)

	if self._isRecheck then
		DungeonController.instance:onRecheckFragmentInfoView(self._config)
	elseif self._rawType == DungeonEnum.ElementType.V3a2Note then
		local record = ServerTime.now()

		DungeonRpc.instance:sendMapElementWithRecordRequest(elementId, dialogIds, tostring(record), self.refreshElement, self)
	else
		DungeonRpc.instance:sendMapElementRequest(elementId, dialogIds, self.refreshElement, self)
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:refreshElement()
	return
end

function VersionActivity3_2DungeonMapNormalInteractView:_btnnextOnClick()
	self:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivity3_2DungeonMapNormalInteractView:_playNextSectionOrDialog()
	if #self._sectionList >= self._dialogIndex then
		self:_playNextDialog()

		return
	end

	local prevSectionInfo = table.remove(self._sectionStack)

	if not prevSectionInfo then
		return
	end

	self:_playSection(prevSectionInfo[1], prevSectionInfo[2])
end

function VersionActivity3_2DungeonMapNormalInteractView:_btnfinishtalkOnClick()
	self:hide()

	local dialogIds = DungeonMapModel.instance:getDialogId()

	self:finishElement(dialogIds)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivity3_2DungeonMapNormalInteractView:onDialogueInfoChange(dialogueId)
	if dialogueId == self.dialogueId then
		self:refreshDialogueUI()
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:onCloseViewFinishCall(viewName)
	if viewName == ViewName.DialogueView and self.isFinish then
		self:refreshUI()
	end
end

function VersionActivity3_2DungeonMapNormalInteractView:beforeJump()
	self:hide()
end

function VersionActivity3_2DungeonMapNormalInteractView:onClose()
	return
end

function VersionActivity3_2DungeonMapNormalInteractView:onDestroyView()
	self.rootClick:RemoveClickListener()
end

return VersionActivity3_2DungeonMapNormalInteractView
