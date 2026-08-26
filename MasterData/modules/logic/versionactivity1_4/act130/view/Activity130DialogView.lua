-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130DialogView.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130DialogView", package.seeall)

local Activity130DialogView = class("Activity130DialogView", BaseView)

function Activity130DialogView:onInitView()
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._gotopcontent = gohelper.findChild(self.viewGO, "#go_topcontent")
	self._godialoghead = gohelper.findChild(self.viewGO, "#go_topcontent/#go_dialoghead")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_topcontent/#go_dialoghead/#image_headicon")
	self._txtdialogdesc = gohelper.findChildText(self.viewGO, "#go_topcontent/#txt_dialogdesc")
	self._gobottomcontent = gohelper.findChild(self.viewGO, "#go_bottomcontent")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_bottomcontent/#go_content/#simage_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#go_bottomcontent/#go_content/#txt_info")
	self._gooptions = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content/#go_options/#go_talkitem")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottomcontent/#btn_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130DialogView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function Activity130DialogView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function Activity130DialogView:_btnskipOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		self:_skipStory()
	end)
end

function Activity130DialogView:_skipStory()
	self._isSkip = true

	if self._skipOptionParams then
		self:_skipOption(self._skipOptionParams[1], self._skipOptionParams[2])
	end

	for i = 1, 100 do
		self:_playNextSectionOrDialog()

		if self._finishClose then
			break
		end
	end
end

function Activity130DialogView:_btnnextOnClick()
	if not self._btnnext.gameObject.activeInHierarchy or self._finishClose then
		return
	end

	if not self:_checkClickCd() then
		return
	end

	if self.viewParam.isClient then
		local dialogParams = string.split(self.viewParam.dialogParam, "#")

		if #dialogParams < self._clientDialogIndex then
			self:closeThis()
		end

		return
	end

	self:_playNextSectionOrDialog()
end

function Activity130DialogView:_checkClickCd()
	local time = Time.time - self._time

	if time < 0.5 then
		return
	end

	self._time = Time.time

	return true
end

function Activity130DialogView:_editableInitView()
	self._time = Time.time
	self._optionBtnList = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._dialogItemCacheList = self:getUserDataTb_()

	gohelper.addUIClickAudio(self._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._nexticon = gohelper.findChild(self.viewGO, "#go_content/nexticon")
end

function Activity130DialogView:onOpen()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.Activity130DialogView, self._onSpace, self)

	if self.viewParam.isClient then
		self._clientDialogIndex = 1
		self.viewContainer:getSetting().viewType = ViewType.Normal

		self:_showClientTalk()
	else
		self._elementInfo = self.viewParam.elementInfo
		self.viewContainer:getSetting().viewType = ViewType.Full

		self:_playStory()
	end
end

function Activity130DialogView:_showClientTalk()
	gohelper.setActive(self._gobottomcontent, false)
	gohelper.setActive(self._gotopcontent, true)

	local dialogParams = string.split(self.viewParam.dialogParam, "#")
	local dialogIds = string.splitToNumber(dialogParams[self._clientDialogIndex], "_")
	local config = Activity130Config.instance:getActivity130DialogCo(dialogIds[1], dialogIds[2])

	self._clientDialogIndex = self._clientDialogIndex + 1
	self._txtdialogdesc.text = config.content

	local params = string.splitToNumber(config.param, "#")
	local path = string.format("singlebg/headicon_small/%s.png", params[1])

	self._simagehead:LoadImage(path)

	if self._audioId and self._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	self._audioId = params[2]

	AudioEffectMgr.instance:playAudio(self._audioId)
end

function Activity130DialogView:_onSpace()
	if not self._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	self:_btnnextOnClick()
end

function Activity130DialogView:_playNextSectionOrDialog()
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

function Activity130DialogView:_playStory(id)
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

function Activity130DialogView:_initHistoryItem()
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

function Activity130DialogView:_addSectionHistory(sectionId, dialogIndex)
	local dialogList = Activity130Config.instance:getDialog(self._dialogId, sectionId)
	local finish = sectionId == self._mainSectionId and dialogIndex > #dialogList or dialogIndex >= #dialogList

	for i, v in ipairs(dialogList) do
		if i < dialogIndex or finish then
			if v.type == Activity130Enum.dialogType.options then
				local optionList = string.split(v.content, "#")
				local sectionIdList = string.split(v.param, "#")
				local allContentList = {}
				local allSectionList = {}

				for j, id in ipairs(sectionIdList) do
					local list = Activity130Config.instance:getDialog(self._dialogId, id)

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
					end
				end

				for j, id in ipairs(allSectionList) do
					local index = self._historyList[id]

					if index then
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

function Activity130DialogView:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function Activity130DialogView:_setSectionData(sectionId, dialogIndex)
	self._sectionList = Activity130Config.instance:getDialog(self._dialogId, sectionId)

	if self._sectionList and not string.nilorempty(self._sectionList.option_param) then
		self._option_param = self._sectionList.option_param
	end

	if not string.nilorempty(self._option_param) then
		self._historyList.option = self._option_param
	end

	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function Activity130DialogView:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	if not config then
		return
	end

	if config.type == Activity130Enum.dialogType.dialog then
		self:_showDialog(Activity130Enum.dialogType.dialog, config.content, config.speaker)

		self._dialogIndex = self._dialogIndex + 1

		if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
			local prevSectionInfo = table.remove(self._sectionStack)

			self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
		end

		self:_refreshDialogBtnState()
	elseif config.type == Activity130Enum.dialogType.option then
		self:_showOptionByConfig(config)
	elseif config.type == Activity130Enum.dialogType.talk then
		self:_showTalk(Activity130Enum.dialogType.talk, config)

		self._dialogIndex = self._dialogIndex + 1

		if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
			local prevSectionInfo = table.remove(self._sectionStack)

			self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
		end

		self:_refreshDialogBtnState()
	end
end

function Activity130DialogView:_showDialog(type, text, speaker)
	if self._audioId and self._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	gohelper.setActive(self._gobottomcontent, true)
	gohelper.setActive(self._gotopcontent, false)
	self:_updateHistory()

	if self._isSkip then
		return
	end

	local item = self:_addDialogItem(type, text, speaker)
end

function Activity130DialogView:_showTalk(type, config)
	gohelper.setActive(self._gobottomcontent, false)
	gohelper.setActive(self._gotopcontent, true)
	self:_updateHistory()

	self._isSkip = false
	self._txtdialogdesc.text = config.content

	local params = string.splitToNumber(config.param, "#")
	local path = string.format("singlebg/headicon_small/%s.png", params[1])

	self._simagehead:LoadImage(path)

	if self._audioId and self._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	self._audioId = params[2]

	if self._audioId > 0 then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function Activity130DialogView:_showOptionByConfig(nextConfig)
	local showOption = false

	if nextConfig and nextConfig.type == Activity130Enum.dialogType.option then
		self:_updateHistory()

		self._dialogIndex = self._dialogIndex + 1

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		self._isSingle = nextConfig.single == 1

		if self._isSkip then
			showOption = true

			self:_refreshDialogBtnState(true)
			self:_skipOption(optionList, sectionIdList)

			return
		else
			self._skipOptionParams = {
				optionList,
				sectionIdList
			}

			for _, v in pairs(self._optionBtnList) do
				gohelper.setActive(v[1], false)
			end

			for i = #optionList, 1, -1 do
				self:_addDialogOption(i, sectionIdList[i], optionList[i])
			end

			gohelper.setActive(self._nexticon, false)
		end

		showOption = true
	end

	self:_refreshDialogBtnState(showOption)
end

function Activity130DialogView:_skipOption(optionList, sectionIdList)
	local optionIndex = 1
	local mapId = Activity130Model.instance:getCurMapId()

	if mapId >= 201 and mapId <= 205 then
		optionIndex = #optionList
	end

	local index, sectionId, text = optionIndex, sectionIdList[optionIndex], optionList[optionIndex]

	self:_onOptionClick({
		sectionId,
		text,
		index
	})
end

function Activity130DialogView:_refreshDialogBtnState(showOption)
	if showOption then
		gohelper.setActive(self._gooptions, true)
	else
		self:_playCloseTalkItemEffect()
	end

	gohelper.setActive(self._txtinfo, not showOption)
	gohelper.setActive(self._btnnext, not showOption)

	if showOption then
		return
	end

	local hasNext = #self._sectionStack > 0 or #self._sectionList >= self._dialogIndex
	local isFinish = not hasNext

	if self._isFinish then
		local player = SLFramework.AnimatorPlayer.Get(self.viewGO)

		player:Play(UIAnimationName.Close, self._fadeOutDone, self)

		self._finishClose = true
	end

	self._isFinish = isFinish
end

function Activity130DialogView:_fadeOutDone()
	if self._elementInfo.config.skipFinish ~= 1 then
		self:_sendFinishDialog()
	end

	local type = self._elementInfo:getNextType()

	if type == Activity130Enum.ElementType.Battle then
		local id = self._elementInfo.elementId

		Activity130DialogView.startBattle(id)
	end

	self:closeThis()
end

function Activity130DialogView:_playCloseTalkItemEffect()
	for k, v in pairs(self._optionBtnList) do
		local talkItemAnim = v[1]:GetComponent(typeof(UnityEngine.Animator))

		talkItemAnim:Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(self._hideOption, self, 0.133)
end

function Activity130DialogView:_hideOption()
	gohelper.setActive(self._gooptions, false)
end

function Activity130DialogView.startBattle(id)
	return
end

function Activity130DialogView:_sendFinishDialog()
	local index = tonumber(self._option_param) or 0
	local list = Activity130Config.instance:getOptionParamList(self._dialogId)

	if list and #list > 0 then
		local optionIndex = 1
		local mapId = Activity130Model.instance:getCurMapId()

		if mapId >= 201 and mapId <= 205 then
			optionIndex = 2
		end

		if index ~= optionIndex then
			index = optionIndex
		end
	end

	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130DialogRequest(actId, episodeId, self._elementInfo.elementId, index)
end

function Activity130DialogView:_addDialogOption(index, sectionId, text)
	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local item = gohelper.cloneInPlace(self._gotalkitem)

			gohelper.setActive(item, true)

			local txt = gohelper.findChildText(item, "txt_talkitem")

			txt.text = text

			local btn = gohelper.findChildButtonWithAudio(item, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

			btn:AddClickListener(self._onOptionClick, self, {
				sectionId,
				text,
				index
			})

			self._optionBtnList[index] = self._optionBtnList[index] or {
				item,
				btn
			}

			if not self._isSingle then
				return
			end

			local mapConfig = Activity130Model.instance:getCurMapConfig()

			if index == 1 then
				local mask = gohelper.findChild(item, "mask")
				local showMask = mapConfig.type ~= 1

				gohelper.setActive(mask, showMask)

				local chaticon = gohelper.findChild(item, "chaticon")

				gohelper.setActive(chaticon, not showMask)
				gohelper.setActive(btn.gameObject, not showMask)
			end

			if index == 2 then
				gohelper.setActive(item, mapConfig.type ~= 1)
			end
		end
	end
end

function Activity130DialogView:_onOptionClick(param)
	self._skipOptionParams = nil

	if not self:_checkClickCd() then
		return
	end

	local sectionId = param[1]
	local text = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", param[2])

	self:_showDialog("option", text)

	self._showOption = true
	self._optionId = param[3]

	self:_checkOption(sectionId)
end

function Activity130DialogView:_checkOption(sectionId)
	local dialogList = Activity130Config.instance:getDialog(self._dialogId, sectionId)

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

function Activity130DialogView:_updateHistory()
	if self._isSkip then
		return
	end

	if self._elementInfo.config.skipFinish == 1 then
		return
	end

	self._historyList[self._sectionId] = self._dialogIndex

	local list = {}

	for k, v in pairs(self._historyList) do
		table.insert(list, string.format("%s#%s", k, v))
	end

	self._elementInfo:updateHistoryList(list)

	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130DialogHistoryRequest(actId, episodeId, self._elementInfo.elementId, list)
end

function Activity130DialogView:_addDialogItem(type, text, speaker)
	if not string.nilorempty(speaker) then
		if not ("<#FAFAFA>" .. speaker .. ":  ") then
			local speakerStr = ""

			self._txtinfo.text = speakerStr .. text

			self._animatorPlayer:Play(UIAnimationName.Click, self._animDone, self)
			gohelper.setActive(self._nexticon, true)
		end
	end
end

function Activity130DialogView:_animDone()
	return
end

function Activity130DialogView:onClose()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._hideOption, self)
end

function Activity130DialogView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return Activity130DialogView
