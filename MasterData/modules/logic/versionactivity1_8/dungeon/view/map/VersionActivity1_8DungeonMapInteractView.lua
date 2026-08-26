-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/VersionActivity1_8DungeonMapInteractView.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapInteractView", package.seeall)

local VersionActivity1_8DungeonMapInteractView = class("VersionActivity1_8DungeonMapInteractView", BaseView)

function VersionActivity1_8DungeonMapInteractView:onInitView()
	self._gointeractiveroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self.rootClick = gohelper.findChildClickWithDefaultAudio(self._gointeractiveroot, "close_block")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_interactive_root/#go_interactitem/#btn_close")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/#go_title/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#txt_desc")
	self._godesc = self._txtdesc.gameObject
	self._gochat = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	self._gochatusericon = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/usericon")
	self._txtchatname = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/name")
	self._txtchatdesc = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/info")
	self._gorewardcontainer = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent/#go_activityrewarditem")
	self._gonone = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none")
	self._btnnone = gohelper.findButtonWithAudio(self._gonone)
	self._txtnone = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none/#txt_none")
	self._gofight = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight")
	self._btnfight = gohelper.findButtonWithAudio(self._gofight)
	self._txtfight = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/#txt_fight")
	self._txtfighten = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/en")
	self._godispatch = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch")
	self._btndispatch = gohelper.findButtonWithAudio(self._godispatch)
	self._txtdispatch = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/#txt_dispatch")
	self._txtdispatchen = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/en")
	self._godialogue = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue")
	self._gonext = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next/#btn_next")
	self._gooptions = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options/#go_talkitem")

	gohelper.setActive(self._gotalkitem, false)

	self._gofinishtalk = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk")
	self._btnfinishtalk = gohelper.findChildButtonWithAudio(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk/#btn_finishtalk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapInteractView:addEvents()
	self.rootClick:AddClickListener(self.onClickRoot, self)
	self._btnclose:AddClickListener(self.onClickRoot, self)
	self._btnnone:AddClickListener(self._onClickNoneBtn, self)
	self._btnfight:AddClickListener(self._onClickFightBtn, self)
	self._btndispatch:AddClickListener(self._onClickDispatchBtn, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfinishtalk:AddClickListener(self._btnfinishtalkOnClick, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.onClickRoot, self)
	self.addEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.showInteractUI, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onDispatchInfoChange, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onDispatchInfoChange, self)
end

function VersionActivity1_8DungeonMapInteractView:removeEvents()
	self.rootClick:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnone:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btndispatch:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfinishtalk:RemoveClickListener()

	for _, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end

	self.removeEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.onClickRoot, self)
	self.removeEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.showInteractUI, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onDispatchInfoChange, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onDispatchInfoChange, self)
end

function VersionActivity1_8DungeonMapInteractView:onClickRoot()
	self:hide()

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity1_8DungeonMapInteractView:_onClickNoneBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	self:finishElement()
end

function VersionActivity1_8DungeonMapInteractView:_onClickFightBtn()
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

	VersionActivity1_8DungeonModel.instance:setLastEpisodeId(self.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function VersionActivity1_8DungeonMapInteractView:_onClickDispatchBtn()
	if self.isFinish then
		self:hide()
		self:finishElement()
	else
		local dungeonActId = VersionActivity1_8Enum.ActivityId.Dungeon
		local elementId = self._config.id
		local dispatchId = tonumber(self._config.param)

		DispatchController.instance:openDispatchView(dungeonActId, elementId, dispatchId)
	end
end

function VersionActivity1_8DungeonMapInteractView:finishElement(dialogIds)
	local elementId = self._config.id
	local actId = Activity157Model.instance:getActId()
	local act157MissionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

	if act157MissionId then
		::label_8_0::

		local storyId = Activity157Config.instance:getAct157MissionStoryId(actId, act157MissionId)

		if storyId and storyId ~= 0 then
			StoryController.instance:playStory(storyId, nil, function()
				VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(true)
				self:requestsFinishElement(elementId, dialogIds)
			end)
		else
			self:requestsFinishElement(elementId, dialogIds)
		end
	end
end

function VersionActivity1_8DungeonMapInteractView:requestsFinishElement(elementId, dialogIds)
	if self._isRecheck then
		DungeonController.instance:onRecheckFragmentInfoView(self._config)
	else
		DungeonRpc.instance:sendMapElementRequest(elementId, dialogIds, self.updateAct157Info, self)
	end
end

function VersionActivity1_8DungeonMapInteractView:updateAct157Info()
	Activity157Controller.instance:getAct157ActInfo()
end

function VersionActivity1_8DungeonMapInteractView:_btnnextOnClick()
	self:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivity1_8DungeonMapInteractView:_playNextSectionOrDialog()
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

function VersionActivity1_8DungeonMapInteractView:_btnfinishtalkOnClick()
	self:hide()

	local dialogIds = DungeonMapModel.instance:getDialogId()

	self:finishElement(dialogIds)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivity1_8DungeonMapInteractView:onDialogueInfoChange(dialogueId)
	if dialogueId == self.dialogueId then
		self:refreshDialogueUI()
	end
end

function VersionActivity1_8DungeonMapInteractView:showInteractUI(elementId)
	if self._show then
		return
	end

	self._isRecheck = false

	DungeonMapModel.instance:clearDialog()

	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	VersionActivity1_8DungeonModel.instance:setShowInteractView(true)

	self._mapElement = elementComp
	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go
	self.isFinish = false

	self:show()
	self:refreshUI()
end

function VersionActivity1_8DungeonMapInteractView:onRecheck(elementCo)
	if self._show then
		return
	end

	DungeonMapModel.instance:clearDialog()
	VersionActivity1_8DungeonModel.instance:setShowInteractView(true)

	self._config = elementCo
	self.isFinish = false
	self._isRecheck = true

	self:show()
	self:refreshUI()
end

function VersionActivity1_8DungeonMapInteractView:onDispatchInfoChange(dispatchId)
	self:refreshDispatchUI()
end

function VersionActivity1_8DungeonMapInteractView:_editableInitView()
	self.rewardItemList = {}
	self._optionBtnList = self:getUserDataTb_()
	self.mapSceneElementsView = self.viewContainer.mapSceneElements
	self.type2RefreshFunc = {
		[DungeonEnum.ElementType.None] = self.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = self.refreshFightUI,
		[DungeonEnum.ElementType.Story] = self.refreshDialogueUI,
		[DungeonEnum.ElementType.Dispatch] = self.refreshDispatchUI
	}
	self.type2GoDict = {
		[DungeonEnum.ElementType.None] = self._gonone,
		[DungeonEnum.ElementType.Fight] = self._gofight,
		[DungeonEnum.ElementType.Story] = self._godialogue,
		[DungeonEnum.ElementType.Dispatch] = self._godispatch
	}

	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractiveroot, false)
	gohelper.setActive(self._goactivityrewarditem, false)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivity1_8DungeonMapInteractView:onUpdateParam()
	return
end

function VersionActivity1_8DungeonMapInteractView:onOpen()
	return
end

function VersionActivity1_8DungeonMapInteractView:refreshUI()
	for type, go in pairs(self.type2GoDict) do
		gohelper.setActive(go, type == self._config.type)
	end

	self._txttitle.text = self._config.title

	local refreshFunc = self.type2RefreshFunc[self._config.type]

	if refreshFunc then
		refreshFunc(self)
	else
		logError("element type undefined!")
	end

	self:refreshRewards()
end

function VersionActivity1_8DungeonMapInteractView:setIsChat(isChat)
	gohelper.setActive(self._godesc, not isChat)
	gohelper.setActive(self._gochat, isChat)
end

function VersionActivity1_8DungeonMapInteractView:refreshNoneUI()
	self._txtnone.text = self._config.acceptText
	self._txtdesc.text = self._config.desc

	self:setIsChat(false)
end

function VersionActivity1_8DungeonMapInteractView:refreshFightUI()
	local episodeId = tonumber(self._config.param)

	self.isFinish = DungeonModel.instance:hasPassLevel(episodeId)

	if self.isFinish then
		self:setFinishText()

		self._txtfight.text = luaLang("p_dungeonmapinteractiveitem_win")
		self._txtfighten.text = luaLang("fixed_en_finish")
	else
		self._txtfight.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end

	self:setIsChat(false)
end

function VersionActivity1_8DungeonMapInteractView:refreshDialogueUI()
	self._sectionStack = {}
	self._dialogId = tonumber(self._config.param)

	self:_playSection(0)
end

function VersionActivity1_8DungeonMapInteractView:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function VersionActivity1_8DungeonMapInteractView:_setSectionData(sectionId, dialogIndex)
	self._sectionList = DungeonConfig.instance:getDialog(self._dialogId, sectionId)
	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function VersionActivity1_8DungeonMapInteractView:_playNextDialog()
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

function VersionActivity1_8DungeonMapInteractView:_showDialog(type, text, speaker, audio)
	DungeonMapModel.instance:addDialog(type, text, speaker, audio)
	gohelper.setActive(self._gochatusericon, not speaker)

	local hasSpeaker = not string.nilorempty(speaker)

	if hasSpeaker then
		self._txtchatname.text = speaker .. ":" or ""
	end

	self._txtchatdesc.text = text

	self:setIsChat(true)
end

function VersionActivity1_8DungeonMapInteractView:_addDialogOption(index, sectionId, text)
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

function VersionActivity1_8DungeonMapInteractView:_onOptionClick(param)
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

function VersionActivity1_8DungeonMapInteractView:_refreshDialogBtnState(showOption, hasNext)
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

function VersionActivity1_8DungeonMapInteractView:refreshDispatchUI()
	local elementId = self._config.id
	local dispatchId = tonumber(self._config.param)
	local dispatchMo = DispatchModel.instance:getDispatchMo(elementId, dispatchId)

	self.isFinish = dispatchMo and dispatchMo:isFinish()

	if self.isFinish then
		self._txtdispatch.text = luaLang("p_dungeonmapinteractiveitem_finishtask")
		self._txtdispatchen.text = luaLang("fixed_en_finish")

		self:setFinishText()
	else
		self._txtdesc.text = self._config.desc
		self._txtdispatch.text = dispatchMo and dispatchMo:isRunning() and self._config.dispatchingText or self._config.acceptText
	end

	self:setIsChat(false)
end

function VersionActivity1_8DungeonMapInteractView:everySecondCall()
	if not self._show then
		return
	end

	if self._config and self._config.type == DungeonEnum.ElementType.Dispatch then
		self:refreshDispatchUI()
	end
end

function VersionActivity1_8DungeonMapInteractView:setFinishText()
	local finishText = self._config.finishText

	self._txtdesc.text = string.nilorempty(finishText) and self._config.desc or finishText
end

function VersionActivity1_8DungeonMapInteractView:refreshRewards()
	local rewardStr = DungeonModel.instance:getMapElementReward(self._config.id)

	if string.nilorempty(rewardStr) then
		gohelper.setActive(self._gorewardcontainer, false)

		return
	end

	gohelper.setActive(self._gorewardcontainer, true)

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

function VersionActivity1_8DungeonMapInteractView:createRewardItem()
	local rewardItem = self:getUserDataTb_()

	rewardItem.go = gohelper.cloneInPlace(self._goactivityrewarditem)
	rewardItem.goIcon = gohelper.findChild(rewardItem.go, "itemicon")
	rewardItem.goCount = gohelper.findChild(rewardItem.go, "countbg")
	rewardItem.txtCount = gohelper.findChildText(rewardItem.go, "countbg/count")
	rewardItem.goRare = gohelper.findChild(rewardItem.go, "rare")
	rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

	gohelper.setActive(rewardItem.goRare, false)

	return rewardItem
end

function VersionActivity1_8DungeonMapInteractView:show()
	if self._show then
		return
	end

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractiveroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function VersionActivity1_8DungeonMapInteractView:hide()
	if not self._show then
		return
	end

	VersionActivity1_8DungeonModel.instance:setShowInteractView(nil)

	self._show = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractiveroot, false)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnHideInteractUI)
end

function VersionActivity1_8DungeonMapInteractView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_8DungeonMapInteractView:onDestroyView()
	self._optionBtnList = nil
end

return VersionActivity1_8DungeonMapInteractView
