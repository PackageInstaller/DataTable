-- chunkname: @modules/logic/meilanni/view/MeilanniSettlementView.lua

module("modules.logic.meilanni.view.MeilanniSettlementView", package.seeall)

local MeilanniSettlementView = class("MeilanniSettlementView", BaseView)

function MeilanniSettlementView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._imagecurscore = gohelper.findChildImage(self.viewGO, "left/score/bg/#image_curscore")
	self._goscorestep = gohelper.findChild(self.viewGO, "left/score/scorerange/#go_scorestep")
	self._txtcurscore = gohelper.findChildText(self.viewGO, "left/score/#txt_curscore")
	self._simagerating = gohelper.findChildSingleImage(self.viewGO, "left/#simage_rating")
	self._simageratingfail = gohelper.findChildSingleImage(self.viewGO, "left/#simage_rating_fail")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "left/#simage_icon")
	self._scrolldays = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_days")
	self._godayitem = gohelper.findChild(self.viewGO, "right/#scroll_days/Viewport/Content/#go_dayitem")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_next")
	self._btnfront = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_front")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniSettlementView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfront:AddClickListener(self._btnfrontOnClick, self)
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
end

function MeilanniSettlementView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfront:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
end

function MeilanniSettlementView:_btnclose1OnClick()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function MeilanniSettlementView:_btncloseOnClick()
	return
end

function MeilanniSettlementView:_btnnextOnClick()
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(self._aniDone, self, 0.5)

	self._episodeIndex = self._episodeIndex + 1

	self._animator:Play("fanye_left", 0, 0)
	self:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function MeilanniSettlementView:_btnfrontOnClick()
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(self._aniDone, self, 0.5)

	self._episodeIndex = self._episodeIndex - 1

	self._animator:Play("fanye_right", 0, 0)
	self:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function MeilanniSettlementView:_aniDone()
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function MeilanniSettlementView:_editableInitView()
	gohelper.setActive(self._godayitem, false)

	local rightGo = gohelper.findChild(self.viewGO, "right")

	self._animator = rightGo:GetComponent(typeof(UnityEngine.Animator))

	local animationEventWrap = rightGo:GetComponent(typeof(ZProj.AnimationEventWrap))

	animationEventWrap:AddEventListener("right", self._onFlipOver, self)
	animationEventWrap:AddEventListener("left", self._onFlipOver, self)
end

function MeilanniSettlementView:_onFlipOver()
	self:_updateBtns()
end

function MeilanniSettlementView:_updateBtns(skipShowHistory)
	gohelper.setActive(self._btnnext.gameObject, self._episodeIndex < self._episodeNum)
	gohelper.setActive(self._btnfront.gameObject, self._episodeIndex > 1)

	if skipShowHistory then
		return
	end

	for i, v in ipairs(self._episodeHistory) do
		gohelper.setActive(v, i == self._episodeIndex)
	end

	self:_showEpisodeHistory(self._episodeIndex)
end

function MeilanniSettlementView:onOpen()
	self._mapId = self.viewParam
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)
	self._mapConfig = self._mapInfo.mapConfig
	self._episodeHistory = self:getUserDataTb_()
	self._eventItemList = self:getUserDataTb_()
	self._episodeNum = #self._mapInfo.episodeInfos
	self._episodeIndex = 1

	local maxScore = 100
	local curScore = math.max(0, self._mapInfo.score)

	curScore = math.min(curScore, maxScore)
	self._txtcurscore.text = string.format("<#8d3032><size=43>%s</size></color>/%s", curScore, maxScore)

	local scoreIndex = MeilanniConfig.instance:getScoreIndex(curScore)

	if curScore <= 0 then
		self._simageratingfail:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_shibai_4"))
		gohelper.setActive(self._simageratingfail, true)
		gohelper.setActive(self._simagerating, false)
	else
		self._simagerating:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_chenggong_" .. tostring(scoreIndex)))
	end

	self._simageicon:LoadImage(ResUrl.getMeilanniIcon(self._mapConfig.exhibits))
	self:_initScores(curScore)

	self._curScore = curScore
	self._imagecurscore.fillAmount = 0

	self:_updateBtns()

	if curScore == 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)

		return
	end

	TaskDispatcher.runDelay(self._delayStartShowProgress, self, 0.3)
end

function MeilanniSettlementView:_delayStartShowProgress()
	self._audioId = AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_progress_grow)
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.7, self._onFrame, self._showFinish, self, nil, EaseType.Linear)
end

function MeilanniSettlementView:_showFinish()
	AudioMgr.instance:stopPlayingID(self._audioId)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function MeilanniSettlementView:_onFrame(value)
	self._imagecurscore.fillAmount = value * self._targetFillAmount

	local curScore = value * self._curScore

	for i, v in ipairs(self._gradleList) do
		local t = self._ratingTxtList[i]
		local ratingTxt = t and t[1]

		if ratingTxt and curScore >= v.score then
			ratingTxt.color = GameUtil.parseColor("#903C3C")

			gohelper.setActive(t[2], true)

			self._ratingTxtList[i] = nil
		end
	end
end

function MeilanniSettlementView:_initScores(curScore)
	local ratingList = {
		"",
		"A",
		"B",
		"C"
	}
	local posXList = {
		442,
		442,
		272,
		115
	}
	local progressList = {
		1,
		0.844,
		0.54,
		0.26
	}
	local matchRatingIndex
	local rawGradleList = MeilanniConfig.instance:getGradleList(self._mapId)
	local gradleList = {
		{
			score = 100
		}
	}

	tabletool.addValues(gradleList, rawGradleList)

	self._gradleList = gradleList
	self._ratingTxtList = self:getUserDataTb_()

	for i, v in ipairs(self._gradleList) do
		local rating = ratingList[i]

		if not string.nilorempty(rating) then
			local go = gohelper.cloneInPlace(self._goscorestep)

			gohelper.setActive(go, true)

			local valueTxt = gohelper.findChildText(go, "txt_value")
			local ratingTxt = gohelper.findChildText(go, "txt_rating")
			local goachive = gohelper.findChild(go, "go_achive")

			gohelper.setActive(goachive, false)

			valueTxt.text = v.score
			ratingTxt.text = ratingList[i]

			recthelper.setAnchorX(go.transform, posXList[i])

			self._ratingTxtList[i] = {
				ratingTxt,
				goachive
			}
		end

		if curScore >= v.score then
			matchRatingIndex = matchRatingIndex or i
		end
	end

	if matchRatingIndex == 1 then
		self._targetFillAmount = progressList[matchRatingIndex]
		self._imagecurscore.fillAmount = self._targetFillAmount

		return
	end

	local startProgress, endProgress, startScore, endScore

	if not matchRatingIndex then
		startProgress = 0
		endProgress = progressList[#progressList]
		startScore = 0
		endScore = gradleList[#gradleList].score
	else
		startProgress = progressList[matchRatingIndex]
		endProgress = progressList[matchRatingIndex - 1]
		startScore = gradleList[matchRatingIndex].score
		endScore = gradleList[matchRatingIndex - 1].score
	end

	local progress = (curScore - startScore) / (endScore - startScore)

	self._targetFillAmount = (endProgress - startProgress) * progress + startProgress
	self._imagecurscore.fillAmount = self._targetFillAmount
end

function MeilanniSettlementView:_showCookieContent(content, eventItem)
	local eventItem = gohelper.cloneInPlace(eventItem)

	gohelper.setActive(eventItem, true)

	local descTxt = gohelper.findChildText(eventItem, "txt_desc")

	descTxt.text = content
end

function MeilanniSettlementView:_showEpisodeHistory(episodeIndex)
	local dialogItem = self._episodeHistory[episodeIndex]

	if dialogItem then
		return
	end

	dialogItem = self:_getDialogItem()
	self._episodeHistory[episodeIndex] = dialogItem

	local episodeInfo = self._mapInfo.episodeInfos[episodeIndex]

	self:_showTitle(episodeInfo, dialogItem)

	local eventItem = gohelper.findChild(dialogItem, "events/go_eventitem")

	gohelper.setActive(eventItem, false)

	if episodeIndex == 1 and self._curScore >= self._mapConfig.cookie then
		self:_showCookieContent(self._mapConfig.cookieContent, eventItem)
	end

	local eventIndex = 1
	local len = #episodeInfo.historylist

	for i, episodeHistory in ipairs(episodeInfo.historylist) do
		local eventId = episodeHistory.eventId
		local index = episodeHistory.index
		local eventInfo = episodeInfo:getEventInfo(eventId)
		local interactParam = eventInfo.interactParam[index + 1]
		local interactType = interactParam[1]

		if interactType == MeilanniEnum.ElementType.Dialog then
			self:_showEvent(eventInfo, eventItem, index, eventIndex, i == len)

			eventIndex = eventIndex + 1
		end
	end

	for i, eventInfo in ipairs(episodeInfo.events) do
		if not eventInfo.isFinish and eventInfo:getSkipDialog() then
			self:_showSkipDialog(eventInfo, eventItem, nil, eventIndex)

			eventIndex = eventIndex + 1
		end
	end
end

function MeilanniSettlementView:_showTitle(episodeInfo, dialogItem)
	local episodeConfig = episodeInfo.episodeConfig
	local txt = gohelper.findChildText(dialogItem, "title/txt_countdown")

	txt.text = episodeConfig.mapId <= 102 and formatLuaLang("meilannisettlementview_countdown", episodeConfig.day) or formatLuaLang("meilannisettlementview_countdown2", episodeConfig.day)

	local weather = gohelper.findChildImage(dialogItem, "title/txt_countdown/image_weather")

	if episodeConfig.period == 1 then
		UISpriteSetMgr.instance:setMeilanniSprite(weather, "bg_tianqi_settlement_2")
	else
		UISpriteSetMgr.instance:setMeilanniSprite(weather, "bg_tianqi_settlement_1")
	end
end

function MeilanniSettlementView:_getEventItem(eventId, eventItemGo)
	local eventItem = self._eventItemList[eventId]

	if not eventItem then
		eventItem = gohelper.cloneInPlace(eventItemGo)

		gohelper.setActive(eventItem, true)

		self._eventItemList[eventId] = eventItem

		local descTxt = gohelper.findChildText(eventItem, "txt_desc")

		descTxt.text = ""
	end

	return eventItem
end

MeilanniSettlementView.DialogExteralParams = {
	featureTxtColor = "#27682E"
}

function MeilanniSettlementView:_showSkipDialog(eventInfo, eventItem, index, eventIndex, lastOne)
	local eventItem = self:_getEventItem(eventInfo.eventId, eventItem)
	local descTxt = gohelper.findChildText(eventItem, "txt_desc")
	local stepConfig = eventInfo:getSkipDialog()
	local content = stepConfig.content
	local resultList = string.splitToNumber(stepConfig.result, "#")
	local result = MeilanniDialogItem.getResult(nil, stepConfig, "", nil, MeilanniSettlementView.DialogExteralParams)

	if not string.nilorempty(result) then
		content = string.format("%s%s", content, result)
	end

	descTxt.text = content
end

function MeilanniSettlementView:_showEvent(eventInfo, eventItem, index, eventIndex, lastOne)
	local eventItem = self:_getEventItem(eventInfo.eventId, eventItem)
	local descTxt = gohelper.findChildText(eventItem, "txt_desc")
	local score = 0
	local content = descTxt.text
	local interactIndex = index + 1
	local interactParam = eventInfo.interactParam[interactIndex]
	local dialogId = interactParam[2]
	local eventHistory = eventInfo.historylist[index]
	local historylist = eventHistory.history

	if not eventInfo._historyResult then
		local result = ""

		for i, v in ipairs(historylist) do
			local paramList = string.splitToNumber(v, "#")
			local stepId = paramList[1]
			local optionIndex = paramList[2]
			local stepConfig = lua_activity108_dialog.configDict[dialogId][stepId]

			if stepConfig.type == "dialog" and not string.nilorempty(stepConfig.content) then
				content = string.nilorempty(content) and stepConfig.content or string.format("%s\n%s", content, stepConfig.content)
			elseif stepConfig.type == "options" then
				local optionList = string.split(stepConfig.content, "#")
				local sectionIdList = string.split(stepConfig.param, "#")
				local sectionId = sectionIdList[optionIndex]
				local option = optionList[optionIndex]
				local sectionDialog = MeilanniConfig.instance:getDialog(dialogId, sectionId)
				local resultList = string.splitToNumber(sectionDialog.result, "#")

				if option then
					local text = string.format("<size=26><color=#834d30>\"%s\"</color></size>", option)

					content = string.format("%s\n%s", content, text)

					if string.len(eventInfo._historyResult) <= 0 then
						local sectionDialog = MeilanniConfig.instance:getDialog(dialogId, sectionId)

						result = MeilanniDialogItem.getResult(eventInfo, sectionDialog, eventInfo._historyResult, true, MeilanniSettlementView.DialogExteralParams)
					end
				end

				if resultList[1] == MeilanniEnum.ResultType.score then
					score = resultList[2]
				end
			end
		end

		if string.len(eventInfo._historyResult) > 0 then
			eventInfo._historyResult = eventInfo._historyResult

			if interactIndex == #eventInfo.interactParam then
				content = string.format("%s%s", content, eventInfo._historyResult)
			end
		end

		descTxt.text = content
	end
end

function MeilanniSettlementView:_getDialogItem()
	local dayItem = gohelper.cloneInPlace(self._godayitem)

	gohelper.setActive(dayItem, true)

	return dayItem
end

function MeilanniSettlementView:onClose()
	TaskDispatcher.cancelTask(self._delayStartShowProgress, self)
	TaskDispatcher.cancelTask(self._aniDone, self)
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function MeilanniSettlementView:onDestroyView()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	self._simagerating:UnLoadImage()
	self._simageicon:UnLoadImage()
end

return MeilanniSettlementView
