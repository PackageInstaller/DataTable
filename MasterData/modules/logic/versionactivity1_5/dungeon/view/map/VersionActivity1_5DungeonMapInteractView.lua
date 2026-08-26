-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapInteractView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapInteractView", package.seeall)

local VersionActivity1_5DungeonMapInteractView = class("VersionActivity1_5DungeonMapInteractView", BaseView)

function VersionActivity1_5DungeonMapInteractView:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self._gointeractitem, "#btn_close")
	self._txtsubherotasktitle = gohelper.findChildText(self._gointeractitem, "rotate/#go_subherotasktitle/#txt_subherotasktitle")
	self._gosubherotasktitle = gohelper.findChild(self._gointeractitem, "rotate/#go_subherotasktitle")
	self._txttitle = gohelper.findChildText(self._gointeractitem, "rotate/#go_title/#txt_title")
	self._simagedescbg = gohelper.findChildSingleImage(self._gointeractitem, "rotate/desc_container/#simage_descbg")
	self._txtdesc = gohelper.findChildText(self._gointeractitem, "rotate/desc_container/#txt_desc")
	self.goRewardContainer = gohelper.findChild(self._gointeractitem, "rotate/reward_container")
	self.goRewardContent = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent")
	self.goRewardItem = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	self:initNoneContainer()
	self:initFightContainer()
	self:initDispatchContainer()
	self:initDialogueContainer()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapInteractView:initNoneContainer()
	self.goNone = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_none")
	self.txtNone = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_none/#txt_none")
	self.noneBtn = gohelper.findButtonWithAudio(self.goNone)
end

function VersionActivity1_5DungeonMapInteractView:initFightContainer()
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

function VersionActivity1_5DungeonMapInteractView:initDispatchContainer()
	self.goDispatch = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_dispatch")
	self.txtDispatch = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_dispatch/#txt_dispatch")
	self.enterDispatchBtn = gohelper.findButtonWithAudio(self.goDispatch)
end

function VersionActivity1_5DungeonMapInteractView:initDialogueContainer()
	self.goDialogue = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_dialogue")
	self.txtDialogue = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	self.enterDialogueBtn = gohelper.findButtonWithAudio(self.goDialogue)
end

function VersionActivity1_5DungeonMapInteractView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.noneBtn:AddClickListener(self._onClickNoneBtn, self)
	self.fightBtn:AddClickListener(self._onClickFightBtn, self)
	self.enterDialogueBtn:AddClickListener(self._onClickEnterDialogueBtn, self)
	self.enterDispatchBtn:AddClickListener(self._onClickEnterDispatchBtn, self)
end

function VersionActivity1_5DungeonMapInteractView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.noneBtn:RemoveClickListener()
	self.fightBtn:RemoveClickListener()
	self.enterDialogueBtn:RemoveClickListener()
	self.enterDispatchBtn:RemoveClickListener()
end

function VersionActivity1_5DungeonMapInteractView:_editableInitView()
	self._handleTypeMap = {
		[DungeonEnum.ElementType.None] = self.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = self.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = self.refreshDialogueUI,
		[DungeonEnum.ElementType.EnterDispatch] = self.refreshEnterDispatchUI
	}
	self.type2goDict = {
		[DungeonEnum.ElementType.None] = self.goNone,
		[DungeonEnum.ElementType.Fight] = self.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = self.goDialogue,
		[DungeonEnum.ElementType.EnterDispatch] = self.goDispatch
	}
	self.rewardItemList = {}
	self.rootClick = gohelper.findChildClickWithDefaultAudio(self._gointeractroot, "close_block")

	self.rootClick:AddClickListener(self.onClickRoot, self)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	gohelper.setActive(self.goRewardItem, false)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.showInteractUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.addEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.beforeJump, self)
end

function VersionActivity1_5DungeonMapInteractView:onClickRoot()
	self:hide()

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity1_5DungeonMapInteractView:showInteractUI(mapElement)
	if self._show then
		return
	end

	self._isRecheck = false

	VersionActivity1_5DungeonModel.instance:setShowInteractView(true)

	self._mapElement = mapElement
	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go
	self.isFinish = false

	self:show()
	self:refreshUI()
end

function VersionActivity1_5DungeonMapInteractView:onRecheck(elementCo)
	if self._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(true)

	self._config = elementCo
	self.isFinish = false
	self._isRecheck = true

	self:show()
	self:refreshUI()
end

function VersionActivity1_5DungeonMapInteractView:show()
	if self._show then
		return
	end

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function VersionActivity1_5DungeonMapInteractView:hide()
	if not self._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(nil)

	self._show = false
	self.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnHideInteractUI)
end

function VersionActivity1_5DungeonMapInteractView:refreshUI()
	for type, go in pairs(self.type2goDict) do
		gohelper.setActive(go, type == self._config.type)
	end

	self._txttitle.text = self._config.title

	local handleFunc = self._handleTypeMap[self._config.type]

	if handleFunc then
		handleFunc(self)
	else
		logError("element type undefined!")
	end

	self:refreshSubHeroTaskTitle()
	self:refreshRewards()
end

function VersionActivity1_5DungeonMapInteractView:refreshSubHeroTaskTitle()
	local subHeroTaskCo = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(self._config.id)
	local isShow = subHeroTaskCo ~= nil

	gohelper.setActive(self._gosubherotasktitle, isShow)

	if isShow then
		self._txtsubherotasktitle.text = subHeroTaskCo.title
	end
end

function VersionActivity1_5DungeonMapInteractView:refreshRewards()
	local rewardStr = DungeonModel.instance:getMapElementReward(self._config.id)

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

function VersionActivity1_5DungeonMapInteractView:createRewardItem()
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

function VersionActivity1_5DungeonMapInteractView:refreshNoneUI()
	self.txtNone.text = self._config.acceptText
	self._txtdesc.text = self._config.desc
end

function VersionActivity1_5DungeonMapInteractView:setFinishText()
	local finishText = self._config.finishText

	self._txtdesc.text = string.nilorempty(finishText) and self._config.desc or finishText
end

function VersionActivity1_5DungeonMapInteractView:refreshFightUI()
	local episodeId = tonumber(self._config.param)

	self.isFinish = DungeonModel.instance:hasPassLevel(episodeId)

	if self.isFinish and not self._isRecheck then
		self.txtFight.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtFight.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end
end

function VersionActivity1_5DungeonMapInteractView:refreshDialogueUI()
	self.dialogueId = tonumber(self._config.param)
	self.isFinish = DialogueModel.instance:isFinishDialogue(self.dialogueId)

	if self.isFinish and not self._isRecheck then
		self.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtDialogue.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end
end

function VersionActivity1_5DungeonMapInteractView:refreshEnterDispatchUI()
	local dispatchId = tonumber(self._config.param)

	self.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(dispatchId)
	self.isFinish = self.dispatchMo and self.dispatchMo:isFinish()

	if self.isFinish and not self._isRecheck then
		self.txtDispatch.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
		TaskDispatcher.cancelTask(self.everySecondCall, self)
	else
		self.txtDispatch.text = self._config.acceptText
		self._txtdesc.text = self._config.desc

		if self.dispatchMo and self.dispatchMo:isRunning() then
			TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
		end
	end
end

function VersionActivity1_5DungeonMapInteractView:_btncloseOnClick()
	self:hide()

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end
end

function VersionActivity1_5DungeonMapInteractView:_onClickNoneBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	self:finishElement()
end

function VersionActivity1_5DungeonMapInteractView:_onClickFightBtn()
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

	VersionActivity1_5DungeonController.instance:setLastEpisodeId(self.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function VersionActivity1_5DungeonMapInteractView:_onClickEnterDialogueBtn()
	if self.isFinish and not self._isRecheck then
		self:hide()
		self:finishElement()

		return
	end

	DialogueController.instance:enterDialogue(self.dialogueId, function()
		if self._isRecheck then
			self:hide()
			DungeonController.instance:onAgainOpenRecheckView(self._config.id)
		end
	end)
end

function VersionActivity1_5DungeonMapInteractView:_onClickEnterDispatchBtn()
	if self.isFinish then
		self:hide()
		self:finishElement()

		return
	end

	VersionActivity1_5DungeonController.instance:openDispatchView(tonumber(self._config.param))
end

function VersionActivity1_5DungeonMapInteractView:finishElement()
	local elementId = self._config.id

	DungeonMapModel.instance:addFinishedElement(elementId)
	DungeonMapModel.instance:removeElement(elementId)

	if self._isRecheck then
		DungeonController.instance:onRecheckFragmentInfoView(self._config)
	else
		DungeonRpc.instance:sendMapElementRequest(elementId)
	end
end

function VersionActivity1_5DungeonMapInteractView:onDialogueInfoChange(dialogueId)
	if dialogueId == self.dialogueId then
		self:refreshDialogueUI()
	end
end

function VersionActivity1_5DungeonMapInteractView:everySecondCall()
	if self.dispatchMo and self.dispatchMo:isFinish() then
		self:refreshEnterDispatchUI()
	end
end

function VersionActivity1_5DungeonMapInteractView:onCloseViewFinishCall(viewName)
	if viewName == ViewName.DialogueView and self.isFinish then
		self:refreshUI()
	end
end

function VersionActivity1_5DungeonMapInteractView:onAddDispatchInfo(dispatchId)
	self:refreshEnterDispatchUI()
end

function VersionActivity1_5DungeonMapInteractView:beforeJump()
	self:hide()
end

function VersionActivity1_5DungeonMapInteractView:onClose()
	return
end

function VersionActivity1_5DungeonMapInteractView:onDestroyView()
	self._simagedescbg:UnLoadImage()
	self.rootClick:RemoveClickListener()
end

return VersionActivity1_5DungeonMapInteractView
