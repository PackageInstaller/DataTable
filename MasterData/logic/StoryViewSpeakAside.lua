-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewSpeakAside.lua

module("logic.extensions.story.view.story.StoryViewSpeakAside", package.seeall)

local StoryViewSpeakAside = class("StoryViewSpeakAside", StoryViewComponent)

function StoryViewSpeakAside:ctor(view, mainGO)
	self._view = view
	self.mainGO = mainGO
	self._textNode = goutil.findChild(self.mainGO, "TextNode").transform
	self._textGroup = self._textNode:GetComponent("CanvasGroup")
	self._textFadeOut = self._textNode:GetComponent(UnityTweensType.UITweenFadeOut)
	self._text = goutil.findChild(self.mainGO, "TextNode/Text"):GetComponent("Text")
	self._clickMask = goutil.findChild(self.mainGO, "ClickMask")

	Framework.UIClickTrigger.Get(self._clickMask):AddClickListener(self._onClickMask, self, nil)

	local continue = goutil.findChild(self.mainGO, "Continue")
	local continueText = goutil.findChildTextComponent(self.mainGO, "Continue/Text")

	continueText.text = lang("click_continue")
	self._continueCanvas = continue:GetComponent("CanvasGroup")
	self._continueFadeIn = continue:GetComponent(UnityTweensType.UITweenFadeIn)
	self._continueFadeOut = continue:GetComponent(UnityTweensType.UITweenFadeOut)
	self._cachesTexts = nil
	self._textFadeOut.time = StoryConst.FadeOut_Time

	self._text.gameObject:SetActive(false)
end

function StoryViewSpeakAside:onEnter()
	StoryViewSpeakAside.super.onEnter(self)
	self.mainGO:SetActive(false)
	self._textFadeOut:Stop()
	self._textFadeOut:AddListener(self._onStoryFinish, self)

	self._textGroup.alpha = 1

	self._continueFadeIn:Stop()
	self._continueFadeOut:Stop()

	self._continueCanvas.alpha = 0

	self._continueFadeIn:AddListener(self._onTweenContinueFinish, self)
end

function StoryViewSpeakAside:startStory(currStory)
	self:_dispearAll()
	self.mainGO:SetActive(true)
	self._textFadeOut:Stop()

	self._textGroup.alpha = 1
	self._currStory = currStory
	self._currIdx = 1
	self._closable = nil
	self._isClickContinue = nil

	self._continueFadeIn:Stop()
	self._continueFadeOut:Stop()

	self._continueCanvas.alpha = 0
	self._currSpeakAsides = {}

	for k, v in ipairs(self._currStory.speakAsides) do
		local config = {
			config = self._currStory.speakAsides[k]
		}

		table.insert(self._currSpeakAsides, config)
		self:_createSpeakAsideConfig(config)
	end

	self:_updateTextPosition()
	self:_showSpeakAside(self._currIdx)
end

function StoryViewSpeakAside:endStory()
	return
end

function StoryViewSpeakAside:onExit()
	self._continueFadeIn:RemoveListener()
	StoryViewSpeakAside.super.onExit(self)
	self._textFadeOut:RemoveListener()
	self:_clearTexts()

	self._currSpeakAsides = nil
	self.currStory = nil
	self._closable = nil
	self._isClickContinue = nil
end

function StoryViewSpeakAside:_clearTexts()
	if self._cachesTexts then
		for i = 1, #self._cachesTexts do
			local text = self._cachesTexts[i].gameObject

			self:_clearTextListeners(text)
			UnityEngine.GameObject.Destroy(text)
		end

		self._cachesTexts = nil
	end

	if self._currSpeakAsides then
		for i = 1, #self._currSpeakAsides do
			local text = self._currSpeakAsides[i].text.gameObject

			self:_clearTextListeners(text)
			UnityEngine.GameObject.Destroy(text)
		end

		self._currSpeakAsides = nil
	end
end

function StoryViewSpeakAside:_recycleAllText()
	if self._currSpeakAsides then
		for i = 1, #self._currSpeakAsides do
			local text = self._currSpeakAsides[i].text

			self:_clearTextListeners(text.gameObject)
			self:_recycleASide(text)
		end

		self._currSpeakAsides = nil
	end
end

function StoryViewSpeakAside:_clearTextListeners(text)
	local fadeIn = text:GetComponent(UnityTweensType.UITweenFadeIn)
	local fadeOut = text:GetComponent(UnityTweensType.UITweenFadeOut)
	local delayTime = text:GetComponent(UnityTweensType.TweenEmpty)
	local typeWriter = text:GetComponent("TypewriterText")

	if fadeIn then
		fadeIn:RemoveListener()
	end

	if fadeOut then
		fadeOut:RemoveListener()
	end

	if delayTime then
		delayTime:RemoveListener()
	end

	if typeWriter then
		typeWriter:RemoveEventHandler()
	end
end

function StoryViewSpeakAside:_showSpeakAside(index)
	local config = self._currSpeakAsides[index]

	self:_appearText(config.text, config.config)
end

function StoryViewSpeakAside:_createSpeakAsideConfig(config)
	local speakAside = config.config
	local text = self:_getText()

	config.text = text
	text.text = tostring(speakAside.text) == "0" and "" or speakAside.text

	local fontSize = speakAside.fontSize

	if fontSize == 0 then
		fontSize = self._text.fontSize
	end

	text.fontSize = fontSize
	text.gameObject:GetComponent("CanvasGroup").alpha = 0
end

function StoryViewSpeakAside:_dispearAll()
	if self._currSpeakAsides and #self._currSpeakAsides > 0 then
		for k, v in ipairs(self._currSpeakAsides) do
			local text = v.text

			self:_recycleASide(text)
		end

		self._currSpeakAsides = nil
	end
end

function StoryViewSpeakAside:_getCurrSpeakAsideConfig()
	if self._currSpeakAsides then
		return self._currSpeakAsides[self._currIdx]
	end
end

function StoryViewSpeakAside:_appearText(text, speakAside)
	local go = text.gameObject

	UnityTweens.UITweenFadeIn.StopTween(go)
	UnityTweens.UITweenFadeOut.StopTween(go)
	UnityTweens.TweenEmpty.StopTween(go)
	TypewriterText.Stop(go)

	if speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_FadeIn_FadeOut or speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_FadeIn_Disappear then
		local fadeIn = UnityTweens.UITweenFadeIn.StartTween(go, 1, UnityTweens.EaseType.easeInSine)

		fadeIn.time = StoryConst.FadeIn_Time

		fadeIn:AddListener(self._onTextFadeInFinish, self)

		fadeIn.tag = speakAside.story_id
	else
		UGUIToolHelper.SetColorRGBA(text, 1, 1, 1, 1)

		local typeWriter = TypewriterText.Start(go)

		typeWriter:AddEventHandler(self._onTypeWriterFinish, self)
		typeWriter:SetText(text.text)

		typeWriter.tag = speakAside.story_id
		text.gameObject:GetComponent("CanvasGroup").alpha = 1
	end
end

function StoryViewSpeakAside:_updateTextPosition()
	if self._currSpeakAsides then
		local ypos = 0
		local width = 0
		local space = 28

		for k, v in pairs(self._currSpeakAsides) do
			local pw = v.text.preferredWidth
			local ph = v.text.preferredHeight

			if width < pw then
				width = pw
			end

			Framework.TransformUtil.SetLocalPos(v.text.transform, 0, -ypos, 0)

			ypos = ypos + ph + space
		end

		ypos = ypos - space

		Framework.TransformUtil.SetLocalPos(self._textNode, 0, ypos * 0.5, 0)
	end
end

function StoryViewSpeakAside:_onTextFadeInFinish(fadeIn)
	local config = self:_getCurrSpeakAsideConfig()
	local speakAside = config.config

	if not speakAside.sa_duration then
		local sa_duration = 0

		if sa_duration == 0 then
			sa_duration = 1.5
		end

		local delayTime = UnityTweens.TweenEmpty.StartTween(config.text.gameObject, sa_duration)

		delayTime:AddListener(self._onTextDurationFinish, self)
	end
end

function StoryViewSpeakAside:_onTypeWriterFinish(typeWriter)
	self:_onTextFadeInFinish()
end

function StoryViewSpeakAside:_onTextDurationFinish(delayTime)
	if self._currIdx >= #self._currSpeakAsides then
		if not self._currStory.clickContinue then
			self:finishStory()
		else
			self._continueCanvas.alpha = 0

			self._continueFadeOut:Stop()
			self._continueFadeIn:Stop()
			self._continueFadeIn:Begin()
		end
	else
		self._currIdx = self._currIdx + 1

		self:_showSpeakAside(self._currIdx)
	end
end

function StoryViewSpeakAside:_disappearText(speakAside, text)
	text.transform:SetParent(self._textNode.parent)

	if speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_FadeIn_FadeOut or speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_TypeWriterIn_FadeOut then
		local fadeOut = UnityTweens.UITweenFadeOut.StartTween(text.gameObject, 1, UnityTweens.EaseType.easeInSine)

		fadeOut:AddListener(function(fo)
			self:_onTextFadeOutFinish(text)
		end, self)
	else
		self:_recycleASide(text)
	end
end

function StoryViewSpeakAside:_onTextFadeOutFinish(text)
	self:_recycleASide(text)
end

function StoryViewSpeakAside:_onStoryFinish()
	self.mainGO:SetActive(false)
	self:_recycleAllText()

	self._currSpeakAsides = nil
	self.currStory = nil
	self._isFadingOut = nil
end

function StoryViewSpeakAside:_getText()
	local text

	if self._cachesTexts and #self._cachesTexts then
		text = self._cachesTexts[1]

		table.remove(self._cachesTexts, 1)
	end

	if not text then
		local go = goutil.clone(self._text.gameObject)

		text = go:GetComponent("Text")
	end

	if text.transform.parent ~= self._textNode then
		text.transform:SetParent(self._textNode)
	end

	Framework.TransformUtil.SetLocalScale(text.transform, 1, 1, 1)
	text.gameObject:SetActive(true)

	return text
end

function StoryViewSpeakAside:_recycleASide(text)
	self._cachesTexts = self._cachesTexts or {}

	text.gameObject:SetActive(false)
	table.insert(self._cachesTexts, text)
end

function StoryViewSpeakAside:startFadeIn()
	self._isFadingOut = nil
	self._isFadingIn = nil
end

function StoryViewSpeakAside:startFadeOut()
	self._isFadingOut = nil
	self._isFadingIn = nil

	local config = self:_getCurrSpeakAsideConfig()

	if config then
		local speakAside = config.config

		if speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_FadeIn_FadeOut or speakAside.speak_aside_mode == StoryConst.SpeakAsideMode_TypeWriterIn_FadeOut then
			self._textFadeOut:Stop()

			self._isFadingOut = true

			self._textFadeOut:Begin()

			if self._continueCanvas.alpha > 0.5 then
				self._continueFadeOut:Stop()
				self._continueFadeIn:Stop()
				self._continueFadeOut:Begin()
			end

			return
		end
	end

	self:_onStoryFinish()
end

function StoryViewSpeakAside:beginFadeOut(handler, tgt)
	self._textFadeOut:Stop()

	self._isFadingOut = true
	self._isFadingIn = nil
	handler = handler or self._onStoryFinish
	tgt = tgt or self

	self._textFadeOut:AddListener(handler, tgt)
	self._textFadeOut:Begin()

	if self._continueCanvas.alpha > 0.5 then
		self._continueFadeOut:Stop()
		self._continueFadeIn:Stop()
		self._continueFadeOut:Begin()
	end
end

function StoryViewSpeakAside:onSceneLoadedStart()
	if not SceneMgr.instance:isTransitionFade() then
		if self._textFadeOut.enabled then
			self._textFadeOut:Stop()

			self._textGroup.alpha = 0
		end

		self._continueCanvas.alpha = 0

		self._continueFadeOut:Stop()
		self._continueFadeIn:Stop()
	end
end

function StoryViewSpeakAside:_onClickMask()
	if self._isClickContinue or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._view:isLoadingRes() then
		return
	end

	if not self._closable then
		return
	end

	self._isClickContinue = true

	if self:isUIInteractiveTargetStory() then
		return
	end

	self:finishStory()
end

function StoryViewSpeakAside:_onTweenContinueFinish()
	self._closable = true
end

function StoryViewSpeakAside:_onClickSpace()
	self:_onClickMask()
end

return StoryViewSpeakAside
