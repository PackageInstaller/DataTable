-- chunkname: @modules/logic/story/view/StoryDialogItem.lua

module("modules.logic.story.view.StoryDialogItem", package.seeall)

local StoryDialogItem = class("StoryDialogItem")

function StoryDialogItem:init(go)
	self._gocontentroot = go
	self._gonexticon = gohelper.findChild(go, "nexticon")
	self._goconversation = gohelper.findChild(go, "#go_conversation")
	self._gocontent = gohelper.findChild(go, "#go_conversation/#go_contents/content")
	self._goblackbottom = gohelper.findChild(self._gocontent, "blackBottom")
	self._goline = gohelper.findChild(self._gocontent, "line")
	self._gonormalcontent = gohelper.findChild(self._gocontent, "go_normalcontent")
	self._txtcontentcn = gohelper.findChildText(self._gonormalcontent, "txt_contentcn")
	self._norConMat = self._txtcontentcn.fontMaterial

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
	self._gonormaldot = gohelper.findChild(self._gonormalcontent, "txt_contentcn/storytxtdot")
	self._txtnormalmarktop = gohelper.findChildText(self._gonormalcontent, "txt_contentcn/storymarktop")
	self._dotnormalMat = self._gonormaldot.transform:GetComponent(gohelper.Type_Image).material
	self._normalmarkTopMat = self._txtnormalmarktop.fontMaterial
	self._normalConMark = gohelper.onceAddComponent(self._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	self._normalConMark:SetMarkGo(self._gonormaldot)
	self._normalConMark:SetMarkTopGo(self._txtnormalmarktop.gameObject)

	self._gosoftlightcontent = gohelper.findChild(self._gocontent, "go_softlightcontent")
	self._txtsoftlight = gohelper.findChildText(self._gosoftlightcontent, "txt_softlight")
	self._softConMat = self._txtsoftlight.fontMaterial
	self._softConMat = self._txtsoftlight.fontMaterial
	self._softdot = gohelper.findChild(self._gosoftlightcontent, "txt_softlight/storytxtdot")
	self._txtsoftmarktop = gohelper.findChildText(self._gosoftlightcontent, "txt_softlight/storymarktop")
	self._softdotMat = self._softdot.transform:GetComponent(gohelper.Type_Image).material
	self._softmarkTopMat = self._txtsoftmarktop.fontMaterial
	self._softConMark = gohelper.onceAddComponent(self._txtsoftlight.gameObject, typeof(ZProj.TMPMark))

	self._softConMark:SetMarkGo(self._softdot)
	self._softConMark:SetMarkTopGo(self._txtsoftmarktop.gameObject)

	self._gomagiccontent = gohelper.findChild(self._gocontent, "go_magiccontent")
	self._goslidecontent = gohelper.findChild(go, "#go_slidecontent")
	self._slideItem = StoryDialogSlideItem.New()

	self._slideItem:init(self._goslidecontent)
	self._slideItem:hideDialog()

	self._fontNormalMat = self._txtcontentcn.fontSharedMaterial

	self:_loadRes()
	self:_addEvent()
end

function StoryDialogItem:_loadRes()
	self._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
	self._effLoader = MultiAbLoader.New()

	self._effLoader:addPath(self._glitchPath)
	self._effLoader:startLoad(self._resEffLoaded, self)
end

function StoryDialogItem:_resEffLoaded(loader)
	local glitchAssetItem = loader:getAssetItem(self._glitchPath)

	self._glitchGo = gohelper.clone(glitchAssetItem:GetResource(self._glitchPath), self._gonormalcontent)

	gohelper.setActive(self._glitchGo, false)
end

function StoryDialogItem:_addEvent()
	StoryController.instance:registerCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
	StoryController.instance:registerCallback(StoryEvent.OnPerspectiveDialogMat, self._onSetPerspectiveMat, self)
	StoryController.instance:registerCallback(StoryEvent.OnResetPerspectiveDialogMat, self._onResetPerspectiveMat, self)
end

function StoryDialogItem:_onSetPerspectiveMat()
	local color = Color.New(1, 0, 1, 1)

	self._conMat:SetColor("_BloomColor", color)
	self._conMat:SetFloat("_BloomColorMask", 12)
end

function StoryDialogItem:_onResetPerspectiveMat()
	local color = Color.New(1, 1, 1, 1)

	self._conMat:SetColor("_BloomColor", color)
	self._conMat:SetFloat("_BloomColorMask", 8)
end

function StoryDialogItem:_removeEvent()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnPerspectiveDialogMat, self._onSetPerspectiveMat, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnResetPerspectiveDialogMat, self._onResetPerspectiveMat, self)
end

function StoryDialogItem:_checkCloseView(viewName)
	if viewName == ViewName.StoryLogView then
		self._isLogStop = false
	end
end

function StoryDialogItem:_btnlogOnClick(audioId)
	self._isLogStop = true

	if audioId == self._conAudioId then
		return
	end

	self._playingAudioId = 0

	if self._conAudioId ~= 0 and self._conAudioId then
		AudioEffectMgr.instance:stopAudio(self._conAudioId, 0)
	end
end

function StoryDialogItem:hideDialog()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	gohelper.setActive(self._gonormalcontent, false)
	gohelper.setActive(self._gosoftlightcontent, false)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)

	self._txtcontentcn.text = ""
	self._txtsoftlight.text = ""

	if self._conMat then
		self._conMat:DisableKeyword("_GRADUAL_ON")
	end

	if self._markTopMat then
		self._markTopMat:DisableKeyword("_GRADUAL_ON")
	end

	if self._subMeshs then
		for _, v in pairs(self._subMeshs) do
			if v.materialForRendering then
				v.materialForRendering:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	UIBlockMgr.instance:endBlock("delayShow")
	TaskDispatcher.cancelTask(self._delayShow, self)
	self:_showMagicItem(false)

	self._finishCallback = nil
	self._finishCallbackObj = nil
end

function StoryDialogItem:playDialog(diaTxt, stepCo, callback, callbackobj)
	self._stepCo = stepCo

	if not self._stepCo.conversation.audios[1] then
		local audioId = 0
		local diatxt = StoryModel.instance:getStoryTxtByVoiceType(diaTxt, audioId)

		diatxt = string.gsub(diatxt, "<notShowInLog>", "")

		self:clearSlideDialog()

		if self._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
			self:playSlideDialog(diatxt, callback, callbackobj)

			return
		end

		self._slideItem:hideDialog()
		gohelper.setActive(self._goconversation, true)
		gohelper.setActive(self._gonexticon, true)

		if StoryModel.instance:isMagicType(self._stepCo) then
			self:playMagicText(diatxt, callback, callbackobj)

			return
		end

		self:_showMagicItem(false)
		self:playNormalText(diatxt, callback, callbackobj)
	end
end

function StoryDialogItem:playMagicText(txt, callback, callbackobj)
	gohelper.setActive(self._goline, true)
	self:_showMagicItem(true)
	TaskDispatcher.cancelTask(self._playConAudio, self)
	gohelper.setActive(self._gonormalcontent, false)
	gohelper.setActive(self._gosoftlightcontent, false)

	self._textShowFinished = false
	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	if not self._magicEff then
		self._magicEff = StoryDialogEffsMagic.New()

		self._magicEff:init(self._gocontent)
	end

	self._magicEff:start(self._stepCo, txt, callback, callbackobj)

	local disableAudio = self._stepCo.conversation.disableAudio[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or false

	if disableAudio then
		return
	end

	local audioDelayTime = self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 0

	if audioDelayTime < 0.1 then
		self:_playConAudio()
	else
		TaskDispatcher.runDelay(self._playConAudio, self, audioDelayTime)
	end
end

function StoryDialogItem:_showMagicItem(show)
	gohelper.setActive(self._gomagiccontent, show)

	if self._magicEff then
		self._magicEff:showEff(show)
	end
end

function StoryDialogItem:_magicConFinished()
	self._textShowFinished = true

	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None or isLimitNoInteractLock then
		return
	end

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function StoryDialogItem:clearSlideDialog()
	if self._slideItem then
		self._slideItem:clearSlideDialog()
	end
end

function StoryDialogItem:playSlideDialog(txt, callback, callbackobj)
	local params = string.split(txt, "#")

	if #params ~= 3 then
		logError("配置异常，请检查配置[示例：gundongzimu_1#1.0#10.0](图片名#速度#时间)")

		return
	end

	gohelper.setActive(self._goconversation, false)
	gohelper.setActive(self._gonexticon, false)

	local data = {}

	data.img = params[1]
	data.speed = tonumber(params[2])
	data.showTime = tonumber(params[3])

	self._slideItem:startShowDialog(data, callback, callbackobj)
end

function StoryDialogItem:_isSoftLightStep()
	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		return true
	end

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLightDarkBg then
		return true
	end

	return false
end

function StoryDialogItem:playNormalText(txt, callback, callbackobj)
	if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
		local storyId = StoryController.instance._curStoryId
		local stepId = StoryController.instance._curStepId

		if storyId == 100601 and stepId == 36 then
			txt = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
		elseif storyId == 100602 and stepId == 30 then
			txt = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
		elseif storyId == 100726 and stepId == 32 then
			txt = "ははは！　死ね、無様な◯◯◯どもが！！"
		end
	end

	self._txt = txt
	self._textShowFinished = false

	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)

	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj
	self._markIndexs = StoryTool.getMarkTextIndexs(self._txt)
	self._subemtext = StoryTool.filterSpTag(self._txt)
	self._markTopList = StoryTool.getMarkTopTextList(self._subemtext)
	self._subemtext = StoryTool.filterMarkTop(self._subemtext)

	local hasGlitch = string.match(self._txt, "<glitch>")

	if self._glitchGo then
		gohelper.setActive(self._glitchGo, false)
	end

	self._dialogTextShowFinishedCallback = nil
	self._dialogTextShowFinishedCallbackObj = nil

	if hasGlitch then
		self._glitchTxt = string.gsub(self._txt, "<glitch>", "<i><b>")
		self._glitchTxt = string.gsub(self._glitchTxt, "</glitch>", "</i></b>")
		self._dialogTextShowFinishedCallback = self._onDialogTextShowFinished
		self._dialogTextShowFinishedCallbackObj = self

		if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			self._subemtext = string.gsub(self._subemtext, "<glitch>", "")
			self._subemtext = string.gsub(self._subemtext, "</glitch>", "")
		else
			self._subemtext = string.gsub(self._subemtext, "<glitch>", "<i><b>")
			self._subemtext = string.gsub(self._subemtext, "</glitch>", "</i></b>")
		end
	end

	self._isSoftLight = self._stepCo and self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight

	gohelper.setActive(self._gosoftlightcontent, self._isSoftLight)
	gohelper.setActive(self._gonormalcontent, not self._isSoftLight)

	if self._isSoftLight then
		self._targetTxt = self._txtsoftlight or self._txtcontentcn
	end

	if self._isSoftLight then
		self._conMat = self._softConMat or self._norConMat
	end

	if self._isSoftLight then
		self._godot = self._softdot or self._gonormaldot
	end

	if self._isSoftLight then
		self._dotMat = self._softdotMat or self._dotnormalMat
	end

	if self._isSoftLight then
		self._markTopMat = self._softmarkTopMat or self._normalmarkTopMat
	end

	if self._isSoftLight then
		self._conMark = self._softConMark or self._normalConMark
	end

	self._targetTxt.text = string.gsub(self._subemtext, "(<sprite=%d>)", "")

	if self._isSoftLight then
		if self._targetTxt.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			self._targetTxt.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			self._targetTxt.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)
			self._targetTxt.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			self._targetTxt.fontSharedMaterial.renderQueue = 4995

			self._targetTxt.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			self._targetTxt.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			self._targetTxt.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			self._targetTxt.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			self._targetTxt.fontSharedMaterial = self._targetTxt.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)

		self._softLightBloomOn = true

		gohelper.setActive(self._goline, false)
		gohelper.setActive(self._gonexticon, false)
		gohelper.setActive(self._goblackbottom, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLightDarkBg)
		transformhelper.setLocalPosXY(self._gonormalcontent.transform, 475, -50)
	else
		self._targetTxt.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		self._targetTxt.fontSharedMaterial = self._fontNormalMat

		self._targetTxt.fontSharedMaterial:SetFloat("_BloomFactor", 0)

		if self._softLightBloomOn then
			PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
			PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)

			self._softLightBloomOn = false
		end

		local showContent = self._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake

		gohelper.setActive(self._goline, showContent)
		gohelper.setActive(self._goblackbottom, showContent)
		gohelper.setActive(self._gonexticon, showContent)
	end

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		self:playHardIn()
	else
		self:playGradualIn()
	end
end

function StoryDialogItem:_onDialogTextShowFinished()
	local hasGlitch = string.match(self._txt, "<glitch>")

	gohelper.setActive(self._glitchGo, hasGlitch)

	if hasGlitch then
		self._glitchTxt = self:_getFitGlicthText(self._glitchTxt)

		self:_checkPlayGlitch(self._glitchTxt)
	end
end

function StoryDialogItem:_getFitGlicthText(glitchTxt)
	local txt = StoryTool.filterMarkTop(glitchTxt)

	txt = string.gsub(txt, "<nobr>", "")
	txt = string.gsub(txt, "</nobr>", "")
	txt = string.gsub(txt, "​", "")

	local textInfo = self._targetTxt:GetTextInfo(txt)
	local glitchWords = string.split(txt, "\n")

	if textInfo.lineCount <= 1 or #glitchWords > 1 then
		return txt
	end

	local hasStartGlitch = string.sub(txt, 1, string.len("<i><b>")) == "<i><b>"
	local hasEndGlitch = string.sub(txt, string.len(txt) - string.len("</i></b>") + 1, string.len(txt)) == "</i></b>"
	local isFullGlitch = hasStartGlitch and hasEndGlitch

	if isFullGlitch then
		return txt
	end

	local replaceTbs = {}

	for index = 1, textInfo.lineCount do
		local lineInfo = textInfo.lineInfo[index - 1]
		local curLineText = LuaUtil.subString(txt, lineInfo.firstCharacterIndex + 1, lineInfo.firstCharacterIndex + lineInfo.characterCount)
		local lineHasGlitchStart = string.find(curLineText, "<i><b>")
		local lineHasGlicthEnd = string.find(curLineText, "</i></b>")
		local endCharacterIndex = lineInfo.firstCharacterIndex + lineInfo.characterCount

		endCharacterIndex = lineHasGlitchStart and endCharacterIndex + string.len("<i><b>") or endCharacterIndex
		endCharacterIndex = lineHasGlicthEnd and endCharacterIndex + string.len("</i></b>") or endCharacterIndex
		curLineText = LuaUtil.subString(txt, lineInfo.firstCharacterIndex + 1, endCharacterIndex)

		if lineHasGlitchStart and not lineHasGlicthEnd then
			table.insert(replaceTbs, curLineText)
		end
	end

	if #replaceTbs > 0 then
		for i = 1, #replaceTbs do
			txt = string.gsub(txt, replaceTbs[i], replaceTbs[i] .. "</i></b>\n<i><b>")
		end
	end

	return txt
end

function StoryDialogItem:_checkPlayGlitch(txt)
	StoryTool.enablePostProcess(true)

	local hasStartGlitch = string.sub(txt, 1, string.len("<i><b>")) == "<i><b>"
	local hasEndGlitch = string.sub(txt, string.len(txt) - string.len("</i></b>") + 1, string.len(txt)) == "</i></b>"
	local isFullGlitch = hasStartGlitch and hasEndGlitch
	local resultTxt = txt

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		resultTxt = string.gsub(resultTxt, "<i><b>", "")
		resultTxt = string.gsub(resultTxt, "</i></b>", "")
	end

	local textInfo = self._targetTxt:GetTextInfo(resultTxt)
	local particleSystems = {}

	for i = 1, 5 do
		local parGlitch = gohelper.findChild(self._glitchGo, "part_" .. tostring(i)):GetComponent(typeof(UnityEngine.ParticleSystem))

		table.insert(particleSystems, parGlitch)
		gohelper.setActive(parGlitch.gameObject, false)
	end

	local uiCamera = CameraMgr.instance:getUICamera()
	local characterInfo = textInfo.characterInfo
	local lineLength = recthelper.getWidth(self._targetTxt.transform) + 121.8684
	local lineDatas = {}
	local glitchWords = string.split(txt, "\n")

	if #glitchWords > 1 then
		for index = 1, #glitchWords do
			local curLineText = glitchWords[index]
			local lineHasGlitch = string.find(curLineText, "<i><b>")
			local data = {}

			if not lineHasGlitch then
				data.hasGlitch = false
				data.startIndex = 0
				data.endIndex = 0
				data.lineTxt = curLineText

				table.insert(lineDatas, data)
			else
				local glitchStartIndex = string.find(curLineText, "<i><b>")
				local startTxt = string.sub(curLineText, 1, glitchStartIndex - 1)
				local subGlicthTxt = string.gsub(curLineText, "<i><b>", "")
				local glitchEndIndex = string.find(subGlicthTxt, "</i></b>")

				if not glitchEndIndex then
					if isDebugBuild then
						local storyId = StoryController.instance._curStoryId
						local stepId = StoryController.instance._curStepId

						logError(string.format("StoryId: %s StepId %s When using '<Glitch>' with multiple lines, please manually wrap the lines!", storyId, stepId))
					end

					return
				end

				local endTxt = string.sub(subGlicthTxt, 1, glitchEndIndex - 1)
				local curLineText = string.gsub(subGlicthTxt, "</i></b>", "")

				data.hasGlitch = true
				data.startIndex = utf8.len(startTxt)
				data.endIndex = utf8.len(endTxt)
				data.lineTxt = curLineText

				table.insert(lineDatas, data)
			end
		end
	else
		for index = 1, textInfo.lineCount do
			if isFullGlitch then
				local data = {}

				data.hasGlitch = true
				data.lineGlitch = true

				table.insert(lineDatas, data)
			else
				local lineInfo = textInfo.lineInfo[index - 1]
				local curLineText = LuaUtil.subString(txt, lineInfo.firstCharacterIndex + 1, lineInfo.firstCharacterIndex + lineInfo.characterCount)
				local lineHasGlitch = string.find(curLineText, "<i><b>")

				if lineHasGlitch then
					curLineText = LuaUtil.subString(txt, lineInfo.firstCharacterIndex + 1, lineInfo.firstCharacterIndex + lineInfo.characterCount + string.len("<i><b>") + string.len("</i></b>"))
				end

				local data = {}

				if not lineHasGlitch then
					data.hasGlitch = false
					data.startIndex = 0
					data.endIndex = 0
					data.lineText = curLineText

					table.insert(lineDatas, data)
				else
					local glitchStartIndex = string.find(curLineText, "<i><b>")
					local startTxt = string.sub(curLineText, 1, glitchStartIndex - 1)
					local subGlicthTxt = string.gsub(curLineText, "<i><b>", "")
					local glitchEndIndex = string.find(subGlicthTxt, "</i></b>")

					if not glitchEndIndex then
						if isDebugBuild then
							local storyId = StoryController.instance._curStoryId
							local stepId = StoryController.instance._curStepId

							logError(string.format("StoryId: %s StepId %s When using '<Glitch>' with multiple lines, please manually wrap the lines!", storyId, stepId))
						end

						return
					end

					local endTxt = string.sub(subGlicthTxt, 1, glitchEndIndex - 1)
					local curLineText = string.gsub(subGlicthTxt, "</i></b>", "")

					data.hasGlitch = true
					data.startIndex = utf8.len(startTxt)
					data.endIndex = utf8.len(endTxt)
					data.lineTxt = curLineText

					table.insert(lineDatas, data)
				end
			end
		end
	end

	local glitchLinePosYs = {
		{
			76,
			28,
			98,
			50,
			2
		},
		{
			76,
			28,
			98,
			50,
			2
		},
		{
			120,
			72,
			24,
			50,
			2
		},
		{
			168,
			120,
			72,
			24,
			2
		},
		{
			294,
			146,
			98,
			50,
			2
		}
	}

	for i = 1, #lineDatas do
		local x, y, z = transformhelper.getLocalPos(particleSystems[i].transform)

		if not lineDatas[i].hasGlitch then
			gohelper.setActive(particleSystems[i].gameObject, false)
		else
			gohelper.setActive(particleSystems[i].gameObject, true)

			local posY = glitchLinePosYs[#lineDatas][i]

			if lineDatas[i].lineGlitch then
				local x, y, z = transformhelper.getLocalPos(particleSystems[i].transform)

				transformhelper.setLocalPos(particleSystems[i].transform, 640, posY, z)

				particleSystems[i].shape.scale = Vector3(12, 0.4, 0)

				ZProj.ParticleSystemHelper.SetMaxParticles(particleSystems[i], 30)
			else
				local firstChar = characterInfo[0]
				local lineInfo = textInfo.lineInfo[i - 1]
				local startGlitchChar = characterInfo[lineInfo.firstCharacterIndex + lineDatas[i].startIndex]
				local endGlitchChar = characterInfo[lineInfo.firstCharacterIndex + lineDatas[i].endIndex - 1]
				local firstBL = uiCamera:WorldToScreenPoint(self._targetTxt.transform:TransformPoint(firstChar.bottomLeft))
				local startBL = uiCamera:WorldToScreenPoint(self._targetTxt.transform:TransformPoint(startGlitchChar.bottomLeft))
				local endBR = uiCamera:WorldToScreenPoint(self._targetTxt.transform:TransformPoint(endGlitchChar.bottomRight))
				local w = UnityEngine.Screen.width
				local h = UnityEngine.Screen.height
				local percent = math.min(1, 0.9 * w / (1.6 * h))
				local startTxtLength = 1080 * (startBL.x - firstBL.x) / (h * percent)
				local glitchTxtLength = 1144.8 * (endBR.x - startBL.x) / (h * percent)
				local scaleA = startTxtLength / lineLength
				local scaleB = glitchTxtLength / lineLength
				local posX = 647 * (2 * scaleA + scaleB)

				transformhelper.setLocalPos(particleSystems[i].transform, posX, posY, 0)

				local shapeX = 12 * scaleB * percent
				local shapeY = 0.4 * percent

				particleSystems[i].shape.scale = Vector3(shapeX, shapeY, 0)

				ZProj.ParticleSystemHelper.SetMaxParticles(particleSystems[i], math.floor(30 * scaleB))
			end
		end
	end
end

function StoryDialogItem:playHardIn()
	self:_showMagicItem(false)
	gohelper.setActive(self._gonormalcontent, true)
	UIBlockMgr.instance:endBlock("delayShow")
	TaskDispatcher.cancelTask(self._delayShow, self)
	self:conFinished()
end

function StoryDialogItem:playGradualIn()
	local height = UnityEngine.Screen.height

	if self._conMat then
		self._conMat:EnableKeyword("_GRADUAL_ON")
		self._conMat:DisableKeyword("_DISSOLVE_ON")
		self._conMat:SetFloat(self._LineMinYId, height)
		self._conMat:SetFloat(self._LineMaxYId, height)
	end

	if self._markTopMat then
		self._markTopMat:EnableKeyword("_GRADUAL_ON")
		self._markTopMat:DisableKeyword("_DISSOLVE_ON")
		self._markTopMat:SetFloat(self._LineMinYId, height)
		self._markTopMat:SetFloat(self._LineMaxYId, height)
	end

	self._subMeshs = {}

	local subMeshs = self._targetTxt.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:EnableKeyword("_GRADUAL_ON")
			v.materialForRendering:DisableKeyword("_DISSOLVE_ON")
			v.materialForRendering:SetFloat(self._LineMinYId, height)
			v.materialForRendering:SetFloat(self._LineMaxYId, height)
		end
	end

	self._dotMat:SetFloat(self._LineMinYId, height)
	self._dotMat:SetFloat(self._LineMaxYId, height)
	self:_showMagicItem(false)
	gohelper.setActive(self._gonormalcontent, true)

	local x, y, z = transformhelper.getLocalPos(self._targetTxt.transform)

	transformhelper.setLocalPos(self._targetTxt.transform, x, y, 1)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	UIBlockMgr.instance:startBlock("delayShow")
	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self._delayShow, self, 0.05)
end

function StoryDialogItem:_delayShow()
	UIBlockMgr.instance:endBlock("delayShow")

	local height = UnityEngine.Screen.height

	self._dotMat:SetFloat(self._LineMinYId, height)
	self._dotMat:SetFloat(self._LineMaxYId, height)

	self._textInfo = self._targetTxt:GetTextInfo(self._subemtext)
	self._lineInfoList = {}

	local totalVisibleCharacterCount = 0

	for i = 1, self._textInfo.lineCount do
		local lineInfo = self._textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		table.insert(self._lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount
		})
	end

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self._targetTxt.transform)
	self._curLine = nil

	local delay = self:_getDelayTime(totalVisibleCharacterCount)
	local curLangType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	if curLangType == LangSettings.en then
		delay = delay * 0.67
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	local disableAudio = self._stepCo.conversation.disableAudio[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or false

	if not disableAudio then
		local audioDelayTime = self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 0

		if audioDelayTime < 0.1 then
			self:_playConAudio()
		else
			TaskDispatcher.runDelay(self._playConAudio, self, audioDelayTime)
		end
	end

	self._lastBottomLeft = 0
	self._lineSpace = 0
	self._hasUnderline = string.find(self._subemtext, "<u>") and string.find(self._subemtext, "</u>")
	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, totalVisibleCharacterCount, delay, self._conUpdate, self._onTextFinished, self, nil, EaseType.Linear)
end

function StoryDialogItem:_getDelayTime(characterCount)
	local speed = 1

	if self._txt and string.find(self._txt, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(self._txt, string.find(self._txt, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	local time = 0.08 * characterCount
	local curStoryIndex = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	if curStoryIndex == LanguageEnum.LanguageStoryType.EN then
		time = time * 0.67
	end

	time = time / speed

	return time
end

function StoryDialogItem:_playConAudio()
	if self._isLogStop then
		return
	end

	self:stopConAudio()

	if StoryModel.instance:isSpecialVideoPlaying() then
		return
	end

	self._conAudioId = self._stepCo.conversation.audios[1] or 0

	if self._conAudioId ~= 0 then
		local param = {}

		param.loopNum = 1
		param.fadeInTime = 0
		param.fadeOutTime = 0
		param.volume = 100
		param.callback = self._onConAudioFinished
		param.callbackTarget = self
		self._playingAudioId = self._conAudioId

		local isOverseas = SettingsModel.instance:isOverseas()
		local isSpVersionStory = StoryModel.instance:isSpVersionStory()
		local curVoice = GameConfig:GetCurVoiceShortcut()
		local isSpVoiceType = curVoice == LangSettings.shortcutTab[LangSettings.jp] or curVoice == LangSettings.shortcutTab[LangSettings.kr]
		local playSp = not isOverseas and isSpVersionStory and isSpVoiceType

		if playSp then
			param.audioLang = curVoice

			AudioEffectMgr.instance:playAudio(self._conAudioId, param, param.audioLang)
		else
			AudioEffectMgr.instance:playAudio(self._conAudioId, param)
		end
	else
		self._playingAudioId = 0
	end

	self._hasLowPassAudio = false

	if #self._stepCo.conversation.audios > 1 then
		for _, v in pairs(self._stepCo.conversation.audios) do
			if v == AudioEnum.Story.Play_Lowpass then
				self._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				return
			end
		end
	end
end

function StoryDialogItem:_onTextFinished()
	self:_showMagicItem(false)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	local x, y, z = transformhelper.getLocalPos(self._targetTxt.transform)

	transformhelper.setLocalPos(self._targetTxt.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._conMat:SetFloat(self._LineMinYId, 0)
	self._conMat:SetFloat(self._LineMaxYId, 0)

	self._subMeshs = {}

	local subMeshs = self._targetTxt.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.sharedMaterial then
			v.sharedMaterial = self._fontNormalMat

			v.sharedMaterial:DisableKeyword("_GRADUAL_ON")
		end
	end

	self._textShowFinished = true

	local isAuto = StoryModel.instance:isStoryAuto()
	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if self._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and self._stepCo.conversation.type ~= StoryEnum.ConversationType.None and not isLimitNoInteractLock then
		isAuto = isAuto or self._stepCo.conversation.isAuto
	end

	if not isAuto or self._playingAudioId == 0 then
		self:conFinished()
	end
end

function StoryDialogItem:_onConAudioFinished(audioId)
	if self._textShowFinished then
		if StoryModel.instance:isMagicType(self._stepCo) then
			self:_magicConFinished()
		else
			self:conFinished()
		end
	end

	if self._playingAudioId == audioId then
		self._playingAudioId = 0
	end
end

function StoryDialogItem:stopConAudio()
	if self._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)
	end

	if self._isLogStop then
		return
	end

	self._playingAudioId = 0

	if self._conAudioId ~= 0 and self._conAudioId then
		AudioEffectMgr.instance:stopAudio(self._conAudioId, 0)
	end
end

function StoryDialogItem:_conUpdate(value)
	local screenWidth = UnityEngine.Screen.width
	local contentTransform = self._targetTxt.transform
	local uiCamera = CameraMgr.instance:getUICamera()

	self._subMeshs = {}

	local subMeshs = self._targetTxt.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for i, v in ipairs(self._lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount then
			local characterInfo = self._textInfo.characterInfo
			local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
			local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
			local firstBL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.bottomLeft))
			local maxBL = firstBL
			local minbly = firstBL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.bottomLeft))

				if minbly > tl.y then
					minbly = tl.y
				end
			end

			maxBL.y = minbly

			local firstTL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.topLeft))
			local maxTL = firstTL
			local maxtly = firstTL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.topLeft))

				if maxtly < tl.y then
					maxtly = tl.y
				end
			end

			maxTL.y = maxtly

			local lastBR = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(lastChar.bottomRight))

			for _, mesh in pairs(self._subMeshs) do
				if mesh.sharedMaterial then
					if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
						break
					end

					mesh.sharedMaterial = self._fontNormalMat
				end
			end

			if i == 1 then
				if self._hasUnderline then
					self._conMat:SetFloat(self._LineMinYId, maxBL.y - 4)
				else
					self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				end

				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 20)
				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			else
				if self._lastBottomLeft - maxTL.y > 0 then
					self._lineSpace = self._lastBottomLeft - maxTL.y or self._lineSpace
				end

				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + self._lineSpace)
				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			end

			self._lastBottomLeft = maxBL.y

			local go = self._targetTxt.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local isSoftLight = self:_isSoftLightStep()
			local posZ = isSoftLight and 0 or 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self._txtcontentcn.transform, self._contentX, self._contentY, posZ)

			if isSoftLight then
				self._conMat:SetFloat(self._LineMinYId, 0)
				self._conMat:SetFloat(self._LineMaxYId, 0)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, 0)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, 0)
					end
				end
			end
		end
	end
end

function StoryDialogItem:conFinished()
	self._textShowFinished = true

	if self._dialogTextShowFinishedCallback then
		self._dialogTextShowFinishedCallback(self._dialogTextShowFinishedCallbackObj)

		self._dialogTextShowFinishedCallback = nil
		self._dialogTextShowFinishedCallbackObj = nil
	end

	if self._stepCo and (self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	self:_destoryMagic()

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._conMat then
		self._conMat:SetFloat(self._LineMinYId, 0)
		self._conMat:SetFloat(self._LineMaxYId, 0)
	end

	if self._targetTxt then
		local x, y, z = transformhelper.getLocalPos(self._targetTxt.transform)

		transformhelper.setLocalPos(self._targetTxt.transform, x, y, 0)

		self._subMeshs = {}

		local subMeshs = self._targetTxt.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

		if subMeshs then
			local iter = subMeshs:GetEnumerator()

			while iter:MoveNext() do
				local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

				table.insert(self._subMeshs, subMesh)
			end
		end

		for _, v in pairs(self._subMeshs) do
			if v.sharedMaterial then
				v.sharedMaterial:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	self:_showMagicItem(false)

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function StoryDialogItem:playNorDialogFadeIn(callback, callbackobj)
	ZProj.TweenHelper.DoFade(self._targetTxt, 0, 1, 2, function()
		if callback then
			callback(callbackobj)
		end
	end, nil, nil, EaseType.Linear)
end

function StoryDialogItem:playWordByWord(callback, callbackobj)
	self._targetTxt.text = ""

	ZProj.TweenHelper.DOText(self._targetTxt, self._diatxt, 2, function()
		if callback then
			callback(callbackobj)
		end
	end)
end

function StoryDialogItem:startAutoEnterNext()
	if self._playingAudioId == 0 and self._textShowFinished then
		if StoryModel.instance:isMagicType(self._stepCo) then
			self:_magicConFinished()

			return
		end

		self:conFinished()
	end
end

function StoryDialogItem:checkAutoEnterNext(callback, callbackobj)
	self._diaFinishedCallback = callback
	self._diaFinishedCallbackObj = callbackobj

	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	TaskDispatcher.runRepeat(self._onSecond, self, 0.1)
end

function StoryDialogItem:_onSecond()
	if self._playingAudioId == 0 and self._textShowFinished then
		TaskDispatcher.cancelTask(self._onSecond, self)
		TaskDispatcher.cancelTask(self._waitSecondFinished, self)
		TaskDispatcher.runDelay(self._waitSecondFinished, self, 2)
	end
end

function StoryDialogItem:isAudioPlaying()
	return self._playingAudioId ~= 0
end

function StoryDialogItem:_waitSecondFinished()
	if self._diaFinishedCallback then
		self._diaFinishedCallback(self._diaFinishedCallbackObj)
	end
end

function StoryDialogItem:storyFinished()
	self._finishCallback = nil
	self._finishCallbackObj = nil
end

function StoryDialogItem:_destoryMagic()
	if self._magicEff then
		self._magicEff:destroy()

		self._magicEff = nil
	end
end

function StoryDialogItem:destroy()
	UIBlockMgr.instance:endBlock("delayShow")

	if self._targetTxt then
		self._targetTxt.fontSharedMaterial = self._fontNormalMat
		self._targetTxt = nil
	end

	self:_removeEvent()
	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	self:stopConAudio()
	self:_destoryMagic()

	if self._slideItem then
		self._slideItem:destroy()

		self._slideItem = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)

	self._finishCallback = nil
	self._finishCallbackObj = nil

	if self._conMat then
		self._conMat:DisableKeyword("_GRADUAL_ON")
	end

	if self._markTopMat then
		self._markTopMat:DisableKeyword("_GRADUAL_ON")
	end

	if self._subMeshs then
		for _, v in pairs(self._subMeshs) do
			if v.materialForRendering then
				v.materialForRendering:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	self:_removeEvent()

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end
end

return StoryDialogItem
