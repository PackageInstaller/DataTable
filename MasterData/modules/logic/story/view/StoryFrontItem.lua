-- chunkname: @modules/logic/story/view/StoryFrontItem.lua

module("modules.logic.story.view.StoryFrontItem", package.seeall)

local StoryFrontItem = class("StoryFrontItem")
local ScreenTextType = {
	Text = 1,
	TMP = 2
}

function StoryFrontItem:init(go)
	self._frontGO = go
	self._txtscreentext = gohelper.findChildText(go, "txt_screentext")
	self._tmpscreentext = gohelper.findChildText(go, "tmp_screentext")
	self._imagefulltop = gohelper.findChildImage(go, "image_fulltop")
	self._imageupfade = gohelper.findChildImage(go, "go_upfade")
	self._imageblock = gohelper.findChildImage(go, "#go_block")
	self._txtscreentextmesh = gohelper.findChildText(go, "txt_screentextmesh")
	self._imagefulltop = gohelper.findChildImage(go, "image_fulltop")
	self._goupfade = gohelper.findChild(go, "go_upfade")
	self._goirregularshake = gohelper.findChild(go.transform.parent.gameObject, "#go_irregularshake")

	self:setFullTopShow()
	self:setCurScreenText()

	self._imagefulltop.color.a = 1
	self._imagefulltop.color = Color.black

	self:_addEvent()
end

function StoryFrontItem:_addEvent()
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFadeUp, self._playDarkUpFade, self)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFade, self._playDarkFade, self)
	StoryController.instance:registerCallback(StoryEvent.PlayWhiteFade, self._playWhiteFade, self)
end

function StoryFrontItem:_removeEvent()
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFadeUp, self._playDarkUpFade, self)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFade, self._playDarkFade, self)
	StoryController.instance:unregisterCallback(StoryEvent.PlayWhiteFade, self._playWhiteFade, self)
end

function StoryFrontItem:showFullScreenText(show, txt)
	if not show then
		self._finishCallback = nil
		self._finishCallbackObj = nil
		self._fadeOutCallback = nil
		self._fadeOutCallbackObj = nil

		self:_killTextTween()
		self:_killFloatTween()
		ZProj.TweenHelper.KillByObj(self._copyText)

		if self._copyText then
			gohelper.destroy(self._copyText.gameObject)

			self._copyText = nil
		end
	end

	gohelper.setActive(self._txtscreentext.gameObject, show)

	self._diatxt = string.gsub(txt, "<notShowInLog>", "")
	self._markScreenText = self._txtscreentext

	if string.match(txt, "marktop") then
		self._markScreenText = self._txtscreentextmesh

		gohelper.setActive(self._txtscreentext.gameObject, false)
		gohelper.setActive(self._txtscreentextmesh.gameObject, show)

		self._markScreenText.alignment = StoryTool.getTxtAlignment(self._diatxt, gohelper.Type_TextMesh)
		self._txtmarktop = IconMgr.instance:getCommonTextMarkTop(self._markScreenText.gameObject):GetComponent(gohelper.Type_TextMesh)
		self._conMark = gohelper.onceAddComponent(self._markScreenText.gameObject, typeof(ZProj.TMPMark))

		self._conMark:SetMarkTopGo(self._txtmarktop.gameObject)
		self:_setFullScreenItem()
	else
		gohelper.setActive(self._txtscreentext.gameObject, show)
		gohelper.setActive(self._txtscreentextmesh.gameObject, false)

		self._txtscreentext.alignment = StoryTool.getTxtAlignment(self._diatxt, gohelper.Type_Text)

		self:_setFullScreenItem()
	end
end

function StoryFrontItem:_setFullScreenItem()
	local stepId = StoryModel.instance:getCurStepId()
	local stepCo = StoryStepModel.instance:getStepListById(stepId)

	self._diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, stepCo.conversation.audio or 0)
	self._txtscreentext.alignment = StoryTool.getTxtAlignment(self._diatxt)
	self._txtscreentext.text = StoryTool.getFilterAlignTxt(self._diatxt)

	self:_showGlitch(stepCo.conversation.effType == StoryEnum.ConversationEffectType.Glitch)

	self._diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, stepCo.conversation.audios[1] or 0)
	self._markScreenText.text = StoryTool.getFilterAlignTxt(self._diatxt)
end

function StoryFrontItem:enableFrontRayCast(enable)
	self._txtscreentext.raycastTarget = enable
	self._imagefulltop.raycastTarget = enable
	self._imageblock.raycastTarget = enable
	self._imageupfade.raycastTarget = enable
end

function StoryFrontItem:_showGlitch(show)
	if show then
		if not self._goGlitch then
			self._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			self._effLoader = MultiAbLoader.New()

			self._effLoader:addPath(self._glitchPath)
			self._effLoader:startLoad(self._glitchEffLoaded, self)
		else
			local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			ctxt.isSetParticleShapeMesh = true
			ctxt.isSetParticleCount = true

			gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(self._goGlitch, true)
		end
	else
		gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UITop, true)

		if self._goGlitch then
			gohelper.setActive(self._goGlitch, false)
		end

		local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		ctxt.isSetParticleShapeMesh = false
		ctxt.isSetParticleCount = false
	end
end

function StoryFrontItem:playGlitch()
	StoryTool.enablePostProcess(true)
	gohelper.setActive(self._txtscreentext.gameObject, true)
	self:_showGlitch(true)
end

function StoryFrontItem:_glitchEffLoaded(loader)
	local glitchAssetItem = loader:getAssetItem(self._glitchPath)

	self._goGlitch = gohelper.clone(glitchAssetItem:GetResource(self._glitchPath), self._txtscreentext.gameObject)

	gohelper.setActive(self._goGlitch, true)

	for i = 1, 4 do
		local glitchGo = gohelper.findChild(self._goGlitch, "part_" .. tostring(i))

		gohelper.setActive(glitchGo, false)
	end

	local goScreen = gohelper.findChild(self._goGlitch, "part_screen")

	gohelper.setActive(goScreen, true)

	local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	ctxt.isSetParticleShapeMesh = true
	ctxt.isSetParticleCount = true
	ctxt.particle = goScreen:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function StoryFrontItem:_getFadeTime()
	return not StoryModel.instance.skipFade and 1 or 0
end

function StoryFrontItem:setFullTopShow()
	gohelper.setActive(self._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function StoryFrontItem:playStoryViewIn()
	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryModel.instance:getCurStoryId())

	StoryModel.instance.skipFade = skip

	ZProj.TweenHelper.KillByObj(self._imagefulltop)

	self._imagefulltop.color.a = 1

	self:setFullTopShow()

	if not skip then
		TaskDispatcher.runDelay(self._startStoryViewIn, self, 0.5)
	end
end

function StoryFrontItem:_startStoryViewIn()
	local alpha = self._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(self._imagefulltop, alpha, 0, self:_getFadeTime(), function()
		gohelper.setActive(self._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function StoryFrontItem:playStoryViewOut(callback, callbackobj, isSkip)
	StoryModel.instance.skipFade = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryModel.instance:getCurStoryId())

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackObj = nil

	self:_killTextTween()
	self:_killFloatTween()
	ZProj.TweenHelper.KillByObj(self._copyText)

	if self._copyText then
		gohelper.destroy(self._copyText.gameObject)

		self._copyText = nil
	end

	self._outCallback = callback
	self._outCallbackObj = callbackobj

	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, self:_getFadeTime(), self.enterStoryFinish, self, nil, EaseType.Linear)
end

function StoryFrontItem:enterStoryFinish()
	self:setCurScreenText()
	gohelper.setActive(self._txtscreentextmesh.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)
	TaskDispatcher.runDelay(self._viewFadeOut, self, 0.5)
	StoryController.instance:finished()
end

function StoryFrontItem:_onOpenView(viewName)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)

	if viewName == ViewName.StoryView or viewName == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(self._viewFadeOut, self)

		return
	end

	local storyId = StoryModel.instance:getCurStoryId()

	if StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:closeStoryView()
	end
end

function StoryFrontItem:cancelViewFadeOut()
	TaskDispatcher.cancelTask(self._viewFadeOut, self)
end

function StoryFrontItem:_viewFadeOut()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(self._viewFadeOutFinished, self, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function StoryFrontItem:_viewFadeOutFinished()
	gohelper.setActive(self._imagefulltop.gameObject, false)

	if self._outCallback then
		self._outCallback(self._outCallbackObj)
	end
end

function StoryFrontItem:_playDarkUpFade()
	gohelper.setActive(self._goupfade, true)
	transformhelper.setLocalPosXY(self._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(self._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(self._goupfade, false)
	end)
end

function StoryFrontItem:_playDarkFade()
	StoryModel.instance.skipFade = false

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, 1.5, self._playDarkFadeFinished, self, nil, EaseType.Linear)
end

function StoryFrontItem:_playDarkFadeFinished()
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	TaskDispatcher.runDelay(self._playDarkFadeInFinished, self, 0.5)
end

function StoryFrontItem:_playDarkFadeInFinished()
	ZProj.TweenHelper.DoFade(self._imagefulltop, 1, 0, 1.5, self._hideImageFullTop, self, nil, EaseType.Linear)
end

function StoryFrontItem:_hideImageFullTop()
	self._imagefulltop.color = Color.black

	gohelper.setActive(self._imagefulltop.gameObject, false)
end

function StoryFrontItem:_playWhiteFade()
	StoryModel.instance.skipFade = false

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, 1.5, self._playWhiteFadeFinished, self, nil, EaseType.Linear)
end

function StoryFrontItem:_playWhiteFadeFinished()
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	TaskDispatcher.runDelay(self._playDarkFadeInFinished, self, 0.5)
end

function StoryFrontItem:_playWhiteFadeInFinished()
	ZProj.TweenHelper.DoFade(self._imagefulltop, 1, 0, 1.5, self._hideImageFullTop, self, nil, EaseType.Linear)
end

function StoryFrontItem:playIrregularShakeText(co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._goirregularshake, true)

	self._shakefinishCallback = callback
	self._shakefinishCallbackObj = callbackobj

	if not self._goshake then
		local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		self._goshake = viewContainer:getResInst(viewContainer:getSetting().otherRes[1], self._goirregularshake)
	end

	self._shakeAni = self._goshake:GetComponent(typeof(UnityEngine.Animator))

	local txt = gohelper.findChildText(self._goshake, "tex_ani/#tex")

	txt.text = self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	local delayTime = self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if delayTime < 0.1 then
		if self._shakefinishCallback then
			self._shakefinishCallback(self._shakefinishCallbackObj)

			self._shakefinishCallback = nil
			self._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(self._onShakeEnd, self, delayTime)
end

function StoryFrontItem:_onShakeEnd()
	self._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(self._goirregularshake, false)

		if self._shakefinishCallback then
			self._shakefinishCallback(self._shakefinishCallbackObj)

			self._shakefinishCallback = nil
			self._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function StoryFrontItem:wordByWord(co, callback, callbackobj)
	self._stepCo = co

	self:setCurScreenText(ScreenTextType.TMP)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	self:_fadeUpdate(1)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:playFinishCallback()

		return
	end

	self:_startWordByWord()
end

function StoryFrontItem:_startWordByWord()
	self:_killFloatTween()

	local tmpComp = self:getCurScreenText()

	tmpComp.alignment = StoryTool.getTxtAlignment(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], gohelper.Type_TextMesh)
	tmpComp.text = StoryTool.getFilterAlignTxt(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	tmpComp:ForceMeshUpdate()

	local total = tmpComp.textInfo.characterCount

	tmpComp.maxVisibleCharacters = 0

	local time = self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local cur = 0

	self._textTweenId = ZProj.TweenHelper.DOTweenFloat(cur, total, time, self.onWordFameCallback, self.onWordPlayFinishCallback, self, nil, EaseType.Linear)
end

function StoryFrontItem:onWordFameCallback(val)
	local tmpComp = self:getCurScreenText()

	tmpComp.maxVisibleCharacters = math.floor(val)
end

function StoryFrontItem:onWordPlayFinishCallback()
	local tmpComp = self:getCurScreenText()

	tmpComp.maxVisibleCharacters = tmpComp.textInfo.characterCount

	self:playFinishCallback()
end

function StoryFrontItem:playFinishCallback()
	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)

		self._finishCallback = nil
		self._finishCallbackObj = nil
	end
end

function StoryFrontItem:lineShow(lineCount, co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._markScreenText.gameObject, true)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	self:_fadeUpdate(1)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_lineWordShowFinished()

		return
	end

	self:_startShowLine(lineCount)
end

function StoryFrontItem:_startShowLine(lineCount)
	local textType = gohelper.Type_Text

	self._conCopyMark = nil

	if not self._copyText then
		local copyObj = gohelper.cloneInPlace(self._markScreenText.gameObject, "copytext")

		gohelper.destroyAllChildren(copyObj)

		local isTextMesh = copyObj:GetComponent(gohelper.Type_TextMesh)

		textType = isTextMesh and gohelper.Type_TextMesh or textType
		self._copyText = copyObj:GetComponent(textType)

		if isTextMesh then
			self._conMark:SetMarksTop({})

			self._txtcopymarktop = IconMgr.instance:getCommonTextMarkTop(self._copyText.gameObject):GetComponent(gohelper.Type_TextMesh)
			self._conCopyMark = gohelper.onceAddComponent(self._copyText.gameObject, typeof(ZProj.TMPMark))

			self._conCopyMark:SetMarkTopGo(self._txtcopymarktop.gameObject)
			self._conCopyMark:SetMarksTop({})
		end
	end

	self._copyText.alignment = StoryTool.getTxtAlignment(self._diatxt, textType)
	self._diatxt = StoryTool.getFilterAlignTxt(self._diatxt)
	self._diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, self._stepCo.conversation.audio or 0)

	gohelper.setActive(self._copyText.gameObject, true)

	local lineWords = self:_getLineWord(lineCount)
	local lineShowTime = #lineWords == 0 and self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #lineWords
	local index = 1

	local function showLine(index)
		local cpstr = " "
		local str = ""
		local firstLineCount = #string.split(str, "\n")

		if firstLineCount > 1 then
			for j = 2, firstLineCount do
				cpstr = string.format("%s\n%s", cpstr, " ")
			end
		end

		if #lineWords >= 1 then
			for i = 1, #lineWords do
				local indexLineCount = #string.split(lineWords[i], "\n")

				indexLineCount = indexLineCount or 1

				if i < index then
					str = string.format("%s\n%s", str, lineWords[i])

					for j = 1, indexLineCount do
						local _, size, _, _ = string.match(string.split(lineWords[i], "\n")[j], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						cpstr = size and tonumber(size) and string.format("%s\n%s", cpstr, string.format("<size=%s> </size>", size)) or string.format("%s\n%s", cpstr, " ")
					end
				elseif i == index then
					for j = 1, indexLineCount do
						str = string.format("%s\n%s", str, " ")
					end

					cpstr = string.format("%s\n%s", cpstr, lineWords[i])
				else
					for j = 1, indexLineCount do
						str = string.format("%s\n%s", str, " ")
						cpstr = string.format("%s\n%s", cpstr, " ")
					end
				end
			end
		end

		local markTopList = StoryTool.getMarkTopTextList(str)

		str = StoryTool.filterMarkTop(str)
		self._markScreenText.text = StoryTool.filterSpTag(str)

		TaskDispatcher.runDelay(function()
			if self._conMark and self._txtscreentextmesh.gameObject.activeSelf then
				self._conMark:SetMarksTop(markTopList)
			end
		end, nil, 0.01)

		local copymarkTopList = StoryTool.getMarkTopTextList(cpstr)

		cpstr = StoryTool.filterMarkTop(cpstr)
		cpstr = StoryTool.filterSpTag(cpstr)
		self._copyText.text = cpstr

		TaskDispatcher.runDelay(function()
			if self._conCopyMark then
				self._conCopyMark:SetMarksTop(copymarkTopList)
			end
		end, nil, 0.01)
		ZProj.TweenHelper.KillByObj(self._markScreenText)
		ZProj.TweenHelper.KillByObj(self._copyText)
		self:_fadeUpdate(1)
		ZProj.TweenHelper.DOFadeCanvasGroup(self._copyText.gameObject, 0, 1, lineShowTime, function()
			if index - #lineWords >= 0 then
				self:_lineWordShowFinished()
			else
				index = index + 1

				showLine(index)
			end
		end, nil, nil, EaseType.Linear)
	end

	showLine(index)
end

function StoryFrontItem:_getLineWord(lineCount)
	local spWords = string.split(self._diatxt, "\n")
	local lineWords = {}
	local count = math.floor(#spWords / lineCount)

	for i = 0, count - 1 do
		local word1 = spWords[i * lineCount + 1]

		for j = 2, lineCount do
			word1 = string.format("%s\n%s", word1, spWords[i * lineCount + j])
		end

		table.insert(lineWords, word1)
	end

	if count * lineCount < #spWords then
		local word2 = spWords[count * lineCount + 1]

		if #spWords - count * lineCount > 1 then
			for j = 2, #spWords - count * lineCount do
				word2 = string.format("%s\n%s", word2, spWords[lineCount * count + j])
			end
		end

		table.insert(lineWords, word2)
	end

	return lineWords
end

function StoryFrontItem:_lineWordShowFinished()
	self._txtscreentext.text = "\n" .. self._diatxt

	self:playFinishCallback()

	local str = StoryTool.getFilterAlignTxt(self._diatxt)
	local markTopList = StoryTool.getMarkTopTextList(str)

	str = StoryTool.filterMarkTop(str)
	self._markScreenText.text = "\n" .. StoryTool.filterSpTag(str)

	if self._copyText then
		gohelper.setActive(self._copyText.gameObject, false)

		self._copyText.text = ""
	end

	TaskDispatcher.runDelay(function()
		if self._conMark and self._txtscreentextmesh.gameObject.activeSelf then
			self._conMark:SetMarksTop(markTopList)
		end

		if self._copyText then
			gohelper.destroyAllChildren(self._copyText.gameObject)
			gohelper.destroy(self._copyText.gameObject)

			self._copyText = nil
		end

		self:playFinishCallback()
	end, nil, 0.01)
end

function StoryFrontItem:playFullTextFadeOut(outTime, callback, callbackObj)
	local fadeOutTime = outTime or 0.5

	self._fadeOutCallback = callback
	self._fadeOutCallbackObj = callbackObj

	self:_killFloatTween()

	self._floatTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, fadeOutTime, self._fadeUpdate, self._hideScreenTxt, self, nil, EaseType.Linear)
end

function StoryFrontItem:_hideScreenTxt()
	self:_killFloatTween()
	self:setCurScreenText()

	if self._fadeOutCallback then
		self._fadeOutCallback(self._fadeOutCallbackObj)

		self._fadeOutCallback = nil
		self._fadeOutCallbackObj = nil
	end
end

function StoryFrontItem:playTextFadeIn(co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._markScreenText.gameObject, true)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	self:_killFloatTween()

	local txt = self._markScreenText.text
	local markTopList = StoryTool.getMarkTopTextList(txt)

	txt = StoryTool.filterMarkTop(txt)
	self._markScreenText.text = StoryTool.filterSpTag(txt)

	TaskDispatcher.runDelay(function()
		if self._conMark and markTopList and #markTopList > 0 then
			self._conMark:SetMarksTop(markTopList)
		end
	end, nil, 0.01)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_fadeFinished()
	else
		self._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._fadeUpdate, self._fadeFinished, self, nil, EaseType.Linear)
	end
end

function StoryFrontItem:clickFullScreentText()
	if self._curScreenTextEndFunc then
		self:_curScreenTextEndFunc()
	end
end

function StoryFrontItem:playGostMagic(co, callback, callbackobj)
	StoryTool.enablePostProcess(true)

	self.showingClickableScreenText = true
	self.showClickableScreenTextEnd = false

	self:setCurScreenText(ScreenTextType.TMP)

	self._stepCo = co

	local txt = StoryTool.getFilterAlignTxt(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	self:_killTextTween()
	ZProj.UGUIHelper.SetColorAlpha(self._tmpscreentext, 1)

	self._tmpscreentext.text = txt

	gohelper.setLayer(self._tmpscreentext.gameObject, UnityLayer.UISecond, true)
	self:_setDistortMaterial()
	self._tmpscreentext.fontMaterial:EnableKeyword("UNDERLAY_ON")
	self._tmpscreentext.fontMaterial:SetFloat("_BloomFactor", 2.5)

	self._tmpscreentext.fontMaterial.renderQueue = 4995
	self._gostFontGlitchPath = ResUrl.getEffect("story/v3a7_fontglitch")
	self._effLoader = MultiAbLoader.New()

	self._effLoader:addPath(self._gostFontGlitchPath)
	self._effLoader:startLoad(self._gostGlitchEffLoaded, self)

	local anchorFlag, posX, posY, realTxt = string.match(txt, "^(L?)(-?%d+),(-?%d+)#(.*)")
	local rt = self._tmpscreentext.rectTransform

	if posX and posY then
		self._tmpscreentext.text = realTxt

		if anchorFlag == "L" then
			rt.anchorMin = Vector2(0, 0.5)
			rt.anchorMax = Vector2(0, 0.5)

			self._tmpscreentext:ForceMeshUpdate()

			rt.anchoredPosition = Vector2(tonumber(posX) + self._tmpscreentext.preferredWidth * 0.5, tonumber(posY))
		else
			rt.anchorMin = Vector2(0.5, 0.5)
			rt.anchorMax = Vector2(0.5, 0.5)
			rt.anchoredPosition = Vector2(tonumber(posX), tonumber(posY))
		end
	else
		rt.anchorMin = Vector2(0.5, 0.5)
		rt.anchorMax = Vector2(0.5, 0.5)
		rt.anchoredPosition = Vector2(0, 0)
	end

	self._savedUIPPValues = {
		localBloomActive = PostProcessingMgr.instance:getUIPPValue("localBloomActive"),
		bloomDiffusion = PostProcessingMgr.instance:getUIPPValue("bloomDiffusion"),
		bloomThreshold = PostProcessingMgr.instance:getUIPPValue("bloomThreshold"),
		bloomPercent = PostProcessingMgr.instance:getUIPPValue("bloomPercent"),
		localBloomFactor = PostProcessingMgr.instance:getUIPPValue("localBloomFactor"),
		bloomIntensity = PostProcessingMgr.instance:getUIPPValue("bloomIntensity"),
		bloomRTDownTimes = PostProcessingMgr.instance:getUIPPValue("bloomRTDownTimes"),
		localBloomColor = PostProcessingMgr.instance:getUIPPValue("localBloomColor")
	}

	PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
	PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 6.45)
	PostProcessingMgr.instance:setUIPPValue("bloomThreshold", 1.2)
	PostProcessingMgr.instance:setUIPPValue("bloomPercent", 1)
	PostProcessingMgr.instance:setUIPPValue("localBloomFactor", 1)
	PostProcessingMgr.instance:setUIPPValue("bloomIntensity", 10)
	PostProcessingMgr.instance:setUIPPValue("bloomRTDownTimes", 1)
	PostProcessingMgr.instance:setUIPPValue("localBloomColor", Color.New(0.55, 0.61, 1, 1))

	local delayTime = self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if delayTime < 0.1 then
		self:_playGostMagicEnd()

		return
	end

	TaskDispatcher.cancelTask(self._gostMagicFinished, self)
	TaskDispatcher.runDelay(self._gostMagicFinished, self, delayTime)

	self._curScreenTextEndFunc = self._playGostMagicEnd
end

local _distortOwnFloatProps = {
	"_TextureWidth",
	"_TextureHeight",
	"_GlitchBandHeight",
	"_GlitchDensity",
	"_GlitchSpeed",
	"_GlitchGhost",
	"_GlitchGhostOffset",
	"_BloomFactor",
	"_UnderlayOffsetX",
	"_UnderlayOffsetY",
	"_UnderlayDilate",
	"_UnderlaySoftness"
}
local _distortOwnColorProps = {
	"_UnderlayColor"
}

function StoryFrontItem:_buildDistortMaterial(templateMat)
	if gohelper.isNil(self._tmpscreentext) or gohelper.isNil(templateMat) then
		return nil
	end

	local baseMat = self._tmpscreentext.fontSharedMaterial

	if gohelper.isNil(baseMat) then
		return nil
	end

	local mat = UnityEngine.Object.Instantiate(baseMat)

	mat.shader = templateMat.shader

	mat:EnableKeyword("UNDERLAY_ON")

	for _, name in ipairs(_distortOwnFloatProps) do
		local id = UnityEngine.Shader.PropertyToID(name)

		mat:SetFloat(id, templateMat:GetFloat(id))
	end

	for _, name in ipairs(_distortOwnColorProps) do
		local id = UnityEngine.Shader.PropertyToID(name)

		mat:SetColor(id, templateMat:GetColor(id))
	end

	mat.renderQueue = templateMat.renderQueue

	return mat
end

function StoryFrontItem:_setDistortMaterial()
	local matPath = "font/meshpro/outline_material/hwzs_dynamic_distort.mat"

	if self._distortMat then
		self._tmpscreentext.fontMaterial = self._distortMat

		self:_startGlitchAmountAnim()

		return
	end

	if self._distortMatLoader then
		return
	end

	local loader = MultiAbLoader.New()

	self._distortMatLoader = loader

	loader:addPath(matPath)
	loader:startLoad(function()
		local assetItem = loader:getAssetItem(matPath)
		local templateMat = assetItem and assetItem:GetResource(matPath)

		if templateMat then
			self._distortMat = self:_buildDistortMaterial(templateMat)
		end

		if self._distortMat and not gohelper.isNil(self._tmpscreentext) then
			self._tmpscreentext.fontMaterial = self._distortMat
		end

		self:_startGlitchAmountAnim()
	end)
end

function StoryFrontItem:_startGlitchAmountAnim()
	if not self._distortMat then
		return
	end

	local glitchAmountId = UnityEngine.Shader.PropertyToID("_GlitchAmount")

	self._distortMat:SetFloat(glitchAmountId, 3.5)
	ZProj.TweenHelper.DOTweenFloat(3.5, 1.8, 1.5, self._glitchAmountUpdate, self._glitchAmountEnd, self, nil, EaseType.Linear)
end

function StoryFrontItem:_glitchAmountUpdate(value)
	if self._distortMat then
		local glitchAmountId = UnityEngine.Shader.PropertyToID("_GlitchAmount")

		self._tmpscreentext.fontMaterial:SetFloat(glitchAmountId, value)
	end
end

function StoryFrontItem:_glitchAmountEnd()
	self.showClickableScreenTextEnd = true
end

function StoryFrontItem:_playGostMagicEnd()
	if self.showClickableScreenTextEnd then
		TaskDispatcher.cancelTask(self._gostMagicFinished, self)
		self:_gostMagicFinished()
		StoryController.instance:dispatchEvent(StoryEvent.EnterNextStep)

		return
	end

	self.showClickableScreenTextEnd = true

	if self._gostFontGlitchGo then
		gohelper.setActive(self._gostFontGlitchGo, false)
	end
end

function StoryFrontItem:_gostMagicFinished()
	self.showClickableScreenTextEnd = true
	self.showingClickableScreenText = false

	self:playFinishCallback()

	local fadeOutTime = 1

	self:_killTextTween()

	self._textTweenId = ZProj.TweenHelper.DoFade(self._tmpscreentext, 1, 0, fadeOutTime, self._hideTmpScreenTxt, self, nil, EaseType.Linear)

	ZProj.TweenHelper.DOTweenFloat(1.8, 10, fadeOutTime, self._glitchAmountUpdate, nil, self, nil, EaseType.Linear)

	if self._gostFontGlitchGo then
		gohelper.destroy(self._gostFontGlitchGo)

		self._gostFontGlitchGo = nil
	end
end

function StoryFrontItem:_gostGlitchEffLoaded(loader)
	local glitchAssetItem = loader:getAssetItem(self._gostFontGlitchPath)

	self._gostFontGlitchGo = gohelper.clone(glitchAssetItem:GetResource(self._gostFontGlitchPath), self._tmpscreentext.gameObject)

	gohelper.setActive(self._gostFontGlitchGo, true)

	local goGlitchLine = gohelper.findChild(self._gostFontGlitchGo, "part_up")

	self._tmpscreentext:ForceMeshUpdate()

	local textInfo = self._tmpscreentext.textInfo
	local lineCount = textInfo.lineCount

	for i = 0, lineCount - 1 do
		local lineInfo = textInfo.lineInfo[i]
		local lineWidth = lineInfo.length * self._tmpscreentext.transform.lossyScale.x
		local lineY = lineInfo.baseline
		local lineGo = i == 0 and goGlitchLine or gohelper.clone(goGlitchLine, self._gostFontGlitchGo)

		gohelper.setActive(lineGo, true)

		local rt = lineGo:GetComponent(typeof(UnityEngine.RectTransform))

		if rt then
			rt.anchoredPosition = Vector2(0, lineY)
		else
			transformhelper.setLocalPosXY(lineGo.transform, 0, lineY)
		end

		local ps = lineGo:GetComponent(typeof(UnityEngine.ParticleSystem))

		if ps then
			local shapeModule = ps.shape
			local s = shapeModule.scale

			shapeModule.scale = Vector3(lineWidth, s.y, s.z)
		end
	end
end

function StoryFrontItem:_hideTmpScreenTxt()
	if self._savedUIPPValues then
		for k, v in pairs(self._savedUIPPValues) do
			PostProcessingMgr.instance:setUIPPValue(k, v)
		end

		self._savedUIPPValues = nil
	else
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
	end

	self:_killTextTween()

	local txtComp = self:getCurScreenText()

	gohelper.setActive(txtComp, false)
end

function StoryFrontItem:_fadeUpdate(value)
	self._txtCanvasGroup = self._txtCanvasGroup or gohelper.onceAddComponent(self._markScreenText, typeof(UnityEngine.CanvasGroup))
	self._txtCanvasGroup.alpha = value
end

function StoryFrontItem:_fadeFinished()
	if self._txtCanvasGroup then
		self._txtCanvasGroup.alpha = 1
	end

	self:playFinishCallback()
end

function StoryFrontItem:_killFloatTween()
	if self._floatTweenId then
		ZProj.TweenHelper.KillById(self._floatTweenId)

		self._floatTweenId = nil
	end
end

function StoryFrontItem:_killTextTween()
	if self._textTweenId then
		ZProj.TweenHelper.KillById(self._textTweenId)

		self._textTweenId = nil
	end
end

function StoryFrontItem:setCurScreenText(txtType)
	self._curScreenTextType = txtType

	local isText = txtType == ScreenTextType.Text
	local isTMP = txtType == ScreenTextType.TMP

	gohelper.setActive(self._txtscreentext, isText)
	gohelper.setActive(self._tmpscreentext, isTMP)
end

function StoryFrontItem:getCurScreenText()
	if self._curScreenTextType == ScreenTextType.TMP then
		return self._tmpscreentext
	end

	return self._txtscreentext
end

function StoryFrontItem:destroy()
	self:_removeEvent()

	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._outCallback = nil
	self._outCallbackObj = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackObj = nil

	self:_killFloatTween()
	TaskDispatcher.cancelTask(self._viewFadeOutFinished, self)
	TaskDispatcher.cancelTask(self._startStoryViewIn, self)
	TaskDispatcher.cancelTask(self._viewFadeOut, self)
	TaskDispatcher.cancelTask(self._onShakeEnd, self)
	TaskDispatcher.cancelTask(self._gostMagicFinished, self)

	if self._floatTweenId then
		ZProj.TweenHelper.KillById(self._floatTweenId)

		self._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	ZProj.TweenHelper.KillByObj(self._goupfade.transform)
	self:_killTextTween()

	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	if self._distortMatLoader then
		self._distortMatLoader:dispose()

		self._distortMatLoader = nil
	end

	if self._distortMat then
		gohelper.destroy(self._distortMat)

		self._distortMat = nil
	end

	if self._gostFontGlitchGo then
		gohelper.destroy(self._gostFontGlitchGo)

		self._gostFontGlitchGo = nil
	end

	if self._savedUIPPValues then
		for k, v in pairs(self._savedUIPPValues) do
			PostProcessingMgr.instance:setUIPPValue(k, v)
		end

		self._savedUIPPValues = nil
	end
end

return StoryFrontItem
