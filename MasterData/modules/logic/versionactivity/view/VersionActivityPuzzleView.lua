-- chunkname: @modules/logic/versionactivity/view/VersionActivityPuzzleView.lua

module("modules.logic.versionactivity.view.VersionActivityPuzzleView", package.seeall)

local VersionActivityPuzzleView = class("VersionActivityPuzzleView", BaseView)

function VersionActivityPuzzleView:onInitView()
	self._goclose = gohelper.findChild(self.viewGO, "#go_close")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "#simage_bg/#txt_title")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#simage_bg/Scroll View/Viewport/Content/#txt_info")
	self._gooptions = gohelper.findChild(self.viewGO, "#simage_bg/#go_options")
	self._gooptionitem = gohelper.findChild(self.viewGO, "#simage_bg/#go_options/#go_optionitem")
	self._godragoptionitem = gohelper.findChild(self.viewGO, "#simage_bg/#go_dragoptionitem")
	self._goadsorbrect = gohelper.findChild(self.viewGO, "#simage_bg/#go_adsorbrect")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._txtgamename = gohelper.findChildText(self.viewGO, "#simage_bg/#txt_gamename")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityPuzzleView:addEvents()
	return
end

function VersionActivityPuzzleView:removeEvents()
	return
end

VersionActivityPuzzleView.AnswerAnchorPosDict = {
	[1101] = Vector2(-58.7, 115.3),
	[1102] = Vector2(19, 116.3),
	[1103] = Vector2(-83.34, 76.9)
}
VersionActivityPuzzleView.OneCharacterWidth = 30
VersionActivityPuzzleView.FingerAnswerOffsetX = 77
VersionActivityPuzzleView.FingerAnswerOffsetY = -160
VersionActivityPuzzleView.FingerOptionOffsetX = 150
VersionActivityPuzzleView.FingerOptionOffsetY = -250
VersionActivityPuzzleView.AbsorbOffsetX = 20
VersionActivityPuzzleView.AbsorbOffsetY = 10
VersionActivityPuzzleView.SpritePlaceholder = 10

function VersionActivityPuzzleView:closeViewOnClick()
	self:closeThis()
end

function VersionActivityPuzzleView:_editableInitView()
	self._goGuide = gohelper.findChild(self.viewGO, "guide_activitypuzzle")

	gohelper.setActive(self._godragoptionitem, false)
	gohelper.setActive(self._goadsorbrect, false)

	self.goAdsorbSuccess = gohelper.findChild(self.viewGO, "#simage_bg/#go_adsorbrect/success")
	self.goAdsorbFail = gohelper.findChild(self.viewGO, "#simage_bg/#go_adsorbrect/fail")

	self:resetAdsorbEffect()

	self.goGuideAnimationContainer = gohelper.findChild(self.viewGO, "guide_activitypuzzle/guide1")
	self.goGuideAnimator = self.goGuideAnimationContainer:GetComponent(typeof(UnityEngine.Animator))
	self.goAnswerRect = gohelper.findChild(self.viewGO, "guide_activitypuzzle/guide1/kuang1")
	self.goOptionRect = gohelper.findChild(self.viewGO, "guide_activitypuzzle/guide1/kuang2")
	self.goFinger = gohelper.findChild(self.viewGO, "guide_activitypuzzle/guide1/shouzhi")
	self.rectTransformAnswer = self.goAnswerRect.transform
	self.rectTransformOption = self.goOptionRect.transform
	self.rectTransformFinger = self.goFinger.transform

	self:initDragOptionItem()
	self:initTextScrollViewScenePosRect()
	gohelper.setActive(self._gofinish, false)

	self.bgHalfWidth = recthelper.getWidth(self._simagebg.transform) / 2
	self.bgHalfHeight = recthelper.getHeight(self._simagebg.transform) / 2
	self.closeViewClick = gohelper.getClick(self._goclose)

	self.closeViewClick:AddClickListener(self.closeViewOnClick, self)

	self.optionItemList = {}
	self.answerExistOptionItemDict = {}
	self.needAnswerList = {}
	self.answerMatched = false
end

function VersionActivityPuzzleView:initDragOptionItem()
	self.dragOptionItem = self:getUserDataTb_()
	self.dragOptionItem.go = self._godragoptionitem
	self.dragOptionItem.txtInfo = gohelper.findChildText(self.dragOptionItem.go, "info")
	self.dragOptionItem.transform = self.dragOptionItem.go.transform
end

function VersionActivityPuzzleView:initTextScrollViewScenePosRect()
	self.goScroll = gohelper.findChild(self.viewGO, "#simage_bg/Scroll View")

	local worldCorners = self.goScroll.transform:GetWorldCorners()
	local LT = worldCorners[0]
	local RT = worldCorners[1]
	local RB = worldCorners[2]
	local LB = worldCorners[3]

	self.textScrollScenePosRect = {
		LT,
		RT,
		RB,
		LB
	}
end

function VersionActivityPuzzleView:onUpdateParam()
	return
end

function VersionActivityPuzzleView:onOpen()
	self.isFinish = self.viewParam.isFinish
	self.elementCo = self.viewParam.elementCo
	self.puzzleId = tonumber(self.elementCo.param)
	self.puzzleConfig = lua_version_activity_puzzle_question.configDict[self.puzzleId]
	self._txtgamename.text = self.puzzleConfig.tittle

	if self.puzzleConfig == nil then
		logError(string.format("not found puzzleId : %s, elementId : %s", self.puzzleId, self.elementCo.id))
		self:closeThis()

		return
	end

	self.options, self.maxAnswerLenList = self:buildOptions(self.puzzleConfig.answer)
	self.halfAnsWerHeight = recthelper.getHeight(self._goadsorbrect.transform) * 0.5

	if self.isFinish then
		self:refreshFinishStatus()
	else
		self:refreshNormalStatus()
	end
end

function VersionActivityPuzzleView:refreshFinishStatus()
	local finishAnimator = self._gofinish:GetComponent(typeof(UnityEngine.Animator))

	if finishAnimator then
		finishAnimator.enabled = false
	end

	gohelper.setActive(self._gofinish, true)

	self.showText = self:buildFinishText(self.puzzleConfig.text)

	self:onTextInfoChange()
	self:refreshOptions()
end

function VersionActivityPuzzleView:refreshNormalStatus()
	self.showText = self:buildText(self.puzzleConfig.text)

	self:onTextInfoChange()
	self:refreshOptions()

	local isShowGuide = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 0) == 0

	gohelper.setActive(self._goGuide, false)

	if isShowGuide then
		UIBlockMgr.instance:startBlock(self.viewName .. "PlayGuideAnimation")
		TaskDispatcher.runDelay(self.showGuide, self, 0.7)
	end
end

function VersionActivityPuzzleView:showGuide()
	UIBlockMgr.instance:endBlock(self.viewName .. "PlayGuideAnimation")
	gohelper.setActive(self._goGuide, true)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 1)

	self.guideBlock = gohelper.findChild(self.viewGO, "guide_activitypuzzle/guide_block")
	self.guideClick = gohelper.getClick(self.guideBlock)

	self.guideClick:AddClickListener(self.onClickGuideGo, self)

	local answerAnchor = VersionActivityPuzzleView.AnswerAnchorPosDict[self.puzzleId]

	recthelper.setWidth(self.rectTransformAnswer, self:getAnswerWidth(1))
	recthelper.setAnchor(self.rectTransformAnswer, answerAnchor.x, answerAnchor.y)

	local optionScreenPos = self.optionItemList[self.firstAnswerIndex]:getScreenPos()

	self.optionAnchor = recthelper.screenPosToAnchorPos(optionScreenPos, self.rectTransformOption.parent)

	recthelper.setAnchor(self.rectTransformOption, self.optionAnchor.x, self.optionAnchor.y)
	self.goGuideAnimator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(self.playGuideAnimation, self, 1)
end

function VersionActivityPuzzleView:playGuideAnimation()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	recthelper.setAnchor(self.rectTransformFinger, self.optionAnchor.x + VersionActivityPuzzleView.FingerOptionOffsetX, self.optionAnchor.y + VersionActivityPuzzleView.FingerOptionOffsetY)

	local answerAnchor = VersionActivityPuzzleView.AnswerAnchorPosDict[self.puzzleId]

	self.tweenId = ZProj.TweenHelper.DOAnchorPos(self.rectTransformFinger, answerAnchor.x + VersionActivityPuzzleView.FingerAnswerOffsetX, answerAnchor.y + VersionActivityPuzzleView.FingerAnswerOffsetY, 1.667, self.playGuideAnimation, self)

	self.goGuideAnimator:Play(UIAnimationName.Loop, 0, 0)
end

function VersionActivityPuzzleView:stopGuideAnimation()
	TaskDispatcher.cancelTask(self.playGuideAnimation, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.goGuideAnimator.enabled = false
end

function VersionActivityPuzzleView:onTextInfoChange()
	self._txtinfo.text = self.showText
end

function VersionActivityPuzzleView:buildOptions(optionStr)
	optionStr = string.trim(optionStr)

	local maxAnswerLen = 0
	local answer
	local optionList = {}
	local maxLenList = {}

	for index, option in ipairs(string.split(optionStr, "|")) do
		answer = string.split(option, "#")[2]
		maxAnswerLen = Mathf.Max(maxAnswerLen, GameUtil.utf8len(answer))

		if index % 4 == 0 then
			if maxAnswerLen % 2 ~= 0 then
				maxAnswerLen = maxAnswerLen + 1
			end

			maxAnswerLen = maxAnswerLen + 1

			table.insert(maxLenList, maxAnswerLen)

			maxAnswerLen = 0
		end

		table.insert(optionList, answer)
	end

	return optionList, maxLenList
end

function VersionActivityPuzzleView:buildText(text)
	self.placeholderDict = {}

	local index = 0

	for answerIndex in string.gmatch(text, "{(%d+)}") do
		local answer = tonumber(answerIndex)

		table.insert(self.needAnswerList, answer)

		index = index + 1

		self:buildPlaceholder(answer, index)

		text = string.gsub(text, "{(%d+)}", self:addUnderlineTag(string.format("<link=%s>%s</link>", "%1", self.placeholderDict[answer])), 1)
	end

	self.firstAnswerIndex = self.needAnswerList[1]

	return text
end

function VersionActivityPuzzleView:buildFinishText(text)
	for answerIndex in string.gmatch(text, "{(%d+)}") do
		answerIndex = tonumber(answerIndex)
		text = string.gsub(text, "{(%d+)}", self:addUnderlineTag(string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, self.options[answerIndex])), 1)
	end

	return text
end

function VersionActivityPuzzleView:addUnderlineTag(text)
	return string.format("<u>%s</u>", text)
end

function VersionActivityPuzzleView:buildPlaceholder(answer, index)
	if self.placeholderDict[answer] then
		return
	end

	local maxLen = self.maxAnswerLenList[index]
	local halfLen = math.floor((maxLen - 1) / 2)
	local leftPlaceholder = string.rep(luaLang("lei_mi_te_bei_placeholder"), halfLen)
	local rightPlaceholder = leftPlaceholder

	self.placeholderDict[answer] = leftPlaceholder .. string.format("<sprite name=\"num%s\">", index) .. rightPlaceholder
end

function VersionActivityPuzzleView:refreshOptions()
	local optionItem

	for index, optionText in ipairs(self.options) do
		optionItem = self.optionItemList[index]

		if not self.optionItemList[index] then
			optionItem = self:createOptionItem()

			table.insert(self.optionItemList, optionItem)
		end

		optionItem:updateInfo(optionText, index)
	end

	for index = #self.options + 1, #self.optionItemList do
		optionItem = self.optionItemList[index]

		self.optionItemList[index]:hide()
	end
end

function VersionActivityPuzzleView:createOptionItem()
	local optionItem = VersionActivityPuzzleOptionItem.New()

	optionItem:onInitView(gohelper.cloneInPlace(self._gooptionitem), self)

	return optionItem
end

function VersionActivityPuzzleView:onDragItemDragBegin(pointerEventData, txtInfo, answerIndex)
	if self.complete or self.isFinish then
		return
	end

	gohelper.setActive(self.dragOptionItem.go, true)

	self.dragOptionItem.txtInfo.text = txtInfo
	self.draggingAnswerIndex = answerIndex

	self:changeDragItemAnchor(pointerEventData)
	self:calculateLinksRectAnchor()
	self:resetAdsorbEffect()
end

function VersionActivityPuzzleView:onDragItemDragging(pointerEventData)
	if self.complete or self.isFinish then
		return
	end

	self:changeDragItemAnchor(pointerEventData)
end

function VersionActivityPuzzleView:onDragItemDragEnd(pointerEventData)
	if self.complete or self.isFinish then
		return
	end

	TaskDispatcher.cancelTask(self.showEndEffect, self)
	self:changeDragItemAnchor(pointerEventData)

	local hoverAnswerIndex = self:getShowAdsorbRectAnswerIndex()

	if hoverAnswerIndex > 0 then
		local existOptionItem = self.answerExistOptionItemDict[hoverAnswerIndex]

		self.hoverAnswerIndex = hoverAnswerIndex

		if not existOptionItem or existOptionItem.answerIndex ~= self.draggingAnswerIndex then
			if existOptionItem then
				existOptionItem:unUse()
			end

			self:resetGroupAnswerOption(self:getAnswerGroupIndex(self.draggingAnswerIndex))

			local draggingOptionItem = self.optionItemList[self.draggingAnswerIndex]

			self.answerExistOptionItemDict[hoverAnswerIndex] = draggingOptionItem

			local answerText = self.options[self.draggingAnswerIndex]
			local color

			if hoverAnswerIndex == self.draggingAnswerIndex then
				draggingOptionItem:matchCorrect()

				color = VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor
			else
				draggingOptionItem:matchError()

				color = VersionActivityEnum.PuzzleColorEnum.MatchErrorColor
			end

			answerText = string.format("<color=%s>%s</color>", color, self:getAnswerText(answerText, hoverAnswerIndex))
			self.showText = string.gsub(self.showText, string.format("<link=%s>.-</link>", hoverAnswerIndex), string.format("<link=%s>%s</link>", hoverAnswerIndex, answerText))

			self:onTextInfoChange()
			self:checkComplete()
			TaskDispatcher.runDelay(self.showEndEffect, self, 0.1)
		end
	end

	gohelper.setActive(self.dragOptionItem.go, false)
end

function VersionActivityPuzzleView:showEndEffect()
	if not self.hoverAnswerIndex or self.hoverAnswerIndex <= 0 then
		return
	end

	local matchCorrect = self.hoverAnswerIndex == self.draggingAnswerIndex

	if matchCorrect then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
	end

	self:calculateLinksRectAnchor()

	local anchor = self.answerToAnchorPosDict[self.hoverAnswerIndex][1]

	recthelper.setAnchor(self._goadsorbrect.transform, anchor.x, anchor.y)
	gohelper.setActive(self._goadsorbrect, true)
	gohelper.setActive(self.goAdsorbSuccess, matchCorrect)
	gohelper.setActive(self.goAdsorbFail, not matchCorrect)
	TaskDispatcher.runDelay(self.hideAdsorb, self, 1)
end

function VersionActivityPuzzleView:hideAdsorb()
	gohelper.setActive(self._goadsorbrect, false)
	self:resetAdsorbEffect()
end

function VersionActivityPuzzleView:resetGroupAnswerOption(groupIndex)
	local startIndex = (groupIndex - 1) * 4 + 1
	local optionItem, answer

	for i = startIndex, startIndex + 3 do
		answer = self:getBeUsedAnswerByOptionItem(self.optionItemList[i])

		if answer > 0 then
			self.optionItemList[i]:unUse()

			self.showText = string.gsub(self.showText, string.format("<link=%s>.-</link>", answer), string.format("<link=%s>%s</link>", answer, self.placeholderDict[answer]))
			self.answerExistOptionItemDict[answer] = nil
		end
	end
end

function VersionActivityPuzzleView:getBeUsedAnswerByOptionItem(optionItem)
	for answer, existOptionItem in pairs(self.answerExistOptionItemDict) do
		if existOptionItem.answerIndex == optionItem.answerIndex then
			return answer
		end
	end

	return -1
end

function VersionActivityPuzzleView:getAnswerText(answerText, answerIndex)
	local len = GameUtil.utf8len(answerText)
	local maxAnswerLen = self.maxAnswerLenList[self:getAnswerGroupIndex(answerIndex)]
	local blankLen = maxAnswerLen - len

	if blankLen <= 0 then
		return answerText
	end

	return string.format("%s%s%s", string.rep("<nbsp>", blankLen), answerText, string.rep("<nbsp>", blankLen))
end

function VersionActivityPuzzleView:changeDragItemAnchor(pointerEventData)
	local anchor = recthelper.screenPosToAnchorPos(pointerEventData.position, self._simagebg.transform)
	local anchorX = anchor.x
	local anchorY = anchor.y

	anchorX = anchorX > 0 and Mathf.Min(self.bgHalfWidth, anchorX) or Mathf.Max(-self.bgHalfWidth, anchorX)
	anchorY = anchorY > 0 and Mathf.Min(self.bgHalfHeight, anchorY) or Mathf.Max(-self.bgHalfHeight, anchorY)
	self.dragOptionAnchor = Vector2.New(anchorX, anchorY)

	recthelper.setAnchor(self.dragOptionItem.transform, anchorX, anchorY)
end

function VersionActivityPuzzleView:getDraggingOptionItemBeUsedAnswer()
	for answer, optionItem in pairs(self.answerExistOptionItemDict) do
		if self.draggingAnswerIndex == optionItem.answerIndex then
			return answer
		end
	end

	return -1
end

function VersionActivityPuzzleView:checkComplete()
	if self:isComplete() then
		self:onComplete()
	end
end

function VersionActivityPuzzleView:isComplete()
	local existOptionItem

	for _, answer in pairs(self.needAnswerList) do
		if not self.answerExistOptionItemDict[answer] or answer ~= self.answerExistOptionItemDict[answer].answerIndex then
			return false
		end
	end

	return true
end

function VersionActivityPuzzleView:onComplete()
	self.complete = true

	DungeonRpc.instance:sendPuzzleFinishRequest(self.elementCo.id)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(self._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
end

function VersionActivityPuzzleView:onClickGuideGo()
	self:stopGuideAnimation()
	gohelper.setActive(self._goGuide, false)
	self.guideClick:RemoveClickListener()

	self.guideClick = nil
end

function VersionActivityPuzzleView:calculateLinksRectAnchor()
	self.answerToAnchorPosDict = {}

	local textTransform = self._txtinfo.transform
	local tmpText = self._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	local linkInfoList = tmpText.textInfo.linkInfo
	local characterInfoList = tmpText.textInfo.characterInfo
	local bl, tr
	local iter = linkInfoList:GetEnumerator()

	while iter:MoveNext() do
		local linkInfo = iter.Current
		local answerIndex = tonumber(linkInfo:GetLinkID())
		local firstCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex]

		bl = textTransform:TransformPoint(Vector3.New(firstCharInfo.bottomLeft.x, firstCharInfo.descender, 0))

		if linkInfo.linkTextLength == 1 then
			tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

			self:addCenterPos(answerIndex, bl, tr)
		else
			local lastCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex + linkInfo.linkTextLength - 1]

			if firstCharInfo.lineNumber == lastCharInfo.lineNumber then
				tr = textTransform:TransformPoint(Vector3.New(lastCharInfo.topRight.x, lastCharInfo.ascender, 0))

				self:addCenterPos(answerIndex, bl, tr)
			else
				tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

				local startLineNumber = firstCharInfo.lineNumber

				for i = 1, linkInfo.linkTextLength - 1 do
					local characterIndex = linkInfo.linkTextfirstCharacterIndex + i
					local tmpCharInfo = characterInfoList[characterIndex]
					local currentLineNumber = tmpCharInfo.lineNumber

					if currentLineNumber == startLineNumber then
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					else
						self:addCenterPos(answerIndex, bl, tr)

						startLineNumber = currentLineNumber
						bl = textTransform:TransformPoint(Vector3.New(tmpCharInfo.bottomLeft.x, tmpCharInfo.descender, 0))
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					end
				end

				self:addCenterPos(answerIndex, bl, tr)
			end
		end
	end
end

function VersionActivityPuzzleView:addCenterPos(answerIndex, bl, tr)
	local centerPos = (bl + tr) * 0.5

	if self:checkScenePosIsValid(centerPos) then
		self.answerToAnchorPosDict[answerIndex] = self.answerToAnchorPosDict[answerIndex] or {}

		table.insert(self.answerToAnchorPosDict[answerIndex], recthelper.worldPosToAnchorPos(centerPos, self._goadsorbrect.transform.parent, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera()))
	end
end

function VersionActivityPuzzleView:getShowAdsorbRectAnswerIndex()
	local needShowAdsorbAnswer = 0
	local minDistance = 99999

	for answerIndex, anchorList in pairs(self.answerToAnchorPosDict) do
		local halfWidth = self:getAnswerWidth(self:getAnswerGroupIndex(answerIndex)) / 2

		for _, anchor in ipairs(anchorList) do
			if self.dragOptionAnchor.x >= anchor.x - (halfWidth + VersionActivityPuzzleView.AbsorbOffsetX) and self.dragOptionAnchor.x <= anchor.x + (halfWidth + VersionActivityPuzzleView.AbsorbOffsetX) and self.dragOptionAnchor.y >= anchor.y - (self.halfAnsWerHeight + VersionActivityPuzzleView.AbsorbOffsetY) and self.dragOptionAnchor.y <= anchor.y + (self.halfAnsWerHeight + VersionActivityPuzzleView.AbsorbOffsetY) then
				local distance = Vector2.Distance(anchor, self.dragOptionAnchor)

				if distance < minDistance then
					minDistance = distance
					needShowAdsorbAnswer = answerIndex
				end
			end
		end
	end

	return needShowAdsorbAnswer
end

function VersionActivityPuzzleView:checkScenePosIsValid(scenePos)
	return GameUtil.checkPointInRectangle(scenePos, self.textScrollScenePosRect[1], self.textScrollScenePosRect[2], self.textScrollScenePosRect[3], self.textScrollScenePosRect[4])
end

function VersionActivityPuzzleView:getAnswerGroupIndex(answerIndex)
	return math.ceil(answerIndex / 4)
end

function VersionActivityPuzzleView:resetAdsorbEffect()
	gohelper.setActive(self.goAdsorbSuccess, false)
	gohelper.setActive(self.goAdsorbFail, false)
end

function VersionActivityPuzzleView:getAnswerWidth(groupIndex)
	return self.maxAnswerLenList[groupIndex] * VersionActivityPuzzleView.OneCharacterWidth
end

function VersionActivityPuzzleView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.cancelTask(self.showGuide, self)
	TaskDispatcher.cancelTask(self.hideAdsorb, self)
	TaskDispatcher.cancelTask(self.showEndEffect, self)
	self:stopGuideAnimation()

	if DungeonMapModel.instance:hasMapPuzzleStatus(self.elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, self.elementCo.id)
	end
end

function VersionActivityPuzzleView:onDestroyView()
	self.closeViewClick:RemoveClickListener()

	if self.guideClick then
		self.guideClick:RemoveClickListener()
	end

	for _, optionItem in ipairs(self.optionItemList) do
		optionItem:onDestroy()
	end
end

return VersionActivityPuzzleView
