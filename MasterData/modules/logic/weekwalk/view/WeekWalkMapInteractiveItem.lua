-- chunkname: @modules/logic/weekwalk/view/WeekWalkMapInteractiveItem.lua

module("modules.logic.weekwalk.view.WeekWalkMapInteractiveItem", package.seeall)

local WeekWalkMapInteractiveItem = class("WeekWalkMapInteractiveItem", LuaCompBase)

function WeekWalkMapInteractiveItem:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "rotate/bg/#simage_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/bg/#txt_info")
	self._gomask = gohelper.findChild(self.viewGO, "rotate/bg/#go_mask")
	self._goscroll = gohelper.findChild(self.viewGO, "rotate/bg/#go_mask/Scroll View/Viewport/#go_scroll")
	self._gochatarea = gohelper.findChild(self.viewGO, "rotate/bg/#go_chatarea")
	self._gochatitem = gohelper.findChild(self.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	self._goimportanttips = gohelper.findChild(self.viewGO, "rotate/bg/#go_importanttips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	self._goop1 = gohelper.findChild(self.viewGO, "rotate/#go_op1")
	self._gorewards = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_rewards")
	self._gonormal = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_normal")
	self._gonorewards = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_normal/#go_norewards")
	self._gohasrewards = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_normal/#go_hasrewards")
	self._goboss = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_boss")
	self._gobossnorewards = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_boss/#go_bossnorewards")
	self._gobosshasrewards = gohelper.findChild(self.viewGO, "rotate/#go_op1/#go_boss/#go_bosshasrewards")
	self._btndoit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op1/#btn_doit")
	self._goop2 = gohelper.findChild(self.viewGO, "rotate/#go_op2")
	self._gounfinishtask = gohelper.findChild(self.viewGO, "rotate/#go_op2/#go_unfinishtask")
	self._txtunfinishtask = gohelper.findChildText(self.viewGO, "rotate/#go_op2/#go_unfinishtask/#txt_unfinishtask")
	self._btnunfinishtask = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op2/#go_unfinishtask/#btn_unfinishtask")
	self._gofinishtask = gohelper.findChild(self.viewGO, "rotate/#go_op2/#go_finishtask")
	self._txtfinishtask = gohelper.findChildText(self.viewGO, "rotate/#go_op2/#go_finishtask/#txt_finishtask")
	self._btnfinishtask = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op2/#go_finishtask/#btn_finishtask")
	self._goop3 = gohelper.findChild(self.viewGO, "rotate/#go_op3")
	self._gofinishFight = gohelper.findChild(self.viewGO, "rotate/#go_op3/#go_finishFight")
	self._txtwin = gohelper.findChildText(self.viewGO, "rotate/#go_op3/#go_finishFight/bg/#txt_win")
	self._btnwin = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op3/#go_finishFight/bg/#btn_win")
	self._gounfinishedFight = gohelper.findChild(self.viewGO, "rotate/#go_op3/#go_unfinishedFight")
	self._txtfight = gohelper.findChildText(self.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#txt_fight")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#btn_fight")
	self._goop4 = gohelper.findChild(self.viewGO, "rotate/#go_op4")
	self._gonext = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	self._gooptions = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	self._gofinishtalk = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_finishtalk")
	self._btnfinishtalk = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	self._goop5 = gohelper.findChild(self.viewGO, "rotate/#go_op5")
	self._gosubmit = gohelper.findChild(self.viewGO, "rotate/#go_op5/#go_submit")
	self._btnsubmit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	self._inputanswer = gohelper.findChildInputField(self.viewGO, "rotate/#go_op5/#input_answer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkMapInteractiveItem:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndoit:AddClickListener(self._btndoitOnClick, self)
	self._btnunfinishtask:AddClickListener(self._btnunfinishtaskOnClick, self)
	self._btnfinishtask:AddClickListener(self._btnfinishtaskOnClick, self)
	self._btnwin:AddClickListener(self._btnwinOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfinishtalk:AddClickListener(self._btnfinishtalkOnClick, self)
	self._btnsubmit:AddClickListener(self._btnsubmitOnClick, self)
end

function WeekWalkMapInteractiveItem:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndoit:RemoveClickListener()
	self._btnunfinishtask:RemoveClickListener()
	self._btnfinishtask:RemoveClickListener()
	self._btnwin:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfinishtalk:RemoveClickListener()
	self._btnsubmit:RemoveClickListener()
end

function WeekWalkMapInteractiveItem:_btnsubmitOnClick()
	self._inputanswer = gohelper.findChildTextMeshInputField(self.viewGO, "rotate/#go_op5/#input_answer")

	local text = self._inputanswer:GetText()

	if text == self._config.param then
		self:_onHide()
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	else
		self._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btncloseOnClick()
	if self._playScrollAnim then
		return
	end

	self:_onHide()
end

function WeekWalkMapInteractiveItem:_btnfinishtalkOnClick()
	self:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if self._config.skipFinish == 1 then
		return
	end

	self:_sendFinishDialog()
end

function WeekWalkMapInteractiveItem:_sendFinishDialog()
	if self._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		WeekwalkRpc.instance:sendWeekwalkDialogRequest(self._config.id, tonumber(self._option_param) or 0)
	end
end

function WeekWalkMapInteractiveItem:_btndoitOnClick()
	self:_onHide()

	local id = self._elementInfo.elementId

	WeekWalkModel.instance:setBattleElementId(id)
	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btnfightOnClick()
	self:_onHide()

	local episodeId = tonumber(self._config.param)

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btnunfinishtaskOnClick()
	self:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btnfinishtaskOnClick()
	self:_onHide()

	local id = self._elementInfo.elementId

	WeekwalkRpc.instance:sendWeekwalkGeneralRequest(id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btnnextOnClick()
	if self._playScrollAnim then
		return
	end

	self:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_btntalkitemOnClick()
	return
end

function WeekWalkMapInteractiveItem:_editableInitView()
	self._nextAnimator = self._gonext:GetComponent(typeof(UnityEngine.Animator))
	self._imgMask = self._gomask:GetComponent(gohelper.Type_Image)
end

function WeekWalkMapInteractiveItem:_playAnim(go, name)
	local animator = go:GetComponent(typeof(UnityEngine.Animator))

	animator:Play(name)
end

function WeekWalkMapInteractiveItem:_onShow()
	if self._show then
		return
	end

	self._mapElement:setWenHaoVisible(false)

	self._show = true

	gohelper.setActive(self.viewGO, true)
	self:_playAnim(self._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(self._showCloseBtn, self)
	TaskDispatcher.runDelay(self._showCloseBtn, self, 0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function WeekWalkMapInteractiveItem:_showCloseBtn()
	gohelper.setActive(self._btnclose.gameObject, true)
end

function WeekWalkMapInteractiveItem:_onOutAnimationFinished()
	gohelper.setActive(self.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(self.viewGO)
end

function WeekWalkMapInteractiveItem:_onHide()
	if not self._show then
		return
	end

	self:_clearScroll()
	self._mapElement:setWenHaoVisible(true)

	self._show = false

	gohelper.setActive(self._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	self:_playAnim(self._gonext, "dungeonmap_interactive_btn_out")
	self:_playAnim(self._gofinishtalk, "dungeonmap_interactive_btn_out")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

	for k, v in pairs(self._optionBtnList) do
		self:_playAnim(v[1], "dungeonmap_interactive_btn_out")
	end

	TaskDispatcher.runDelay(self._onOutAnimationFinished, self, 0.23)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function WeekWalkMapInteractiveItem:init(go)
	self.viewGO = go
	self._optionBtnList = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._dialogItemCacheList = self:getUserDataTb_()

	self:onInitView()
	self:addEvents()
	self:_editableAddEvents()
end

function WeekWalkMapInteractiveItem:_editableAddEvents()
	return
end

function WeekWalkMapInteractiveItem:_OnClickElement(mapElement)
	self._mapElement = mapElement

	if self._show then
		self:_onHide()

		return
	end

	self:_onShow()

	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go
	self._elementInfo = self._mapElement._info
	self._elementX, self._elementY, self._elementZ = transformhelper.getPos(self._elementGo.transform)

	if not self._config.offsetPos then
		local offsetPosConfig = "2#3"

		if not string.nilorempty(offsetPosConfig) then
			local offsetPos = string.splitToNumber(offsetPosConfig, "#")

			self._elementAddX = self._elementX + (offsetPos[1] or 0)
			self._elementAddY = self._elementY + (offsetPos[2] or 0)
		end

		self.viewGO.transform.position = Vector3(self._elementAddX, self._elementAddY, self._elementZ)

		local showTip = not string.nilorempty(self._config.flagText)

		gohelper.setActive(self._goimportanttips, showTip)

		if showTip then
			self._txttipsinfo.text = self._config.flagText
		end

		local type = self._elementInfo:getType()
		local isStoryType = type == WeekWalkEnum.ElementType.Dialog

		gohelper.setActive(self._txtinfo.gameObject, false)
		gohelper.setActive(self._gochatarea, isStoryType)

		if type == WeekWalkEnum.ElementType.General then
			self:_directlyComplete()
		elseif type == WeekWalkEnum.ElementType.Battle then
			local prevId = tonumber(self._elementInfo:getPrevParam())

			if prevId then
				gohelper.setActive(self._gochatarea, true)
				self:_playStory(prevId)
			end

			self:_showTypeGo(type)
		elseif type == DungeonEnum.ElementType.Task then
			self:_showTask()
		elseif isStoryType then
			self:_showTypeGo(type)
			self:_playStory()
		elseif type == DungeonEnum.ElementType.Question then
			self:_playQuestion()
		else
			logError("element type undefined!")
		end

		self._simagebg:LoadImage(ResUrl.getWeekWalkBg("tc3.png"))
	end
end

function WeekWalkMapInteractiveItem:_showTypeGo(type)
	for i = 1, WeekWalkEnum.ElementType.MaxCount do
		gohelper.setActive(self["_goop" .. i], i == type)
	end

	if type == WeekWalkEnum.ElementType.Battle then
		local isBoss = self._config.isBoss > 0

		gohelper.setActive(self._gonormal, not isBoss)
		gohelper.setActive(self._goboss, isBoss)
		self:_showRewards(isBoss)
	end
end

function WeekWalkMapInteractiveItem:_showRewards(isBoss)
	local list = string.splitToNumber(self._config.bonusGroup, "#")

	if not list[2] then
		local groupId = 0
		local hasRewards = groupId > 0

		if not hasRewards then
			gohelper.setActive((not isBoss or nil) and (self._gonorewards or self._gobossnorewards), true)

			do return end

			local var_24_1

			if not isBoss then
				var_24_1 = self._gohasrewards or self._gobosshasrewards
			end
		end

		gohelper.setActive(var_24_1, true)

		local level = WeekWalkModel.instance:getLevel()
		local rewards = WeekWalkConfig.instance:getBonus(groupId, level)
		local rewardList = GameUtil.splitString2(rewards, true, "|", "#")

		if not rewardList then
			return
		end

		for i, reward in ipairs(rewardList) do
			local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

			item:setMOValue(reward[1], reward[2], reward[3])
			item:setScale(0.39)
			item:customOnClickCallback(self._openRewardView, rewardList)
		end
	end
end

function WeekWalkMapInteractiveItem:_playQuestion()
	self._txtinfo.text = self._config.desc
end

function WeekWalkMapInteractiveItem:_showTask()
	self._txtinfo.text = self._config.desc

	local paramStr = self._config.param
	local itemParam = string.splitToNumber(paramStr, "#")
	local needNum = itemParam[3]
	local itemConfig = ItemModel.instance:getItemConfig(itemParam[1], itemParam[2])
	local quantity = ItemModel.instance:getItemQuantity(itemParam[1], itemParam[2])

	self._finishTask = needNum <= quantity

	gohelper.setActive(self._gofinishtask, self._finishTask)
	gohelper.setActive(self._gounfinishtask, not self._finishTask)

	if self._finishTask then
		self._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), itemConfig.name, quantity, needNum)
	else
		self._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), itemConfig.name, quantity, needNum)
	end
end

function WeekWalkMapInteractiveItem:_directlyComplete()
	self._txtinfo.text = self._config.desc
end

function WeekWalkMapInteractiveItem:_playNextSectionOrDialog()
	self:_clearDialog()

	if #self._sectionList >= self._dialogIndex then
		self:_playNextDialog()

		return
	end

	local prevSectionInfo = table.remove(self._sectionStack)

	if prevSectionInfo then
		self:_playSection(prevSectionInfo[1], prevSectionInfo[2])
	else
		self:_refreshDialogBtnState()
	end
end

function WeekWalkMapInteractiveItem:_playStory(id)
	self:_clearDialog()

	self._sectionStack = {}
	self._optionId = 0
	self._mainSectionId = "0"
	self._sectionId = self._mainSectionId
	self._dialogIndex = nil
	self._historyList = {}
	self._dialogId = id or tonumber(self._elementInfo:getParam())

	self:_initHistoryItem()

	self._historyList.id = self._dialogId

	self:_playSection(self._sectionId, self._dialogIndex)
end

function WeekWalkMapInteractiveItem:_initHistoryItem()
	local historyList = self._elementInfo.historylist

	if #historyList == 0 then
		return
	end

	for i, v in ipairs(historyList) do
		local param = string.split(v, "#")

		self._historyList[param[1]] = tonumber(param[2])
	end

	local historyId = self._historyList.id

	if not historyId or historyId ~= self._dialogId then
		self._historyList = {}

		return
	end

	self._option_param = self._historyList.option

	local sectionId = self._mainSectionId
	local dialogIndex = self._historyList[sectionId]

	self:_addSectionHistory(sectionId, dialogIndex)

	if not self._dialogIndex then
		self._dialogIndex = dialogIndex
		self._sectionId = sectionId
	end
end

function WeekWalkMapInteractiveItem:_addSectionHistory(sectionId, dialogIndex)
	local dialogList = WeekWalkConfig.instance:getDialog(self._dialogId, sectionId)
	local finish = sectionId == self._mainSectionId and dialogIndex > #dialogList or dialogIndex >= #dialogList

	for i, v in ipairs(dialogList) do
		if i < dialogIndex or finish then
			if v.type == "dialog" then
				local item = self:_addDialogItem("dialog", v.content, v.speaker)

				table.insert(self._dialogItemList, item)
			end

			if v.type == "options" then
				local optionList = string.split(v.content, "#")
				local sectionIdList = string.split(v.param, "#")
				local allContentList = {}
				local allSectionList = {}

				for j, id in ipairs(sectionIdList) do
					local list = WeekWalkConfig.instance:getDialog(self._dialogId, id)

					if list and list.type == "random" then
						for _, randomDialog in ipairs(list) do
							local paramList = string.split(randomDialog.option_param, "#")
							local succSectionId = paramList[2]
							local failSectionId = paramList[3]

							table.insert(allContentList, optionList[j])
							table.insert(allSectionList, succSectionId)
							table.insert(allContentList, optionList[j])
							table.insert(allSectionList, failSectionId)
						end
					elseif list then
						table.insert(allContentList, optionList[j])
						table.insert(allSectionList, id)
					else
						local text = string.format("<indent=4.7em><color=#c95318>\"%s\"</color>", optionList[j])
						local item = self:_addDialogItem("option", text)

						table.insert(self._dialogItemList, item)
					end
				end

				for j, id in ipairs(allSectionList) do
					local index = self._historyList[id]

					if index then
						local text = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", allContentList[j])
						local item = self:_addDialogItem("option", text)

						table.insert(self._dialogItemList, item)
						self:_addSectionHistory(id, index)
					end
				end
			end
		else
			break
		end
	end

	if not finish then
		if not self._dialogIndex then
			self._dialogIndex = dialogIndex
			self._sectionId = sectionId

			return
		end

		table.insert(self._sectionStack, 1, {
			sectionId,
			dialogIndex
		})
	end
end

function WeekWalkMapInteractiveItem:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function WeekWalkMapInteractiveItem:_setSectionData(sectionId, dialogIndex)
	self._sectionList = WeekWalkConfig.instance:getDialog(self._dialogId, sectionId)

	if self._sectionList and not string.nilorempty(self._sectionList.option_param) then
		self._option_param = self._sectionList.option_param
	end

	if not string.nilorempty(self._option_param) then
		self._historyList.option = self._option_param
	end

	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function WeekWalkMapInteractiveItem:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	if config and config.type == "dialog" then
		self:_showDialog("dialog", config.content, config.speaker)
	elseif config and config.type == "options" then
		self:_showOptionByConfig(config)

		return
	end

	self._dialogIndex = self._dialogIndex + 1

	if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
		local prevSectionInfo = table.remove(self._sectionStack)

		self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
	end

	local nextConfig = self._sectionList[self._dialogIndex]

	self:_showOptionByConfig(nextConfig)

	if self._dissolveInfo then
		gohelper.setActive(self._curBtnGo, false)
	end
end

function WeekWalkMapInteractiveItem:_showOptionByConfig(nextConfig)
	local showOption = false

	if nextConfig and nextConfig.type == "options" then
		self._dialogIndex = self._dialogIndex + 1

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		for k, v in pairs(self._optionBtnList) do
			gohelper.setActive(v[1], false)
		end

		for i, v in ipairs(optionList) do
			self:_addDialogOption(i, sectionIdList[i], v)
		end

		showOption = true
	end

	self:_refreshDialogBtnState(showOption)
end

function WeekWalkMapInteractiveItem:_refreshDialogBtnState(showOption)
	gohelper.setActive(self._gooptions, showOption)

	if showOption then
		self._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(self._gofinishtalk.gameObject, false)

		self._curBtnGo = self._gooptions

		return
	end

	local hasNext = #self._sectionStack > 0 or #self._sectionList >= self._dialogIndex

	if hasNext then
		self._curBtnGo = self._gonext

		gohelper.setActive(self._gonext.gameObject, hasNext)
		self._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		self._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		self._curBtnGo = self._gofinishtalk
	end

	local isFinish = not hasNext

	gohelper.setActive(self._gofinishtalk.gameObject, isFinish)

	if isFinish then
		local type = self._elementInfo:getNextType()

		if not type then
			return
		end

		self:_sendFinishDialog()
		self:_showTypeGo(type)
	end
end

function WeekWalkMapInteractiveItem:_addDialogOption(index, sectionId, text)
	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local item = gohelper.cloneInPlace(self._gotalkitem)

			self._maxOptionIndex = index

			gohelper.setActive(item, false)

			local txt = gohelper.findChildText(item, "txt_talkitem")

			txt.text = text

			local btn = gohelper.findChildButtonWithAudio(item, "btn_talkitem")

			btn:AddClickListener(self._onOptionClick, self, {
				sectionId,
				text,
				index
			})

			self._optionBtnList[index] = self._optionBtnList[index] or {
				item,
				btn
			}
		end
	end
end

function WeekWalkMapInteractiveItem:_onOptionClick(param)
	if self._playScrollAnim then
		return
	end

	local sectionId = param[1]
	local text = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", param[2])

	self:_clearDialog()
	self:_showDialog("option", text)

	self._showOption = true
	self._optionId = param[3]

	self:_checkOption(sectionId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function WeekWalkMapInteractiveItem:_checkOption(sectionId)
	local dialogList = WeekWalkConfig.instance:getDialog(self._dialogId, sectionId)

	if not dialogList then
		self:_playNextSectionOrDialog()

		return
	end

	if #self._sectionList >= self._dialogIndex then
		table.insert(self._sectionStack, {
			self._sectionId,
			self._dialogIndex
		})
	end

	if dialogList.type == "random" then
		for i, v in ipairs(dialogList) do
			local paramList = string.split(v.option_param, "#")
			local value = tonumber(paramList[1])
			local succSectionId = paramList[2]
			local failSectionId = paramList[3]
			local randomValue = math.random(100)
			local randomSectionId

			self:_playSection(randomValue <= value and succSectionId or failSectionId)

			break
		end
	else
		self:_playSection(sectionId)
	end
end

function WeekWalkMapInteractiveItem:_showDialog(type, text, speaker)
	if self._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		self._historyList[self._sectionId] = self._dialogIndex

		local list = {}

		for k, v in pairs(self._historyList) do
			table.insert(list, string.format("%s#%s", k, v))
		end

		WeekwalkRpc.instance:sendWeekwalkDialogHistoryRequest(self._config.id, list)
		self._elementInfo:updateHistoryList(list)
	end

	local item = self:_addDialogItem(type, text, speaker)

	if self._showOption and self._addDialog then
		-- block empty
	end

	self._showOption = false

	table.insert(self._dialogItemList, item)

	self._addDialog = true
end

function WeekWalkMapInteractiveItem:_addDialogItem(type, text, speaker)
	local item = table.remove(self._dialogItemCacheList) or gohelper.cloneInPlace(self._gochatitem)

	transformhelper.setLocalPos(item.transform, 0, 0, 200)
	gohelper.setActive(item, true)
	gohelper.setAsLastSibling(item)

	local nameText = gohelper.findChildText(item, "name")

	if not string.nilorempty(speaker) then
		nameText.text = speaker .. ":" or ""
	end

	local iconGo = gohelper.findChild(item, "usericon")

	gohelper.setActive(iconGo, not speaker)

	local infoText = gohelper.findChildText(item, "info")

	infoText.text = string.nilorempty(speaker) and text or "<indent=4.7em>" .. text

	SLFramework.UGUI.GuiHelper.SetColor(infoText, string.nilorempty(speaker) and "#9E967B" or "#D0CFCF")

	return item
end

function WeekWalkMapInteractiveItem:_clearDialog()
	self._playScrollAnim = true

	gohelper.setActive(self._gomask, false)
	TaskDispatcher.runDelay(self._delayScroll, self, 0)
end

function WeekWalkMapInteractiveItem:_delayScroll()
	gohelper.setActive(self._gomask, true)

	self._imgMask.enabled = true

	if not self._curScrollGo then
		for i, item in ipairs(self._dialogItemList) do
			local pos = item.transform.position

			gohelper.addChild(self._curScrollGo, item)

			item.transform.position = pos

			local x, y, z = transformhelper.getLocalPos(item.transform)

			transformhelper.setLocalPos(item.transform, x, y, 0)
		end

		self._dialogItemList = self:getUserDataTb_()

		gohelper.setActive(self._curScrollGo, true)

		self._curScrollGo = self._curScrollGo

		if self._curScrollGo then
			if self._dissolveInfo then
				local infoText = self._dissolveInfo[2]

				infoText.text = ""
			end

			self:_scrollEnd(self._curScrollGo)
		end
	end
end

function WeekWalkMapInteractiveItem:_scrollEnd(scrollGo)
	if scrollGo ~= self._curScrollGo then
		gohelper.destroy(scrollGo)
	else
		if self._dissolveInfo then
			TaskDispatcher.runDelay(self._onDissolveStart, self, 0.3)

			return
		end

		self:_onDissolveFinish()
	end
end

function WeekWalkMapInteractiveItem:_onDissolveStart()
	local item = self._dissolveInfo[1]
	local infoText = self._dissolveInfo[2]

	infoText.text = self._dissolveInfo[3]
	self._imgMask.enabled = false

	local anim = item:GetComponent(typeof(UnityEngine.Animation))

	anim:Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(self._onDissolveFinish, self, 1.3)
end

function WeekWalkMapInteractiveItem:_onDissolveFinish()
	gohelper.setActive(self._curBtnGo, true)

	self._dissolveInfo = nil
	self._playScrollAnim = false

	if self._curBtnGo == self._gooptions then
		for index = 1, self._maxOptionIndex do
			local time = (index - 1) * 0.03
			local item = self._optionBtnList[index][1]

			if time > 0 then
				gohelper.setActive(item, false)
				TaskDispatcher.runDelay(function()
					if not gohelper.isNil(item) then
						gohelper.setActive(item, true)
					end
				end, nil, time)
			else
				gohelper.setActive(item, true)
			end
		end
	end
end

function WeekWalkMapInteractiveItem:_clearScroll()
	self._showOption = false
	self._dissolveInfo = nil
	self._playScrollAnim = false

	TaskDispatcher.cancelTask(self._delayScroll, self)

	if self._oldScrollGo then
		gohelper.destroy(self._oldScrollGo)

		self._oldScrollGo = nil
	end

	if self._curScrollGo then
		gohelper.destroy(self._curScrollGo)

		self._curScrollGo = nil
	end

	self._dialogItemList = self:getUserDataTb_()
end

function WeekWalkMapInteractiveItem:_editableRemoveEvents()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end
end

function WeekWalkMapInteractiveItem:onDestroy()
	TaskDispatcher.cancelTask(self._showCloseBtn, self)
	TaskDispatcher.cancelTask(self._delayScroll, self)
	TaskDispatcher.cancelTask(self._onDissolveStart, self)
	TaskDispatcher.cancelTask(self._onDissolveFinish, self)
	self:removeEvents()
	self:_editableRemoveEvents()
	self._simagebg:UnLoadImage()
end

return WeekWalkMapInteractiveItem
