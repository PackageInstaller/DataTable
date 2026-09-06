-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryViewBase.lua

module("logic.extensions.story.view.StoryViewBase", package.seeall)

local StoryViewBase = class("StoryViewBase", ViewComponent)

function StoryViewBase:ctor()
	StoryViewBase.super:ctor()
end

function StoryViewBase:buildUI()
	self._uiRoot = self.mainGO
	self._uiCanvas = self._uiRoot:GetComponent("Canvas")
	self._uiCamera = self:getGo("UICamera"):GetComponent("Camera")
	self._storyBackground = StoryBackgroundCtrl.New(self:getResInstance(CommonResPath.UIStoryBkg))
	self._uiCanvas.sortingOrder = 1001
	self._uiCanvas.worldCamera = self._uiCamera

	self:_initStories()

	self._uiFadeTime = 0.5

	self:_initStoryScreenEffects()
end

function StoryViewBase:_initStories()
	local story = self:getGo("story")
	local option = self:getGo("option")
	local speakaside = self:getGo("speakaside")
	local imgspeakaside = self:getGo("imgspeakaside")
	local pureimage = self:getGo("pureimage")
	local chapter_start = self:getGo("chapter_start")
	local chapter_end = self:getGo("chapter_end")
	local video = self:getGo("video")
	local animation = self:getGo("animation")
	local battle = self:getGo("battle")

	self._storysTable = {}
	self._storysTable[StoryConst.Story_Drama] = StoryViewDrama.New(self, story, self._uiCamera)

	if option then
		self._storysTable[StoryConst.Story_Option] = StoryViewOption.New(self, option)
	end

	if pureimage then
		self._storysTable[StoryConst.Story_Image] = StoryViewPureImage.New(self, pureimage)
	end

	if speakaside then
		self._storysTable[StoryConst.Story_SpeakAside] = StoryViewSpeakAside.New(self, speakaside)
	end

	if imgspeakaside then
		self._storysTable[StoryConst.Story_ImageSpeakAside] = StoryViewImageSpeakAside.New(self, imgspeakaside)
	end

	if chapter_start then
		self._storysTable[StoryConst.Story_ChapterStart] = StoryViewChapter.New(self, chapter_start)
	end

	if chapter_end then
		self._storysTable[StoryConst.Story_ChapterEnd] = StoryViewChapter.New(self, chapter_end)
	end

	if video then
		self._storysTable[StoryConst.Story_Movie] = StoryViewVideo.New(self, video)
	end

	if animation then
		self._storysTable[StoryConst.Story_Animation] = StoryViewAnimation.New(self, animation)
	end

	if battle then
		self._storysTable[StoryConst.Story_Battle] = StoryViewBattle.New(self, battle)
	end
end

function StoryViewBase:_initStoryScreenEffects()
	local screeneffects = self:getGo("screeneffects")
	local redScreen = self:getGo("screeneffects/RedScreen")
	local effNode = self:getGo("screeneffects/Eff")

	self._screenEffects = {}
	self._screenEffects[StoryConst.Story_Effect_Red] = StoryScreenEffectRed.New(self, redScreen, self._uiCamera)
	self._screenEffects[StoryConst.Story_Effect_Effect] = StoryScreenEffectEffect.New(self, effNode, self._uiCamera)

	if screeneffects then
		screeneffects:SetActive(true)
	end
end

function StoryViewBase:onEnter()
	self._hasHideUI = nil
	self._hasFinished = nil
	self._currStoryType = nil
	self._currScreenEffType = nil
	self._preStoryType = nil
	self._isJumpDragmas = nil
	StoryViewModel.currSortingOrder = 0

	self:_forceSetMainPlayerIdle()

	self._saveTimeScale = UnityEngine.Time.timeScale
	UnityEngine.Time.timeScale = 1

	FloatWordMgr.instance:setParent(self.mainGO)
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", self.mainGO)
	ViewMgr.instance:setIngorePriority("popupwindow", true)
	WaitingView.instance:setParent(self.mainGO)

	self._viewPresentor.fadingOut = nil

	self._storyBackground:onEnter()

	UIEffectManager.screenEffectLayer = SceneLayer.UI1_Value

	for k, v in pairs(self._storysTable) do
		v:onEnter()
	end

	for k, v in pairs(self._screenEffects) do
		v:onEnter()
	end

	StoryBgmMgr.instance:startStory(self)
	self:showNextStory()
end

function StoryViewBase:_forceSetMainPlayerIdle()
	if SceneMainPlayer.instance then
		SceneMainPlayer.instance:forceMainPlayerIdle()
	end
end

function StoryViewBase:onExit()
	StoryBgmMgr.instance:stopStory(self)

	self._viewPresentor.fadingOut = nil
	UnityEngine.Time.timeScale = self._saveTimeScale

	FloatWordMgr.instance:resetParent()
	WaitingView.instance:setParent()
	ViewMgr.instance:setIngorePriority("popupwindow", nil)
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", nil)
	self._storyBackground:onExit()

	if not StoryModel.instance.isPlayingAnimStory then
		SceneFacade.instance:showSceneObjects(true)
		GlobalModel.instance:visibleMainCamera(true)
	end

	UIEffectManager.screenEffectLayer = nil

	for k, v in pairs(self._storysTable) do
		v:onExit()
	end

	for k, v in pairs(self._screenEffects) do
		v:onExit()
	end

	self._hasHideUI = nil
	self._hasFinished = nil
	self._currStoryType = nil
	self._currScreenEffType = nil
	self._preStoryType = nil
	self._isJumpDragmas = nil
end

function StoryViewBase:showNextStory()
	self._isJumpDragmas = nil

	if self:_hasNextStory() then
		local story = self:_getNextStory()

		self:showStory(story)

		return true
	end
end

function StoryViewBase:showStory(story)
	self._currStory = story

	local currStoryType = self:_getCurrStoryType()

	if self._currStoryType and currStoryType ~= self._currStoryType then
		self._storysTable[self._currStoryType]:endStory()
	end

	self._preStoryType = self._currStoryType
	self._currStoryType = currStoryType

	StoryBgmMgr.instance:playStoryBgm(story)
	self:_prepareStoryResources()
end

function StoryViewBase:jumpDramaStories(currStory, popStories)
	self._isJumpDragmas = nil

	local isJumpDragmas

	if popStories then
		local nextStory = currStory:getNextStoryOnly()

		if nextStory and (nextStory.type == StoryConst.Story_Option or nextStory.type == StoryConst.Story_Image) then
			for i = #popStories, 1, -1 do
				if popStories[i].type == StoryConst.Story_Drama then
					currStory:setCurrStory(popStories[i])

					self._isJumpDragmas = true
					isJumpDragmas = true

					self:showStory(popStories[i])

					break
				end
			end
		end

		for i = 1, #popStories do
			local story = popStories[i]

			if story and story.op ~= 0 then
				self._storysTable[self._currStoryType]:finishStory(story.op, story.opParams)

				return
			end
		end
	end

	if not isJumpDragmas then
		self._storysTable[self._currStoryType]:finishStory()
	end
end

function StoryViewBase:jumpStories(currStory)
	local popStories

	if currStory then
		popStories = currStory:popStories()
	end

	self._isJumpDragmas = nil

	local isJumpDragmas

	if popStories then
		local nextStory = currStory:getNextStoryOnly()

		if nextStory and nextStory.type == StoryConst.Story_Option then
			for i = #popStories, 1, -1 do
				if popStories[i].type == StoryConst.Story_Drama then
					currStory:setCurrStory(popStories[i])

					self._isJumpDragmas = true
					isJumpDragmas = true

					self:showStory(popStories[i])

					break
				end
			end
		end

		for i = 1, #popStories do
			local story = popStories[i]

			self:_tryFinishInteractiveTargetStory(story)

			if story and story.op ~= 0 then
				self._storysTable[self._currStoryType]:finishStory(story.op, story.opParams)

				return
			end
		end
	end

	if not isJumpDragmas then
		self._storysTable[self._currStoryType]:finishStory()
	end

	if not self:_hasNextStory() then
		AudioVoicePlayer.instance:setAutoResumeBgm(true)
	end
end

function StoryViewBase:_tryFinishInteractiveTargetStory(story)
	if TaskController.instance:isUIInteractiveTargetStory(story.id, story.storyIndex) then
		TaskController.instance:onUIInteractiveFinish()
	end
end

function StoryViewBase:_getCurrStoryType()
	local currStoryType

	return self._currStory.type and #self._currStory.type > 0 and self._currStory.type or StoryConst.Story_Drama
end

function StoryViewBase:_prepareStoryResources()
	self._storyResReady = nil
	self._storyBgResReady = nil

	local currStoryType = self:_getCurrStoryType()

	self._storysTable[currStoryType]:prepareStory(self._currStory, self._onStoryResourcesReady, self)
	self._storyBackground:prepareBackgroundResources(self._currStory, self._onStoryBackgroundResourcesReady, self)
end

function StoryViewBase:_onStoryResourcesReady()
	self._storyResReady = true

	self:_onAllStoryResourcesReady()
end

function StoryViewBase:_onStoryBackgroundResourcesReady()
	self._storyBgResReady = true

	self:_onAllStoryResourcesReady()
end

function StoryViewBase:_onAllStoryResourcesReady()
	if self._currStoryType and self._storyResReady and self._storyBgResReady then
		if not self._hasHideUI then
			GlobalModel.instance:showUI(false, GlobalModel.UIFadeTime)

			self._hasHideUI = true
		end

		self:_showStory()

		if TaskController.instance.isFirstTaskDoing then
			SceneMgr.instance:hideLoading()

			TaskController.instance.isFirstTaskDoing = nil
		end

		if self._isJumpDragmas then
			self._isJumpDragmas = nil

			self._storysTable[self._currStoryType]:finishStory()
		end
	end
end

function StoryViewBase:finishCurrStory(op, opParams)
	if not self:showNextStory() then
		self:_finishStory()
	end
end

function StoryViewBase:_showStory()
	self._storyBackground:showBackground()
	self._storysTable[self._currStoryType]:startStory(self._currStory)
	self:_playScreenEffect()

	if self._preStoryType ~= self._currStoryType then
		self._storysTable[self._currStoryType]:startFadeIn()

		if self._preStoryType then
			if self._preStoryType == StoryConst.Story_Drama and (self._currStoryType == StoryConst.Story_Option or self._currStoryType == StoryConst.Story_Image) then
				self._storysTable[StoryConst.Story_Drama]:hideJumpAndContinue(true)

				return
			elseif (self._preStoryType == StoryConst.Story_Option or self._preStoryType == StoryConst.Story_Image) and self._currStoryType ~= StoryConst.Story_Drama then
				self._storysTable[StoryConst.Story_Drama]:startFadeOut()
			end

			self._storysTable[self._preStoryType]:startFadeOut()
		end
	end
end

function StoryViewBase:_playScreenEffect()
	if self._currStory.screenEff == StoryConst.Story_Effect_None then
		self:_stopScreenEffect()

		return
	end

	if self._currStory.screenEff and #self._currStory.screenEff > 0 and self._currStory.screenEff ~= self._currScreenEffType then
		self:_stopScreenEffect()

		self._currScreenEffType = self._currStory.screenEff

		if self._currScreenEffType and self._screenEffects[self._currScreenEffType] then
			self._screenEffects[self._currScreenEffType]:playEffect(self._currStory.screenEffPath)
		end
	end
end

function StoryViewBase:_stopScreenEffect()
	if self._currScreenEffType and self._screenEffects[self._currScreenEffType] then
		self._screenEffects[self._currScreenEffType]:stopEffect()

		self._currScreenEffType = nil
	end
end

function StoryViewBase:isLoadingRes()
	if self._storyBackground:isLoadingRes() then
		return true
	end

	for k, v in pairs(self._storysTable) do
		if v:isLoadingRes() then
			return true
		end
	end

	for k, v in pairs(self._screenEffects) do
		if v:isLoadingRes() then
			return true
		end
	end
end

function StoryViewBase:_onTweenInFinish()
	return
end

function StoryViewBase:_finishStory()
	if self._hasFinished then
		return
	end

	self._hasFinished = true

	if not self._storyBackground:isEmpty() then
		self:_beginFadeOut()
		self._storyBackground:closeBackground(self._onTweenOutFinish, self)
	else
		self._beginFadeOut(self, self._onTweenOutFinish, self)
	end
end

function StoryViewBase:_beginFadeOut(handler, tgt)
	GlobalModel.instance:showUI(true, GlobalModel.UIFadeTime)

	if not StoryModel.instance.isPlayingAnimStory then
		SceneFacade.instance:showSceneObjects(true)
		GlobalModel.instance:visibleMainCamera(true)
	end

	self._viewPresentor.fadingOut = true

	self:_stopScreenEffect()

	if self._currStoryType then
		self._storysTable[self._currStoryType]:beginFadeOut(handler, tgt)
	end

	for k, v in pairs(self._storysTable) do
		if k ~= self._currStoryType and v.mainGO.activeSelf then
			v:beginFadeOut()
		end
	end
end

function StoryViewBase:_onTweenOutFinish()
	self:_endStory()
end

return StoryViewBase
