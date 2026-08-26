-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114DialogBaseItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114DialogBaseItem", package.seeall)

local Activity114DialogBaseItem = class("Activity114DialogBaseItem")

function Activity114DialogBaseItem:init(go)
	self._conGo = go
	self._gonexticon = gohelper.findChild(go, "nexticon")
	self._goconversation = gohelper.findChild(go, "#go_conversation")
	self._goblackbottom = gohelper.findChild(go, "#go_conversation/blackBottom")
	self._contentGO = gohelper.findChild(go, "#go_conversation/#go_contents")
	self._goline = gohelper.findChild(self._contentGO, "line")
	self._norDiaGO = gohelper.findChild(self._contentGO, "go_normalcontent")
	self._txtcontentcn = gohelper.findChildText(self._norDiaGO, "txt_contentcn")
	self._conMat = self._txtcontentcn.fontMaterial

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
	self._txtdot = gohelper.findChild(self._norDiaGO, "txt_contentcn/storytxtdot")
	self._txtmarktop = gohelper.findChildText(self._norDiaGO, "txt_contentcn/storymarktop")
	self._dotMat = self._txtdot.transform:GetComponent(gohelper.Type_Image).material
	self._markTopMat = self._txtmarktop.fontMaterial
	self._conMark = gohelper.onceAddComponent(self._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	self._conMark:SetMarkGo(self._txtdot)
	self._conMark:SetMarkTopGo(self._txtmarktop.gameObject)

	self._magicDiaGO = gohelper.findChild(self._contentGO, "go_magiccontent")
	self._txtcontentmagic = gohelper.findChildText(self._magicDiaGO, "txt_contentmagic")
	self._gofirework = gohelper.findChild(self._magicDiaGO, "txt_contentmagic/go_firework")
	self._txtcontentreshapemagic = gohelper.findChildText(self._magicDiaGO, "txt_contentreshapemagic")
	self._goreshapefirework = gohelper.findChild(self._magicDiaGO, "txt_contentreshapemagic/go_reshapefirework")

	self:_showMagicItem(false)

	self._goslidecontent = gohelper.findChild(go, "#go_slidecontent")
	self._slideItem = StoryDialogSlideItem.New()

	self._slideItem:init(self._goslidecontent)
	self._slideItem:hideDialog()

	local storyviewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	self._roleAudioGo = gohelper.findChild(storyviewGo, "go_roleaudio")
	self._roleLeftAudioGo = gohelper.findChild(self._roleAudioGo, "left")
	self._roleMidAudioGo = gohelper.findChild(self._roleAudioGo, "middle")
	self._roleRightAudioGo = gohelper.findChild(self._roleAudioGo, "right")
	self._fontNormalMat = self._txtcontentcn.fontSharedMaterial

	self:_loadRes()
	self:_addEvent()
end

function Activity114DialogBaseItem:_loadRes()
	self._magicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	self._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	self._effLoader = MultiAbLoader.New()

	self._effLoader:addPath(self._magicFirePath)
	self._effLoader:addPath(self._reshapeMagicFirePath)
	self._effLoader:startLoad(self._magicFireEffectLoaded, self)
end

function Activity114DialogBaseItem:_magicFireEffectLoaded(loader)
	local assetItem = loader:getAssetItem(self._magicFirePath)

	self._magicFireGo = gohelper.clone(assetItem:GetResource(self._magicFirePath), self._gofirework)

	gohelper.setActive(self._magicFireGo, false)

	self._magicFireAnim = self._magicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local reshapeAssetItem = loader:getAssetItem(self._reshapeMagicFirePath)

	self._reshapeMagicFireGo = gohelper.clone(reshapeAssetItem:GetResource(self._reshapeMagicFirePath), self._goreshapefirework)

	gohelper.setActive(self._reshapeMagicFireGo, false)

	self._reshapeMagicFireAnim = self._reshapeMagicFireGo:GetComponent(typeof(UnityEngine.Animator))
end

function Activity114DialogBaseItem:_addEvent()
	StoryController.instance:registerCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
end

function Activity114DialogBaseItem:_removeEvent()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
end

function Activity114DialogBaseItem:_checkCloseView(viewName)
	if viewName == ViewName.StoryLogView then
		self._isLogStop = false
	end
end

function Activity114DialogBaseItem:_btnlogOnClick(audioId)
	self._isLogStop = true

	if audioId == self._conAudioId then
		return
	end

	self._playingAudioId = 0

	if self._conAudioId ~= 0 and self._conAudioId then
		AudioEffectMgr.instance:stopAudio(self._conAudioId, 0)
	end
end

function Activity114DialogBaseItem:hideDialog()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)

		self._magicConTweenId = nil
	end

	gohelper.setActive(self._norDiaGO, false)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)

	self._txtcontentcn.text = ""

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")
	TaskDispatcher.cancelTask(self._delayShow, self)
	self:_showMagicItem(false)

	self._finishCallback = nil
	self._finishCallbackObj = nil

	local x2, y2, z2 = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x2, y2, 1)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x2, y2, 1)

	self._txtcontentmagic.text = ""
	self._txtcontentreshapemagic.text = ""
end

function Activity114DialogBaseItem:playDialog(diaTxt, stepCo, callback, callbackobj)
	self._stepCo = stepCo

	if not self._stepCo.conversation.audios[1] then
		local audioId = 0
		local diatxt = StoryModel.instance:getStoryTxtByVoiceType(diaTxt, audioId)

		self:clearSlideDialog()

		if self._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
			self:playSlideDialog(diatxt, callback, callbackobj)

			return
		end

		self._slideItem:hideDialog()
		gohelper.setActive(self._goconversation, true)
		gohelper.setActive(self._gonexticon, true)

		if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			self:playMagicText(diatxt, callback, callbackobj)
		else
			self:playNormalText(diatxt, callback, callbackobj)
		end
	end
end

function Activity114DialogBaseItem:clearSlideDialog()
	if self._slideItem then
		self._slideItem:clearSlideDialog()
	end
end

function Activity114DialogBaseItem:playSlideDialog(txt, callback, callbackobj)
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

function Activity114DialogBaseItem:playMagicText(txt, callback, callbackobj)
	gohelper.setActive(self._goline, true)
	self:_showMagicItem(true)
	TaskDispatcher.cancelTask(self._playConAudio, self)
	gohelper.setActive(self._norDiaGO, false)

	self._txt = StoryTool.filterSpTag(txt)
	self._textShowFinished = false
	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj
	self._txtcontentmagic.text = self._txt
	self._txtcontentreshapemagic.text = self._txt

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 1)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 1)

	local delay = self:_getMagicWordShowTime(txt)

	self._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, delay, self._magicConUpdate, self._onMagicTextFinished, self, nil, EaseType.Linear)

	self._magicFireAnim:Play("story_magicfont_particle")
	self._reshapeMagicFireAnim:Play("story_magicfont_particle")
	gohelper.setActive(self._magicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic)
	gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
	gohelper.setActive(self._txtcontentmagic.gameObject, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic)
	gohelper.setActive(self._txtcontentreshapemagic, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)

	if self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playConAudio()
	else
		TaskDispatcher.runDelay(self._playConAudio, self, self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	if delay > 0 then
		self._magicFireAnim.speed = 1 / delay
		self._reshapeMagicFireAnim.speed = 1 / delay
	end
end

function Activity114DialogBaseItem:_getMagicWordShowTime(txt)
	local result = string.gsub(txt, "%%", "--------")

	result = string.gsub(result, "%&", "--------")

	local wordSize = LuaUtil.getCharNum(result)
	local speed = 0.1

	if wordSize < 30 then
		speed = 0.2
	end

	if wordSize < 15 then
		speed = 0.5
	end

	if result and string.find(result, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(result, string.find(result, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	return speed * wordSize
end

function Activity114DialogBaseItem:_magicConUpdate(value)
	local width = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic and recthelper.getWidth(self._txtcontentmagic.gameObject.transform) or recthelper.getWidth(self._txtcontentreshapemagic.gameObject.transform)

	if value > (width + 100) / 2215 and width > 1 then
		if self._magicConTweenId then
			ZProj.TweenHelper.KillById(self._magicConTweenId)

			self._magicConTweenId = nil
		end

		self:_onMagicTextFinished()

		return
	end

	local conWidth = 1107.5
	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		x, y, z = transformhelper.getLocalPos(self._txtcontentreshapemagic.transform)
	end

	local screenWidth, screenheight = UnityEngine.Screen.width, UnityEngine.Screen.height
	local startPosX = 0
	local posX = transformhelper.getLocalPos(self._contentGO.transform)

	startPosX = screenWidth / screenheight >= 1.7777777777777777 and 0.5 * (1080 * screenWidth / screenheight - 1920) + (960 + posX) or 960 - 0.5 * (1920 - 1080 * screenWidth / screenheight) + posX

	local rate = (startPosX + value * (conWidth + 10)) / (1920 * (1080 * screenWidth / (1920 * screenheight)))
	local screenposy = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic and recthelper.uiPosToScreenPos(self._txtcontentmagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y or recthelper.uiPosToScreenPos(self._txtcontentreshapemagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y
	local psPos = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic and recthelper.screenPosToAnchorPos(Vector2(rate * screenWidth, screenposy), self._gofirework.transform) or recthelper.screenPosToAnchorPos(Vector2(rate * screenWidth, screenposy), self._goreshapefirework.transform)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic then
		transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 1 - rate)
		transformhelper.setLocalPos(self._magicFireGo.transform, psPos.x, psPos.y, 0)
	else
		transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 1 - rate)
		transformhelper.setLocalPos(self._reshapeMagicFireGo.transform, psPos.x, psPos.y, 0)
	end
end

function Activity114DialogBaseItem:_magicConFinished()
	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	gohelper.setActive(self._magicFireGo, false)
	gohelper.setActive(self._reshapeMagicFireGo, false)

	self._magicFireAnim.speed = 1
	self._reshapeMagicFireAnim.speed = 1

	if self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return
	end

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function Activity114DialogBaseItem:playNormalText(txt, callback, callbackobj)
	self._txt = txt
	self._textShowFinished = false

	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)

	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj
	self._markIndexs = StoryTool.getMarkTextIndexs(self._txt)
	self._subemtext = StoryTool.filterSpTag(self._txt)
	self._markTop, self._markContent = StoryTool.getMarkTopTextList(self._subemtext)
	self._subemtext = StoryTool.filterMarkTop(self._subemtext)
	self._txtcontentcn.text = string.gsub(self._subemtext, "(<sprite=%d>)", "")
	self._txtcontentmagic.text = ""
	self._txtcontentreshapemagic.text = ""

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		self._txtcontentcn.alignment = TMPro.TextAlignmentOptions.Top

		if self._txtcontentcn.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			self._txtcontentcn.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			self._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			self._txtcontentcn.fontSharedMaterial.renderQueue = 4995

			local color = Color.New(0, 0, 0, 0.75)

			self._txtcontentcn.fontSharedMaterial:SetColor("_UnderlayColor", color)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			self._txtcontentcn.fontSharedMaterial = self._txtcontentcn.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
		gohelper.setActive(self._goline, false)
		gohelper.setActive(self._goblackbottom, false)
		gohelper.setActive(self._gonexticon, false)
		transformhelper.setLocalPosXY(self._norDiaGO.transform, 475, -50)
	else
		self._txtcontentcn.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		self._txtcontentcn.alignment = TMPro.TextAlignmentOptions.TopLeft
		self._txtcontentcn.fontSharedMaterial = self._fontNormalMat

		self._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)
		gohelper.setActive(self._goline, true)
		gohelper.setActive(self._goblackbottom, true)
		gohelper.setActive(self._gonexticon, true)
		transformhelper.setLocalPosXY(self._norDiaGO.transform, 550, 0)
	end

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		self:_playHardIn()
	else
		self:_playGradualIn()
	end
end

function Activity114DialogBaseItem:_playHardIn()
	self:_showMagicItem(false)
	gohelper.setActive(self._norDiaGO, true)
	self:conFinished()
end

function Activity114DialogBaseItem:_playGradualIn()
	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:DisableKeyword("_DISSOLVE_ON")
	self._markTopMat:EnableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_DISSOLVE_ON")

	local height = UnityEngine.Screen.height

	self._conMat:SetFloat(self._LineMinYId, height)
	self._conMat:SetFloat(self._LineMaxYId, height)
	self._markTopMat:SetFloat(self._LineMinYId, height)
	self._markTopMat:SetFloat(self._LineMaxYId, height)

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:SetFloat(self._LineMinYId, height)
			v.materialForRendering:SetFloat(self._LineMaxYId, height)
			v.materialForRendering:EnableKeyword("_GRADUAL_ON")
		end
	end

	self._dotMat:SetFloat(self._LineMinYId, height)
	self._dotMat:SetFloat(self._LineMaxYId, height)
	self:_showMagicItem(false)
	gohelper.setActive(self._norDiaGO, true)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)
	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self._delayShow, self, 0.05)
end

function Activity114DialogBaseItem:_showMagicItem(show)
	if show then
		if self._magicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end

		if self._reshapeMagicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end
	else
		self._txtcontentmagic.text = ""
		self._txtcontentreshapemagic.text = ""

		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)
	end
end

function Activity114DialogBaseItem:_delayShow()
	self._textInfo = self._txtcontentcn:GetTextInfo(self._subemtext)
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

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self._txtcontentcn.transform)
	self._curLine = nil

	local delay = self:_getDelayTime(totalVisibleCharacterCount)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playConAudio()
	else
		TaskDispatcher.runDelay(self._playConAudio, self, self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, totalVisibleCharacterCount, delay, self._conUpdate, self._onTextFinished, self, nil, EaseType.Linear)
end

function Activity114DialogBaseItem:_getDelayTime(characterCount)
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

function Activity114DialogBaseItem:_playConAudio()
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
		param.audioGo = self:_getDialogGo()
		param.callback = self._onConAudioFinished
		param.callbackTarget = self
		self._playingAudioId = self._conAudioId

		AudioEffectMgr.instance:playAudio(self._conAudioId, param)
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

function Activity114DialogBaseItem:_getDialogGo()
	local audioGo = self._roleMidAudioGo

	if #self._stepCo.heroList > 0 and self._stepCo.conversation.showList[1] then
		if not self._stepCo.heroList[self._stepCo.conversation.showList[1] + 1] then
			return audioGo
		end

		local pos = self._stepCo.heroList[self._stepCo.conversation.showList[1] + 1].heroDir

		if pos and pos == 0 then
			audioGo = self._roleLeftAudioGo
		end

		if pos and pos == 2 then
			audioGo = self._roleRightAudioGo
		end
	end

	return audioGo
end

function Activity114DialogBaseItem:_onTextFinished()
	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)
		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)

		self._magicFireAnim.speed = 1
		self._reshapeMagicFireAnim.speed = 1
		self._magicConTweenId = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 0)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	self._textShowFinished = true

	local isAuto = StoryModel.instance:isStoryAuto()

	if self._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and self._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		isAuto = isAuto or self._stepCo.conversation.isAuto
	end

	if not isAuto or self._playingAudioId == 0 then
		self:conFinished()
	end
end

function Activity114DialogBaseItem:_onMagicTextFinished()
	self._textShowFinished = true

	self:_magicConFinished()
end

function Activity114DialogBaseItem:_onConAudioFinished(audioId)
	if self._textShowFinished then
		if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			self:_magicConFinished()
		else
			self:conFinished()
		end
	end

	if self._playingAudioId == audioId then
		self._playingAudioId = 0
	end
end

function Activity114DialogBaseItem:stopConAudio()
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

function Activity114DialogBaseItem:_conUpdate(value)
	local screenWidth = UnityEngine.Screen.width
	local contentTransform = self._txtcontentcn.transform
	local uiCamera = CameraMgr.instance:getUICamera()

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

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

			if i == 1 then
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 10)
				self._markTopMat:SetFloat(self._LineMinYId, maxBL.y - 100)
				self._markTopMat:SetFloat(self._LineMaxYId, maxTL.y - 90)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y + 10)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			else
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y)
				self._markTopMat:SetFloat(self._LineMinYId, maxBL.y)
				self._markTopMat:SetFloat(self._LineMaxYId, maxTL.y)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			end

			local go = self._txtcontentcn.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local posZ = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight and 0 or 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self._txtcontentcn.transform, self._contentX, self._contentY, posZ)

			if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
				self._conMat:SetFloat(self._LineMinYId, 0)
				self._conMat:SetFloat(self._LineMaxYId, 0)

				if #self._lineInfoList > 1 then
					transformhelper.setLocalPosXY(self._norDiaGO.transform, 475, 50 * (#self._lineInfoList - 2))
				end
			end
		end
	end
end

function Activity114DialogBaseItem:conFinished()
	self._textShowFinished = true

	if self._stepCo and (self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)
		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)

		self._magicFireAnim.speed = 1
		self._reshapeMagicFireAnim.speed = 1
		self._magicConTweenId = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._conMat:SetFloat(self._LineMinYId, 0)
	self._conMat:SetFloat(self._LineMaxYId, 0)
	self._markTopMat:SetFloat(self._LineMinYId, 0)
	self._markTopMat:SetFloat(self._LineMaxYId, 0)

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:SetFloat(self._LineMinYId, 0)
			v.materialForRendering:SetFloat(self._LineMaxYId, 0)
		end
	end

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 0)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function Activity114DialogBaseItem:playNorDialogFadeIn(callback, callbackobj)
	ZProj.TweenHelper.DoFade(self._txtcontentcn, 0, 1, 2, function()
		if callback then
			callback(callbackobj)
		end
	end, nil, nil, EaseType.Linear)
end

function Activity114DialogBaseItem:playWordByWord(callback, callbackobj)
	self._txtcontentcn.text = ""

	ZProj.TweenHelper.DOText(self._txtcontentcn, self._diatxt, 2, function()
		if callback then
			callback(callbackobj)
		end
	end)
end

function Activity114DialogBaseItem:startAutoEnterNext()
	if self._playingAudioId == 0 and self._textShowFinished then
		if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			self:_magicConFinished()
		else
			self:conFinished()
		end
	end
end

function Activity114DialogBaseItem:checkAutoEnterNext(callback, callbackobj)
	self._diaFinishedCallback = callback
	self._diaFinishedCallbackObj = callbackobj

	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	TaskDispatcher.runRepeat(self._onSecond, self, 0.1)
end

function Activity114DialogBaseItem:_onSecond()
	if self._playingAudioId == 0 and self._textShowFinished then
		TaskDispatcher.cancelTask(self._onSecond, self)
		TaskDispatcher.cancelTask(self._waitSecondFinished, self)
		TaskDispatcher.runDelay(self._waitSecondFinished, self, 2)
	end
end

function Activity114DialogBaseItem:isAudioPlaying()
	return self._playingAudioId ~= 0
end

function Activity114DialogBaseItem:_waitSecondFinished()
	if self._diaFinishedCallback then
		self._diaFinishedCallback(self._diaFinishedCallbackObj)
	end
end

function Activity114DialogBaseItem:storyFinished()
	self._finishCallback = nil
	self._finishCallbackObj = nil
end

function Activity114DialogBaseItem:destroy()
	self._txtcontentcn.fontSharedMaterial = self._fontNormalMat

	self:_removeEvent()
	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	self:stopConAudio()

	if self._slideItem then
		self._slideItem:destroy()

		self._slideItem = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)

		self._magicConTweenId = nil
	end

	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)

	self._finishCallback = nil
	self._finishCallbackObj = nil

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")
	self:_removeEvent()

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end
end

return Activity114DialogBaseItem
