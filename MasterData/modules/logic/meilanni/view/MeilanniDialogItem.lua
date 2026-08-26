-- chunkname: @modules/logic/meilanni/view/MeilanniDialogItem.lua

module("modules.logic.meilanni.view.MeilanniDialogItem", package.seeall)

local MeilanniDialogItem = class("MeilanniDialogItem", LuaCompBase)

function MeilanniDialogItem:onInitView()
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_content/#go_head/#txt_remaintime")
	self._imageweather = gohelper.findChildImage(self.viewGO, "#go_content/#go_head/#txt_remaintime/#image_weather")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#go_content/#go_desc/#txt_info")
	self._txttemplate = gohelper.findChildText(self.viewGO, "#go_content/#txt_template")
	self._txtnormalevent = gohelper.findChildText(self.viewGO, "#go_content/#go_normal/#txt_normalevent")
	self._txtspecialevent = gohelper.findChildText(self.viewGO, "#go_content/#go_special/#txt_specialevent")
	self._txtoverdueevent = gohelper.findChildText(self.viewGO, "#go_content/#go_overdue/#txt_overdueevent")
	self._gooptions = gohelper.findChild(self.viewGO, "#go_content/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "#go_content/#go_options/#go_talkitem")
	self._gohead = gohelper.findChild(self.viewGO, "#go_content/#go_head")
	self._godesc = gohelper.findChild(self.viewGO, "#go_content/#go_desc")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_content/#go_normal")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_content/#go_special")
	self._gooverdue = gohelper.findChild(self.viewGO, "#go_content/#go_overdue")
	self._goenddaytip = gohelper.findChild(self.viewGO, "#go_content/#go_enddaytip")
	self._txtenddaytip = gohelper.findChildText(self.viewGO, "#go_content/#go_enddaytip/#txt_enddaytip")
	self._goend = gohelper.findChild(self.viewGO, "#go_content/#go_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniDialogItem:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function MeilanniDialogItem:removeEvents()
	self._btnnext:RemoveClickListener()
end

function MeilanniDialogItem:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEvents()
	self:onOpen()
end

function MeilanniDialogItem:onDestroy()
	self:onClose()
	self:removeEvents()
	self:onDestroyView()
end

function MeilanniDialogItem:_btnnextOnClick()
	if not self._btnnext.gameObject.activeInHierarchy or self._finishClose then
		return
	end

	if not self:_checkClickCd() then
		return
	end

	self:_playNextSectionOrDialog()
end

function MeilanniDialogItem:_checkClickCd()
	local time = Time.time - self._time

	if time < 0.5 then
		return
	end

	self._time = Time.time

	return true
end

function MeilanniDialogItem:_editableInitView()
	self._time = Time.time
	self._optionBtnList = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._dialogItemCacheList = self:getUserDataTb_()

	gohelper.addUIClickAudio(self._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._canvasGroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._txtList = self:getUserDataTb_()
end

function MeilanniDialogItem:onOpen()
	return
end

function MeilanniDialogItem:_playNextSectionOrDialog()
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

function MeilanniDialogItem:setEpisodeInfo(info)
	if not info then
		logError("MeilanniDialogItem setEpisodeInfo info is nil")

		return
	end

	self._episodeInfo = info
end

function MeilanniDialogItem:getEpisodeInfo()
	return self._episodeInfo
end

function MeilanniDialogItem:_startFadeIn()
	self._delayFadeTime = nil

	local index = MeilanniModel.instance:getDialogItemFadeIndex()

	if not index then
		return
	end

	self._openFadeIn = true

	if index <= 0 then
		return
	end

	self._animator.enabled = false
	self._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(self._delayFadeIn, self)

	self._delayFadeTime = index * 0.4

	TaskDispatcher.runDelay(self._delayFadeIn, self, self._delayFadeTime)
end

function MeilanniDialogItem:_delayFadeIn()
	self._animator.enabled = true

	self._animator:Play("open", 0, 0)

	self._canvasGroup.alpha = 1
end

function MeilanniDialogItem:playDesc(value)
	self:_startFadeIn()
	gohelper.setActive(self._godesc.gameObject, true)

	self._txtinfo.text = value

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, self)
end

function MeilanniDialogItem:showEpilogue(value)
	self:_startFadeIn()
	gohelper.setActive(self._goenddaytip, true)

	self._txtenddaytip.text = value

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, self)
end

function MeilanniDialogItem:showEndDialog(eventInfo, index, eventIndex)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, self)
	self:_startFadeIn()
	gohelper.setActive(self._goend, true)

	self._endBtn = gohelper.findChildButtonWithAudio(self._goend, "#btn_end", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	self._endBtn:AddClickListener(self._clickEndHandler, self)
	gohelper.setActive(self._endBtn, false)

	local descTxt = gohelper.findChildText(self._goend, "#txt_enddesc")
	local btnTxt = gohelper.findChildText(self._goend, "#btn_end/#txt_endbtndesc")
	local titleTxt = gohelper.findChildText(self._goend, "tag/#txt_endtitle")
	local iconImage = gohelper.findChildImage(self._goend, "#btn_end/icon")

	self._mapId = MeilanniModel.instance:getCurMapId()
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	if self._mapInfo.score <= 0 then
		descTxt.text = luaLang("p_meilannidialogitem_enddesc4")
		btnTxt.text = luaLang("p_meilannidialogitem_endbtn4")
		titleTxt.text = luaLang("p_meilannidialogitem_endtitle4")

		SLFramework.UGUI.GuiHelper.SetColor(btnTxt, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(iconImage, "bg_xuanzhe1")

		self._isFail = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			btnTxt.text,
			self,
			self._clickEndHandler,
			self._delayFadeTime
		})

		return
	end

	local lastConfig = MeilanniConfig.instance:getLastEpisode(self._mapId)
	local episodeConfig = self._episodeInfo.episodeConfig

	if episodeConfig.day == lastConfig.day then
		descTxt.text = self._mapInfo.mapConfig.endContent
		btnTxt.text = luaLang("p_meilannidialogitem_endbtn3")
		titleTxt.text = luaLang("p_meilannidialogitem_endtitle3")

		SLFramework.UGUI.GuiHelper.SetColor(btnTxt, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(iconImage, "bg_xuanzhe1")

		self._isSuccess = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			btnTxt.text,
			self,
			self._clickEndHandler,
			self._delayFadeTime
		})

		return
	end

	if self._mapId < MeilanniEnum.unlockMapId then
		descTxt.text = luaLang("p_meilannidialogitem_enddesc1")
		btnTxt.text = luaLang("p_meilannidialogitem_endbtn1")
		titleTxt.text = luaLang("p_meilannidialogitem_endtitle1")

		SLFramework.UGUI.GuiHelper.SetColor(btnTxt, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(iconImage, "bg_xuanzhe")
	else
		descTxt.text = luaLang("p_meilannidialogitem_enddesc2")
		btnTxt.text = luaLang("p_meilannidialogitem_endbtn2")
		titleTxt.text = luaLang("p_meilannidialogitem_endtitle2")

		SLFramework.UGUI.GuiHelper.SetColor(btnTxt, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(iconImage, "bg_xuanzhe")
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
		btnTxt.text,
		self,
		self._clickEndHandler,
		self._delayFadeTime
	})
end

function MeilanniDialogItem:_clickEndHandler()
	MeilanniAnimationController.instance:startAnimation()
	Activity108Rpc.instance:sendEpisodeConfirmRequest(MeilanniEnum.activityId, self._episodeInfo.episodeId, self._endCallback, self)
end

function MeilanniDialogItem:_endCallback()
	gohelper.destroy(self.viewGO)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, self)

	if self._isFail then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapFail)
	elseif self._isSuccess then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapSuccess)
	end
end

function MeilanniDialogItem:showSkipDialog(eventInfo, index, eventIndex)
	self:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		self:_setDelayShowDialog()

		self._topDialog = true
	end

	self._config = eventInfo.config
	self._curText = self._txtoverdueevent
	self._curText.text = ""

	gohelper.setActive(self._gooverdue, true)

	self._maskline = gohelper.findChild(self._gooverdue, "maskline")

	gohelper.setActive(self._maskline, false)

	local stepConfig = eventInfo:getSkipDialog()

	self:_showDialog(MeilanniEnum.ResultString.dialog, stepConfig.content, stepConfig.speaker)

	local result, scoreResult, featureResult = MeilanniDialogItem.getResult(nil, stepConfig, "")

	if not string.nilorempty(result) then
		self._scoreResult = scoreResult
		self._customDialogTime = MeilanniEnum.selectedTime

		self:_showDialog(MeilanniEnum.ResultString.result, result)
	end
end

function MeilanniDialogItem:clearConfig()
	self._config = nil
	self._content = nil
end

function MeilanniDialogItem:showHistory(eventInfo, index, eventIndex)
	self:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		self:_setDelayShowDialog()
	end

	if not self._config then
		self._config = eventInfo.config

		self:_setText(self._config)
	end

	local interactIndex = index + 1
	local interactParam = eventInfo.interactParam[interactIndex]
	local dialogId = interactParam[2]
	local eventHistory = eventInfo.historylist[index]

	if not eventHistory then
		logError(string.format("MeilanniDialogItem no eventHistory id:%s,index:%s", self._config.id, index))

		return
	end

	local historylist = eventHistory.history

	if not eventInfo._historyResult then
		local result = ""
		local scoreResult, featureResult

		for i, v in ipairs(historylist) do
			local paramList = string.splitToNumber(v, "#")
			local stepId = paramList[1]
			local optionIndex = paramList[2]
			local stepConfig = lua_activity108_dialog.configDict[dialogId][stepId]

			if not stepConfig then
				logError(string.format("MeilanniDialogItem showHistory no stepConfig dialogId:%s,stepId:%s", dialogId, stepId))
			end

			if stepConfig and stepConfig.type == MeilanniEnum.ResultString.dialog then
				self:_showDialog(MeilanniEnum.ResultString.dialog, stepConfig.content, stepConfig.speaker)
			elseif stepConfig and stepConfig.type == MeilanniEnum.ResultString.options then
				local optionList = string.split(stepConfig.content, "#")
				local sectionIdList = string.split(stepConfig.param, "#")
				local option = optionList[optionIndex]
				local sectionId = sectionIdList[optionIndex]

				if option then
					local text = string.format("<color=#B95F0F>\"%s\"</color>", option)

					self:_showDialog(MeilanniEnum.ResultString.options, text)

					if string.len(eventInfo._historyResult) <= 0 then
						local sectionDialog = MeilanniConfig.instance:getDialog(dialogId, sectionId)
						local var_22_0, var_22_1, var_22_2 = MeilanniDialogItem.getResult(eventInfo, sectionDialog, eventInfo._historyResult, true)

						featureResult = var_22_2
						result = var_22_0
						self._scoreResult = var_22_1
						self._featureResult = var_22_2
					end
				end
			end
		end

		if string.len(eventInfo._historyResult) > 0 then
			eventInfo._historyResult = eventInfo._historyResult

			if interactIndex == #eventInfo.interactParam then
				self:_showDialog(MeilanniEnum.ResultString.result, eventInfo._historyResult)
			end
		end
	end
end

function MeilanniDialogItem:isTopDialog()
	return self._topDialog
end

function MeilanniDialogItem:playDialog(param)
	self._topDialog = true
	self._mapElement = param
	self._elementInfo = self._mapElement._info
	self._mapId = MeilanniModel.instance:getCurMapId()
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	local episodeInfo = self._mapInfo:getCurEpisodeInfo()

	if not self._config then
		self._config = self._mapElement._config

		self:_setText(self._config)
	end

	self:_playStory()
end

function MeilanniDialogItem:_setText(config)
	self._curText = config.type == 0 and self._txtnormalevent or self._txtspecialevent
	self._curText.text = ""

	local isNormal = config.type == 0

	gohelper.setActive(self._gonormal, isNormal)
	gohelper.setActive(self._gospecial, not isNormal)
	self:_hideMaskline(config)
end

function MeilanniDialogItem:_hideMaskline(config)
	local isNormal = config.type == 0

	self._maskline = gohelper.findChild((isNormal or nil) and (self._gonormal or self._gospecial), "maskline")

	gohelper.setActive(self._maskline, false)
end

function MeilanniDialogItem:_playStory()
	self._sectionStack = {}
	self._optionId = 0
	self._mainSectionId = "0"
	self._sectionId = self._mainSectionId
	self._dialogIndex = nil
	self._historyList = {}
	self._dialogId = tonumber(self._elementInfo:getParam())
	self._historyList.id = self._dialogId
	self._dialogHistoryList = {}

	self:_playSection(self._sectionId, self._dialogIndex)
end

function MeilanniDialogItem:_initHistoryItem()
	if self._elementInfo then
		if not self._elementInfo or #self._elementInfo == 0 then
			return
		end

		for i, v in ipairs(self._elementInfo) do
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
end

function MeilanniDialogItem:_addSectionHistory(sectionId, dialogIndex)
	local dialogList = MeilanniConfig.instance:getDialog(self._dialogId, sectionId)
	local finish = sectionId == self._mainSectionId and dialogIndex > #dialogList or dialogIndex >= #dialogList

	for i, v in ipairs(dialogList) do
		if (i < dialogIndex or finish) and (v.type ~= MeilanniEnum.ResultString.dialog or true) then
			if v.type == MeilanniEnum.ResultString.options then
				local optionList = string.split(v.content, "#")
				local sectionIdList = string.split(v.param, "#")
				local allContentList = {}
				local allSectionList = {}

				for j, id in ipairs(sectionIdList) do
					local list = MeilanniConfig.instance:getDialog(self._dialogId, id)

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

function MeilanniDialogItem:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function MeilanniDialogItem:_setSectionData(sectionId, dialogIndex)
	self._sectionList = MeilanniConfig.instance:getDialog(self._dialogId, sectionId)

	if self._sectionList and not string.nilorempty(self._sectionList.option_param) then
		self._option_param = self._sectionList.option_param
	end

	if not string.nilorempty(self._option_param) then
		self._historyList.option = self._option_param
	end

	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function MeilanniDialogItem:_autoPlay()
	self:_playNextSectionOrDialog()
end

function MeilanniDialogItem:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	if config and config.type == MeilanniEnum.ResultString.dialog then
		self:_addDialogHistory(config.stepId)
		self:_showDialog(MeilanniEnum.ResultString.dialog, config.content, config.speaker)

		self._dialogIndex = self._dialogIndex + 1

		if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
			local prevSectionInfo = table.remove(self._sectionStack)

			self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
		end

		self:_refreshDialogBtnState()
		self:_autoPlay()
	elseif config and config.type == MeilanniEnum.ResultString.options then
		self:_showOptionByConfig(config)
	end
end

function MeilanniDialogItem:_showOptionByConfig(nextConfig)
	local showOption = false

	if nextConfig and nextConfig.type == MeilanniEnum.ResultString.options then
		self._dialogIndex = self._dialogIndex + 1

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		self._isSingle = nextConfig.single == 1

		if self._isSkip then
			showOption = true

			self:_refreshDialogBtnState(true)

			local index, sectionId, text = 1, sectionIdList[1], optionList[1]

			self:_onOptionClick({
				sectionId,
				text,
				index
			})

			return
		else
			MeilanniController.instance:dispatchEvent(MeilanniEvent.startShowDialogOptionBtn)

			for k, v in pairs(self._optionBtnList) do
				gohelper.setActive(v[1], false)
			end

			local num = #optionList + 1

			for i = 1, #optionList do
				self:_addDialogOption(num, i, sectionIdList[i], optionList[i], nextConfig.stepId)
			end

			self:_addDialogOption(num, num, -1, luaLang("p_meilannidialogitem_shelve"), nextConfig.stepId, "bg_xuanzhe")

			local time = num * MeilanniEnum.optionTime + 1.2

			TaskDispatcher.runDelay(self._setOptionBtnEnabled, self, time)
			MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, self)
		end

		showOption = true
	end

	self:_refreshDialogBtnState(showOption)
end

function MeilanniDialogItem:_setOptionBtnEnabled()
	for k, v in pairs(self._optionBtnList) do
		local btn = v[2]

		btn.button.enabled = true
	end
end

function MeilanniDialogItem:_refreshDialogBtnState(showOption)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.refreshDialogBtnState, showOption)
	gohelper.setActive(self._gooptions, showOption)

	if showOption then
		return
	end

	local hasNext = #self._sectionStack > 0 or #self._sectionList >= self._dialogIndex
	local isFinish = not hasNext

	if self._isFinish then
		self:_fadeOutDone()

		self._finishClose = true
	end

	self._isFinish = isFinish
end

function MeilanniDialogItem:_fadeOutDone()
	if self._config.skipFinish ~= 1 then
		self:_sendFinishDialog()
	end

	TaskDispatcher.runDelay(self._startBattle, self, 1.5)
end

function MeilanniDialogItem:_startBattle()
	local type = self._elementInfo:getNextType()

	if type == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(self._config.id)
	end
end

function MeilanniDialogItem:_playCloseTalkItemEffect()
	for k, v in pairs(self._optionBtnList) do
		local talkItemAnim = v[1]:GetComponent(typeof(UnityEngine.Animator))

		talkItemAnim:Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(self._hideOption, self, 0.133)
end

function MeilanniDialogItem:_hideOption()
	gohelper.setActive(self._gooptions, false)
end

function MeilanniDialogItem.startBattle(id)
	return
end

function MeilanniDialogItem:_sendFinishDialog()
	MeilanniAnimationController.instance:startAnimation()
	self:_setDelayShowDialog()
	MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
	Activity108Rpc.instance:sendDialogEventSelectRequest(MeilanniEnum.activityId, self._config.id, self._dialogHistoryList, tonumber(self._option_param) or 0)
end

local defaultFeatureTxtColor = "#225D23"

function MeilanniDialogItem.getResult(elementInfo, sectionDialog, optionText, isFightSuccess, exteralParams)
	local resultList = string.splitToNumber(sectionDialog.result, "#")
	local scoreResult, featureResult

	if resultList[1] == MeilanniEnum.ResultType.score then
		local score = resultList[2]

		if score == 0 then
			optionText = formatLuaLang("meilannidialogitem_noscore", optionText)
		else
			local scoreStr = MeilanniController.getScoreDesc(score)

			optionText = string.format("%s  %s", optionText, scoreStr)
		end

		scoreResult = score
	elseif resultList[1] == MeilanniEnum.ResultType.feature then
		local config = lua_activity108_rule.configDict[resultList[2]]
		local ruleId = tonumber(config.rules)
		local ruleCo = lua_rule.configDict[ruleId]

		if exteralParams then
			if not exteralParams.featureTxtColor then
				local txtColor = defaultFeatureTxtColor
				local tag = {
					optionText,
					txtColor,
					ruleCo.name
				}

				optionText = GameUtil.getSubPlaceholderLuaLang(luaLang("meilannidialogitem_eliminat"), tag)
				featureResult = true
			end
		end
	elseif elementInfo and elementInfo:getConfigBattleId() then
		optionText = isFightSuccess and formatLuaLang("meilannidialogitem_fightsuccess", optionText) or formatLuaLang("meilannidialogitem_fight", optionText)
	end

	return optionText, scoreResult, featureResult
end

function MeilanniDialogItem._setAnimatorEnabled(animator)
	animator.enabled = true
end

function MeilanniDialogItem:_addDialogOption(num, index, sectionId, text, stepId, iconName)
	local param = {
		sectionId,
		text,
		index,
		stepId,
		num,
		iconName
	}

	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogOptionBtn, {
		param,
		self,
		self._onOptionClick
	})
end

function MeilanniDialogItem:_setDelayShowDialog()
	self._delayStartTime = self._delayStartTime or Time.realtimeSinceStartup
	self._delayShowDialogList = self._delayShowDialogList or {}
end

function MeilanniDialogItem:_getDelayShowDialogList()
	return self._delayShowDialogList
end

function MeilanniDialogItem:_onOptionClick(param)
	if not self:_checkClickCd() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	local sectionId = param[1]

	if sectionId == -1 then
		gohelper.destroy(self.viewGO)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, self)

		return
	end

	MeilanniAnimationController.instance:startAnimation()
	self:_setDelayShowDialog()

	local text = string.format("<color=#B95F0F>\"%s\"</color>", param[2])

	self:_addDialogHistory(param[4], param[3])
	self:_showDialog(MeilanniEnum.ResultString.options, text)

	self._showOption = true
	self._optionId = param[3]

	self:_checkOption(sectionId)
end

function MeilanniDialogItem:_addDialogHistory(stepId, optionIndex)
	if optionIndex then
		table.insert(self._dialogHistoryList, string.format("%s#%s", stepId, optionIndex))
	else
		table.insert(self._dialogHistoryList, tostring(stepId))
	end
end

function MeilanniDialogItem:_checkOption(sectionId)
	local dialogList = MeilanniConfig.instance:getDialog(self._dialogId, sectionId)

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

function MeilanniDialogItem:_showDialog(type, text, speaker)
	if self._isSkip then
		return
	end

	if string.nilorempty(text) or self._txtList[text] then
		return
	end

	local delayList = self:_getDelayShowDialogList()

	if not delayList then
		self:_addDialogItem(type, text, speaker)

		return
	end

	MeilanniAnimationController.instance:startDialogListAnim()
	table.insert(delayList, {
		type,
		text,
		speaker,
		type == MeilanniEnum.ResultString.result
	})
	TaskDispatcher.runRepeat(self._showDelayDialog, self, 0)
end

function MeilanniDialogItem:_showDelayDialog()
	local delayList = self:_getDelayShowDialogList()

	if not self._customDialogTime then
		local time = MeilanniEnum.dialogTime

		if delayList and #delayList ~= 0 then
			local param = delayList[1]
			local isResult = param[4]

			if isResult then
				time = self._customDialogTime + MeilanniEnum.resultTime
			end
		end

		if delayList and self._customDialogTime <= Time.realtimeSinceStartup - self._delayStartTime then
			self._delayStartTime = Time.realtimeSinceStartup

			if #delayList <= 0 then
				TaskDispatcher.cancelTask(self._showDelayDialog, self)
				MeilanniAnimationController.instance:endDialogListAnim()

				return
			end

			local param = table.remove(delayList, 1)

			if param then
				local type, text, speaker = param[1], param[2], param[3]

				self:_addDialogItem(type, text, speaker)
			end
		end
	end
end

function MeilanniDialogItem:_updateHistory()
	if self._isSkip then
		return
	end

	if self._config.skipFinish == 1 then
		return
	end

	self._historyList[self._sectionId] = self._dialogIndex

	local list = {}

	for k, v in pairs(self._historyList) do
		table.insert(list, string.format("%s#%s", k, v))
	end
end

function MeilanniDialogItem:_addDialogItem(type, text, speaker)
	if string.nilorempty(text) then
		return
	end

	if string.nilorempty(self._content) then
		self._content = text
		self._eventIndexDesc = nil
	else
		self._content = string.format("%s\n%s", self._content, text)
	end

	if not self._txtList[text] then
		local go = gohelper.clone(self._txttemplate.gameObject, self._curText.transform.parent.gameObject)

		gohelper.setActive(go, true)

		local txt = go:GetComponent(gohelper.Type_TextMesh)

		txt.text = text

		local animator = go:GetComponent(typeof(UnityEngine.Animator))
		local animName = "fade"

		if type == MeilanniEnum.ResultString.dialog then
			local materialPropsCtrl = go:GetComponent(typeof(ZProj.MaterialPropsCtrl))
			local mats = materialPropsCtrl.mas

			mats:Clear()
			mats:Add(txt.fontMaterial)

			animName = "open"
		elseif type == MeilanniEnum.ResultString.result then
			if MeilanniAnimationController.instance:isPlayingDialogListAnim() then
				if self._scoreResult and self._scoreResult > 0 then
					local effect = gohelper.findChild(go, "vx/1")

					gohelper.setActive(effect, true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
				elseif self._scoreResult and self._scoreResult < 0 then
					local effect = gohelper.findChild(go, "vx/2")

					gohelper.setActive(effect, true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
				elseif self._scoreResult and self._scoreResult == 0 then
					local effect = gohelper.findChild(go, "vx/4")

					gohelper.setActive(effect, true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_no_effect)
				elseif self._featureResult then
					local effect = gohelper.findChild(go, "vx/3")

					gohelper.setActive(effect, true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_remove_effect)
				end

				self._scoreResult = nil
				self._featureResult = nil
				self._topDialog = false
			end

			if self._maskline then
				gohelper.setActive(self._maskline, true)
			end
		end

		animator:Play((self._openFadeIn or nil) and "idle")

		self._txtList[text] = true
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, self)
end

function MeilanniDialogItem:onClose()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
		TaskDispatcher.cancelTask(MeilanniDialogItem._setAnimatorEnabled, v[3])
	end

	if self._endBtn then
		self._endBtn:RemoveClickListener()

		self._endBtn = nil
	end

	TaskDispatcher.cancelTask(self._hideOption, self)
	TaskDispatcher.cancelTask(self._delayFadeIn, self)
	TaskDispatcher.cancelTask(self._showDelayDialog, self)
	TaskDispatcher.cancelTask(self._startBattle, self)
	TaskDispatcher.cancelTask(self._setOptionBtnEnable, self)
end

function MeilanniDialogItem:onDestroyView()
	return
end

return MeilanniDialogItem
