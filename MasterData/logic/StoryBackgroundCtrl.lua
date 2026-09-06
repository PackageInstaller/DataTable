-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/background/StoryBackgroundCtrl.lua

module("logic.extensions.story.view.background.StoryBackgroundCtrl", package.seeall)

local StoryBackgroundCtrl = class("StoryBackgroundCtrl")

StoryBackgroundCtrl.lockBlurScreen = 0

function StoryBackgroundCtrl:ctor(mainGo, view)
	self.mainGo = mainGo
	self.view = view

	self:buildUI()
end

function StoryBackgroundCtrl:buildUI()
	local uiCameraGO = GlobalModel.instance.uiCameraGO:GetComponent("Camera")
	local uiCanvas = self.mainGo:GetComponent("Canvas")
	local effNode0 = goutil.findChild(self.mainGo, "EffNode0")
	local effNode1 = goutil.findChild(self.mainGo, "EffNode1")
	local imageNode0 = goutil.findChild(self.mainGo, "Image0")
	local imageNode1 = goutil.findChild(self.mainGo, "Image1")

	self._switchBg = goutil.findChild(self.mainGo, "SwitchBg")
	self._switchTween = self._switchBg:GetComponent(UnityTweensType.TweenPosition)

	self._switchBg:SetActive(false)

	uiCanvas.worldCamera = uiCameraGO
	uiCanvas.sortingOrder = 1000
	self._bgPlayer0 = StoryBackground.New(imageNode0, self.view, effNode0, uiCameraGO)
	self._bgPlayer1 = StoryBackground.New(imageNode1, self.view, effNode1, uiCameraGO)
end

function StoryBackgroundCtrl:onSceneLoadedStart()
	if not SceneMgr.instance:isTransitionFade() then
		StoryBackgroundCtrl.lockBlurScreen = 0

		if self._bgPlayer0 then
			self._bgPlayer0:onSceneLoadedStart()
		end

		if self._bgPlayer1 then
			self._bgPlayer1:onSceneLoadedStart()
		end
	end
end

function StoryBackgroundCtrl:onEnter()
	StoryBackgroundCtrl.lockBlurScreen = StoryBackgroundCtrl.lockBlurScreen + 1

	self.mainGo:SetActive(true)
	self._bgPlayer0:onEnter()
	self._bgPlayer1:onEnter()
	self._switchTween:AddListener(self._onTweenInFinish, self)
	HardwareQuality._updateUiMaskParent(HardwareQuality.UiMaskLayer.Story, self.mainGo)
end

function StoryBackgroundCtrl:isEmpty()
	if self._currBgPlayer then
		return self._currBgPlayer:isEmpty()
	end
end

function StoryBackgroundCtrl:getBgEffIns()
	if self._currBgPlayer then
		return self._currBgPlayer:getBgEffIns()
	end
end

function StoryBackgroundCtrl:prepareBackgroundResources(storyConfig, callback, target)
	self._loadedCallback = callback
	self._loadedCallbackTarget = target

	if storyConfig.type == StoryConst.Story_ChapterStart or storyConfig.type == StoryConst.Story_ChapterEnd then
		if not storyConfig.bgImg or #storyConfig.bgImg == 0 or storyConfig.bgImg == StoryConst.Story_BG_None then
			storyConfig.bgImg = "story_chapter_bg.png"
		end
	elseif storyConfig.type == StoryConst.Story_Movie or storyConfig.type == StoryConst.Story_Animation then
		storyConfig.bgImg = StoryConst.Story_BG_None
	end

	self._nextBgPlayer = nil

	if self._currBgPlayer and self._currBgPlayer:isEqual(storyConfig) then
		self:_onBackgroundResourceLoaded()

		return
	end

	self._nextBgPlayer = self._currBgPlayer == self._bgPlayer0 and self._bgPlayer1 or self._bgPlayer0

	self._nextBgPlayer:prepareBackgroundResources(storyConfig, self._onBackgroundResourceLoaded, self)
end

function StoryBackgroundCtrl:_onBackgroundResourceLoaded()
	if self._loadedCallback then
		if self._loadedCallbackTarget then
			self._loadedCallback(self._loadedCallbackTarget)
		else
			self._loadedCallback()
		end
	end
end

function StoryBackgroundCtrl:showBackground(callback, target)
	if not self._nextBgPlayer then
		return
	end

	self._fadeInCallback = callback
	self._fadeInCallbackTarget = target
	self._preBgPlayer = nil

	local isPreBgEmpty

	if self._currBgPlayer then
		isPreBgEmpty = self._currBgPlayer:isEmpty()

		if self._currBgPlayer ~= self._nextBgPlayer then
			self._preBgPlayer = self._currBgPlayer
		end
	end

	self._currBgPlayer = self._nextBgPlayer
	self._nextBgPlayer = nil
	self._isFirstSwitchBg = not self._preBgPlayer

	if self._preBgPlayer then
		self._preBgPlayer:stopEffect()
	end

	if self._currBgPlayer:isNeeedSwitch(self._isFirstSwitchBg) then
		self._currBgPlayer:startFadeBackGround(nil, nil, false)
		self._currBgPlayer:setCanvasAlpha(0)
		self._switchTween:Stop()
		self._switchTween:Begin()
		self._switchBg.transform:SetAsLastSibling()
		self._switchBg:SetActive(true)

		if self._isFirstSwitchBg then
			SceneFacade.instance:showSceneObjects(true)
			GlobalModel.instance:visibleMainCamera(true)
		end

		settimer(0.25, self._onSwitchBackground, self)
	else
		self._switchBg:SetActive(false)
		removetimer(self._onSwitchBackground, self)
		self._currBgPlayer:startFadeBackGround(self._onTweenInFinish, self, not isPreBgEmpty)
	end
end

function StoryBackgroundCtrl:_onSwitchBackground()
	removetimer(self._onSwitchBackground, self)

	if self._currBgPlayer then
		self._currBgPlayer:setCanvasAlpha(1)

		if self._isFirstSwitchBg then
			self._isFirstSwitchBg = nil

			if not StoryModel.instance.isPlayingAnimStory and self._currBgPlayer:isNeedHideSceneCameras() then
				SceneFacade.instance:showSceneObjects(false)
				GlobalModel.instance:visibleMainCamera(false)
			end
		end
	end
end

function StoryBackgroundCtrl:closeBackground(callback, target)
	self._fadeOutCallback = callback
	self._fadeOutCallbackTarget = target

	if self._currBgPlayer then
		self._currBgPlayer:hideBackground(self._onTweenOutFinish, self)

		self._currBgPlayer = nil
	else
		self:_onTweenOutFinish()
	end
end

function StoryBackgroundCtrl:isLoadingRes()
	if self._bgPlayer0:isLoading() then
		return true
	end

	if self._bgPlayer1:isLoading() then
		return true
	end
end

function StoryBackgroundCtrl:onExit()
	HardwareQuality._updateUiMaskParent(HardwareQuality.UiMaskLayer.UIRoot, self.mainGo)
	removetimer(self._onSwitchBackground, self)

	if StoryBackgroundCtrl.lockBlurScreen > 0 then
		StoryBackgroundCtrl.lockBlurScreen = StoryBackgroundCtrl.lockBlurScreen - 1
	end

	self._switchTween:RemoveListener()
	self._bgPlayer0:onExit()
	self._bgPlayer1:onExit()

	self._currBgPlayer = nil
	self._fadeInCallback = nil
	self._fadeInCallbackTarget = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackTarget = nil

	self.mainGo:SetActive(false)
end

function StoryBackgroundCtrl:_onTweenInFinish()
	self._switchBg:SetActive(false)

	if self._preBgPlayer then
		self._preBgPlayer:setCanvasAlpha(0)

		self._preBgPlayer = nil
	end

	if self._fadeInCallback then
		if self._fadeInCallbackTarget then
			self._fadeInCallback(self._fadeInCallbackTarget)
		else
			self._fadeInCallback()
		end
	end
end

function StoryBackgroundCtrl:_onTweenOutFinish()
	local fadeOutCallback = self._fadeOutCallback
	local callbackFDTarget = self._fadeOutCallbackTarget

	if fadeOutCallback then
		if callbackFDTarget then
			self._fadeOutCallback(callbackFDTarget)
		else
			fadeOutCallback()
		end
	end
end

return StoryBackgroundCtrl
