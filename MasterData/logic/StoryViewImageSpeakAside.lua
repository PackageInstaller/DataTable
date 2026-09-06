-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewImageSpeakAside.lua

module("logic.extensions.story.view.story.StoryViewImageSpeakAside", package.seeall)

local StoryViewImageSpeakAside = class("StoryViewImageSpeakAside", StoryViewComponent)

function StoryViewImageSpeakAside:_buildUI()
	StoryViewImageSpeakAside.super._buildUI(self)

	self._image = goutil.findChild(self.mainGO, "RawImage"):GetComponent("RawImage")

	self.mainGO:SetActive(false)
end

function StoryViewImageSpeakAside:onEnter()
	StoryViewImageSpeakAside.super.onEnter(self)
	self.mainGO:SetActive(false)

	self._canvasGroup.alpha = 0
	self._loadResCount = 0
end

function StoryViewImageSpeakAside:onExit()
	StoryViewImageSpeakAside.super.onExit(self)

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	self._currStory = nil
	self._texturePath = nil
	self._loadResCount = 0
end

function StoryViewImageSpeakAside:startStory(currStory)
	self.mainGO:SetActive(true)
	removetimer(self._onShowingImageWaitingTime, self)
	self._tweenOut:Stop()

	self._currStory = currStory

	if self._currStory.animName and #self._currStory.animName > 0 then
		self:_showImage(self._currStory.animName)
	else
		self:_onImageResourceLoaded()
	end
end

function StoryViewImageSpeakAside:endStory()
	self._texturePath = nil
	self._currStory = nil

	removetimer(self._onShowingImageWaitingTime, self)
	self._tweenOut:Stop()
	self._tweenOut:Begin()
end

function StoryViewImageSpeakAside:_showImage(texturePath)
	self._resLoader = self._resLoader or MultiResLoader.New()
	self._canvasGroup.alpha = 0
	self._loadResCount = self._loadResCount + 1
	self._texturePath = StoryConst.StoryPath_BigImgBg .. texturePath

	self._resLoader:addResPath(self._texturePath)

	self._resLoader.loadedCount = 0

	self._resLoader:load(self._onImageResourceLoaded, nil, self)
end

function StoryViewImageSpeakAside:_onImageResourceLoaded(loader)
	local texture, bgText
	local res = self._resLoader:getResource(self._texturePath)

	if res then
		texture = res:GetMainAsset()
	end

	self._loadResCount = self._loadResCount - 1
	self._image.texture = texture

	self._image:SetNativeSize()

	if self._loadResCount == 0 and self._loadedCallback then
		if self._loadedCallbackTarget then
			self._loadedCallback(self._loadedCallbackTarget, self)
		else
			self:_loadedCallback()
		end
	end
end

function StoryViewImageSpeakAside:isLoading()
	return self._loadResCount > 0
end

function StoryViewImageSpeakAside:_onTweenInFinish()
	settimer(1.5, self._onShowingImageWaitingTime, self)
end

function StoryViewImageSpeakAside:_onShowingImageWaitingTime()
	removetimer(self._onShowingImageWaitingTime, self)
	self:finishStory()
end

return StoryViewImageSpeakAside
