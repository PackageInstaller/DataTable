-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewPureImage.lua

module("logic.extensions.story.view.story.StoryViewPureImage", package.seeall)

local StoryViewPureImage = class("StoryViewPureImage", StoryViewComponent)

function StoryViewPureImage:_buildUI()
	StoryViewPureImage.super._buildUI(self)

	self._text = goutil.findChildTextComponent(self.mainGO, "Text")
	self._background = goutil.findChild(self.mainGO, "Bg"):GetComponent("RawImage")
	self._image = goutil.findChild(self.mainGO, "Icon"):GetComponent("RawImage")
	self._imgName = goutil.findChild(self.mainGO, "imgName")
	self._clicker = Framework.UIClickTrigger.Get(goutil.findChild(self.mainGO, "Continue"))

	self.mainGO:SetActive(false)
end

function StoryViewPureImage:onEnter()
	StoryViewPureImage.super.onEnter(self)
	self.mainGO:SetActive(false)

	self._canvasGroup.alpha = 0
	self._loadResCount = 0

	self._clicker:AddClickListener(self._onShowingImageWaitingTime, self)
end

function StoryViewPureImage:onExit()
	StoryViewPureImage.super.onExit(self)

	if self._bgEffect then
		goutil.destroy(self._bgEffect)

		self._bgEffect = nil
	end

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	self._currStory = nil
	self._texturePath = nil
	self._loadResCount = 0
	self._bgEffectPath = nil

	self._clicker:RemoveClickListener()
end

function StoryViewPureImage:prepareStory(currStory, finishCallback, finishCallbackTarget)
	self._prepareCallback = finishCallback
	self._prepareCallbackTarget = finishCallbackTarget
	self._canvasGroup.alpha = 0
	self._currStory = currStory
	self._bgEffectPath = "effect/prefabs/story/story_ui/fx_story_ui_iconbg.prefab"

	if tostring(currStory.text) ~= "0" then
		self._text.text = currStory.text

		self._imgName:SetActive(true)
	else
		self._imgName:SetActive(false)

		self._text.text = ""
	end

	self._resLoader = self._resLoader or MultiResLoader.New()
	self._loadResCount = 3
	self._texturePath = StoryConst.StoryPath_IconImgBg .. self._currStory.animName

	if not string.find(self._texturePath, ".png") then
		self._texturePath = self._texturePath .. ".png"
	end

	self._backgroundPath = StoryConst.StoryPath_Assets .. "dh_xiangkuang.png"

	self._resLoader:addResPath(self._texturePath)
	self._resLoader:addResPath(self._backgroundPath)
	self._resLoader:addResPath(self._bgEffectPath)

	self._resLoader.loadedCount = 0

	self._resLoader:load(self._onImageResourceLoaded, nil, self)
end

function StoryViewPureImage:startStory(currStory)
	self.mainGO:SetActive(true)
	self._tweenOut:Stop()
end

function StoryViewPureImage:endStory()
	self._texturePath = nil
	self._currStory = nil
	self._backgroundPath = nil
	self._bgEffectPath = nil

	if self._bgEffect then
		goutil.destroy(self._bgEffect)

		self._bgEffect = nil
	end

	self._tweenOut:Stop()
	self._tweenOut:Begin()
end

function StoryViewPureImage:_onImageResourceLoaded(loader)
	local texture, bgText, bgEffect
	local res = self._resLoader:getResource(self._texturePath)
	local resBg = self._resLoader:getResource(self._backgroundPath)
	local resEff = self._resLoader:getResource(self._bgEffectPath)

	if res then
		texture = res:GetMainAsset()
	end

	if resBg then
		bgText = resBg:GetMainAsset()
	end

	if resEff then
		bgEffect = resEff:GetMainAsset()
	end

	self._loadResCount = 0
	self._image.texture = texture
	self._background.texture = bgText

	self._image:SetNativeSize()

	if bgEffect then
		self._bgEffect = goutil.cloneAndSetParent(bgEffect, self._image.transform)

		Framework.TransformUtil.SetLocalPos(self._bgEffect.transform, 0, 0, 299)
		Framework.TransformUtil.SetLocalScale(self._bgEffect.transform, 1, 1, 1)
		Framework.GameObjectUtil.SetLayerRecursively(self._bgEffect, SceneLayer.UI_Value)
		GoUtil.SetSortingOrder(self._bgEffect, 19999)
	end

	if self._loadResCount == 0 and self._prepareCallback then
		if self._prepareCallbackTarget then
			self._prepareCallback(self._prepareCallbackTarget, self)
		else
			self:_prepareCallback()
		end
	end
end

function StoryViewPureImage:isLoading()
	return self._loadResCount > 0
end

function StoryViewPureImage:_onTweenInFinish()
	self._isFadingIn = nil
end

function StoryViewPureImage:_onShowingImageWaitingTime()
	if self._isOpeningNpcIntrod then
		return
	end

	if self._isTransitionScene or self._isFadingIn or self._isFadingOut then
		return
	end

	if self._isPause or self._isFinished then
		return
	end

	if self._view:isLoadingRes() then
		return
	end

	self:finishStory()
end

function StoryViewPureImage:_onClickSpace()
	self:finishStory()
end

return StoryViewPureImage
