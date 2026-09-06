-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewChapter.lua

module("logic.extensions.story.view.story.StoryViewChapter", package.seeall)

local StoryViewChapter = class("StoryViewChapter", StoryViewComponent)

function StoryViewChapter:_buildUI()
	StoryViewChapter.super._buildUI(self)
	self:_initNodeChapter()
	self:_initNodeChapterName()
	self:_initNodeTips()

	self._clickMask = goutil.findChild(self.mainGO, "ClickMask")

	Framework.UIClickTrigger.Get(self._clickMask):AddClickListener(self._onClickMask, self, nil)
	self.mainGO:SetActive(false)
end

function StoryViewChapter:_initNodeChapter()
	self._nodeChapter = goutil.findChild(self.mainGO, "Node1")
	self._chapter = goutil.findChildComponent(self.mainGO, "Node1/Chapter", "UIImageSpriteChange")
	self._chapterPreFix = goutil.findChildComponent(self.mainGO, "Node1/ChapterPre", "UIImgNumeralText")
end

function StoryViewChapter:_initNodeChapterName()
	self._nodeChapterName = goutil.findChild(self.mainGO, "Node2")
	self._textChapterName = goutil.findChildTextComponent(self.mainGO, "Node2/Title")
	self._textChapterDesc = goutil.findChildTextComponent(self.mainGO, "Node2/Desc")
	self._nodeChapterNameCanvas = self._nodeChapterName:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function StoryViewChapter:_initNodeTips()
	self._textTips = goutil.findChildTextComponent(self.mainGO, "Node3")
	self._nodeContinue = goutil.findChildImageComponent(self.mainGO, "Node4")
end

function StoryViewChapter:startFadeIn()
	if self._tweenOut then
		self._tweenOut:Stop()
	end

	self._isFadingIn = nil
	self._isFadingOut = nil

	self.mainGO:SetActive(true)

	if self._canvasGroup then
		self._canvasGroup.alpha = 1
	end
end

function StoryViewChapter:onEnter()
	StoryViewChapter.super.onEnter(self)
	self.mainGO:SetActive(false)
end

function StoryViewChapter:onExit()
	self._closable = nil

	StoryViewChapter.super.onExit(self)

	self._isClickContinue = nil
	self._currStory = nil
end

function StoryViewChapter:startStory(currStory)
	self._closable = nil
	self._isClickContinue = nil
	self._currStory = currStory

	printInfo(self._currStory.text)

	local texts = string.split(self._currStory.text, "#")
	local chapterId = checknumber(texts[1])
	local chapter_0 = chapterId % 10
	local chapter_1 = math.floor(chapterId / 10)

	self._chapter:SetState(chapter_0)

	if chapter_1 > 0 then
		self._chapterPreFix.gameObject:SetActive(true)
		self._chapterPreFix:SetNum(chapter_1)
	else
		self._chapterPreFix.gameObject:SetActive(false)
	end

	self._textChapterName.text = texts[2]
	self._textChapterDesc.text = texts[3] or ""
	self._textTips.text = texts[4] and #texts[4] > 0 and texts[4] or currStory.type == StoryConst.Story_ChapterStart and "" or lang("chapter_end")
	self._canvasGroup.alpha = 1
	self._nodeChapterNameCanvas.alpha = 0

	self._nodeChapterName:SetActive(false)
	self._textTips.gameObject:SetActive(false)
	self._nodeContinue.gameObject:SetActive(false)
	self:_tweenChapterIn()
end

function StoryViewChapter:_tweenChapterIn()
	Framework.TransformUtil.SetLocalPos(self._nodeChapter.transform, -500, 0, 0)

	local chapterTween = UnityTweens.TweenPosition.StartTween(self._nodeChapter, Vector3.New(-500, 0, 0), Vector3.New(0, 0, 0), 0.3)

	chapterTween:AddListener(function()
		self:_tweenChapterNameIn()
	end, nil)
end

function StoryViewChapter:_tweenChapterNameIn()
	self._nodeChapterNameCanvas.alpha = 0

	local chaterNameTween = UnityTweens.UITweenFadeIn.StartTween(self._nodeChapterName, 0.8, UnityTweens.EaseType.easeInSine)

	chaterNameTween:AddListener(function()
		local text = self._textTips.text

		if text and #text > 0 then
			self:_tweenTipsIn()
		else
			self:_tweenContinueIn()
		end
	end, nil)
	self._nodeChapterName:SetActive(true)
end

function StoryViewChapter:_tweenTipsIn()
	UGUIToolHelper.SetGraphicAlpha(self._textTips, 0)

	local tipsTween = UnityTweens.UITweenFadeIn.StartTween(self._textTips.gameObject, 0.5, UnityTweens.EaseType.easeOutSine)

	tipsTween:AddListener(function()
		self:_tweenContinueIn()
	end, nil)
	self._textTips.gameObject:SetActive(true)
end

function StoryViewChapter:_tweenContinueIn()
	UGUIToolHelper.SetGraphicAlpha(self._nodeContinue, 0)

	local continueTween = UnityTweens.UITweenFadeIn.StartTween(self._nodeContinue.gameObject, 0.5, UnityTweens.EaseType.easeOutSine)

	continueTween:AddListener(function()
		self._closable = true
	end, nil)
	self._nodeContinue.gameObject:SetActive(true)
end

function StoryViewChapter:_onClickMask()
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

	self:finishStory()
end

return StoryViewChapter
