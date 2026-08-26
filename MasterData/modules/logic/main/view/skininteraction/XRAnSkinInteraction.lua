-- chunkname: @modules/logic/main/view/skininteraction/XRAnSkinInteraction.lua

module("modules.logic.main.view.skininteraction.XRAnSkinInteraction", package.seeall)

local XRAnSkinInteraction = class("XRAnSkinInteraction", CommonSkinInteraction)
local featherHideTime = 8
local interactionStoryId = CharacterVoiceEnum.XRAnStoryId
local FeatherSoundId = {
	startId = 1314663,
	endId = 1314670,
	clickId = 1314664
}

function XRAnSkinInteraction:_onInit()
	XRAnSkinInteraction.super._onInit(self)

	if not self._effectLoader then
		self._animationControllerName = "314602_xran"
		self._effectUrl = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
		self._featherUrl = "ui/viewres/story/v3a7/stroy_meileier_feather.prefab"
		self._blurPrefabUrl = "effects/prefabs/story/v3a7_mle_localblur.prefab"
		self._blurAnimUrl = "ui/animations/dynamic/v3a7_mle_spinterface_blur.controller"
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectUrl)
		self._effectLoader:addPath(self._featherUrl)
		self._effectLoader:addPath(self._blurPrefabUrl)
		self._effectLoader:addPath(self._blurAnimUrl)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end

	MainController.instance:registerCallback(MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onStep, self)
	StoryController.instance:registerCallback(StoryEvent.FrontItemFadeOut, self._onFrontItemFadeOut, self)
end

function XRAnSkinInteraction:_onStopVoice()
	XRAnSkinInteraction.super._onStopVoice(self)

	if self._clickFeatherGo then
		TaskDispatcher.cancelTask(self._hideFeather, self)
		gohelper.setActive(self._clickFeatherGo, false)
	end
end

function XRAnSkinInteraction:_onStep(params)
	if params.storyId == interactionStoryId and params.stepId == 12 then
		return
	end
end

function XRAnSkinInteraction:_onFrontItemFadeOut()
	if StoryModel.instance:getCurStoryId() == interactionStoryId then
		MainController.instance:dispatchEvent(MainEvent.OnPlayViewAnim, "mainview_in")
		MainController.instance:dispatchEvent(MainEvent.SetHeroInScene, true)
		self:_showCloseAnim()
	end
end

function XRAnSkinInteraction:_onOpenView(viewName)
	if viewName == ViewName.StoryView and StoryModel.instance:getCurStoryId() == interactionStoryId then
		self:_setKeyword()
	end
end

function XRAnSkinInteraction:_onOpenFullViewFinish(viewName)
	if viewName == ViewName.StoryBackgroundView and StoryModel.instance:getCurStoryId() == interactionStoryId then
		self:_setKeyword()
	end
end

function XRAnSkinInteraction:_setKeyword()
	UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = true
end

function XRAnSkinInteraction:_loadEffectFinished(effectLoader)
	return
end

function XRAnSkinInteraction:_onHeroShowInScene(showInScene)
	if showInScene or self._showFeatherStoryGo then
		return
	end

	if self._effectLoader.isLoading then
		logNormal("XRAnSkinInteraction effectLoader is loading")

		return
	end

	if not self._featherGo then
		local path = self._featherUrl
		local assetItem = self._effectLoader:getAssetItem(path)
		local prefab = assetItem and assetItem:GetResource(path)

		if not prefab then
			logError("XRAnSkinInteraction feather prefab is nil")

			return
		end

		self._featherGo = gohelper.clone(prefab, self._view.viewGO)
		self._featherStoryGo = gohelper.findChild(self._featherGo, "#feather_stroy")
		self._clickFeatherGo = gohelper.findChild(self._featherGo, "click")

		local clickGo = gohelper.findChild(self._featherGo, "click/#click")

		self._clickMaskableGraphic = clickGo:GetComponent(typeof(UnityEngine.UI.MaskableGraphic))
		self._click = SLFramework.UGUI.UIClickListener.Get(clickGo)

		self._click:AddClickListener(self._onFeatherClick, self)

		self._featherAnimator = ZProj.ProjAnimatorPlayer.Get(self._featherGo)
	end

	self._clickMaskableGraphic.raycastTarget = true

	self._featherAnimator:Play("open")
	gohelper.setActive(self._featherGo, true)
	gohelper.setActive(self._clickFeatherGo, true)
	TaskDispatcher.cancelTask(self._hideFeather, self)
	TaskDispatcher.runDelay(self._hideFeather, self, featherHideTime)
	AudioMgr.instance:trigger(FeatherSoundId.startId)
end

function XRAnSkinInteraction:_hideFeather()
	TaskDispatcher.cancelTask(self._hideFeather, self)

	self._clickMaskableGraphic.raycastTarget = false

	self._featherAnimator:Play("click", self._onHideClick, self)
end

function XRAnSkinInteraction:_onHideClick()
	gohelper.setActive(self._clickFeatherGo, false)
end

function XRAnSkinInteraction:_onFeatherClick()
	TaskDispatcher.cancelTask(self._hideFeather, self)

	self._clickMaskableGraphic.raycastTarget = false

	self._featherAnimator:Play("click")
	self:_playCameraAnim("314602_xran_jh")
	StoryController.instance:playStory(interactionStoryId, nil, self._storyFinish, self)
	self:_addBlurPrefab()
	self:_addBlurAnim()
	CharacterVoiceController.instance:dispatchEvent(CharacterVoiceEvent.XRAnInteractionStart)
	AudioMgr.instance:trigger(FeatherSoundId.clickId)
end

function XRAnSkinInteraction:_addBlurPrefab()
	if self._blurPrefabGo then
		return
	end

	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")
	local assetItem = self._effectLoader:getAssetItem(self._blurPrefabUrl)
	local prefab = assetItem and assetItem:GetResource(self._blurPrefabUrl)

	if not prefab then
		logError("XRAnSkinInteraction _addBlurPrefab can not find blur prefab")

		return
	end

	self._blurPrefabGo = gohelper.clone(prefab, go)
end

function XRAnSkinInteraction:_addBlurAnim()
	if self._blurAnim then
		return
	end

	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP/CaptureView")

	self._blurAnim = gohelper.onceAddComponent(go, typeof(UnityEngine.Animator))

	local assetItem = self._effectLoader:getAssetItem(self._blurAnimUrl)
	local controller = assetItem and assetItem:GetResource(self._blurAnimUrl)

	if not controller then
		logError("XRAnSkinInteraction _addBlurAnim can not find blur anim")

		return
	end

	self._blurAnim.runtimeAnimatorController = controller

	self._blurAnim:Play("state1", 0, 0)
end

function XRAnSkinInteraction:_playCameraAnim(animName)
	if not self._effectLoader then
		return
	end

	local path = self._effectUrl
	local assetItem = self._effectLoader:getAssetItem(path)
	local animatorInst = assetItem and assetItem:GetResource(path)

	if animatorInst then
		local animator = CameraMgr.instance:getCameraRootAnimator()

		animator.runtimeAnimatorController = animatorInst
		animator.enabled = true

		animator:Play(animName, 0, 0)
	else
		logError("XRAnSkinInteraction:_playCameraAnim animatorInst is nil", path)
	end

	UIBlockMgrExtend.setNeedCircleMv(false)

	local time = 6.4

	UIBlockHelper.instance:startBlock("XRAnSkinInteractionCameraAnim", time)
	TaskDispatcher.cancelTask(self._delayResetCamera, self)
	TaskDispatcher.runDelay(self._delayResetCamera, self, time)
	TaskDispatcher.cancelTask(self._clearBlur, self)
	TaskDispatcher.runDelay(self._clearBlur, self, 6)
end

function XRAnSkinInteraction:_clearBlur()
	if self._blurPrefabGo then
		gohelper.destroy(self._blurPrefabGo)

		self._blurPrefabGo = nil
	end

	if self._blurAnim then
		gohelper.destroy(self._blurAnim)

		self._blurAnim = nil
	end
end

function XRAnSkinInteraction:_delayResetCamera()
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:_resetCameraPos()
	gohelper.setActive(self._clickFeatherGo, false)
end

function XRAnSkinInteraction:_storyFinish()
	return
end

function XRAnSkinInteraction:_showCloseAnim()
	self:_clearBlur()

	self._showFeatherStoryGo = true

	gohelper.setActive(self._featherStoryGo, false)
	gohelper.setActive(self._featherStoryGo, true)
	TaskDispatcher.cancelTask(self._delayHideFeatherStoryGo, self)
	TaskDispatcher.runDelay(self._delayHideFeatherStoryGo, self, 5)
	gohelper.setActive(self._clickFeatherGo, false)
	self._featherAnimator:Play("close")
	AudioMgr.instance:trigger(FeatherSoundId.endId)
end

function XRAnSkinInteraction:_delayHideFeatherStoryGo()
	self._showFeatherStoryGo = false

	gohelper.setActive(self._featherStoryGo, false)
	gohelper.setActive(self._featherGo, false)
end

function XRAnSkinInteraction:_resetCameraPos()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	animator.runtimeAnimatorController = nil
	self._mainRootGo = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setLocalRotation(self._mainRootGo.transform, 0, 0, 0)

	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

function XRAnSkinInteraction:_onDestroy()
	XRAnSkinInteraction.super._onDestroy(self)
	TaskDispatcher.cancelTask(self._delayResetCamera, self)
	TaskDispatcher.cancelTask(self._hideFeather, self)
	TaskDispatcher.cancelTask(self._delayHideFeatherStoryGo, self)
	TaskDispatcher.cancelTask(self._clearBlur, self)

	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	if self._featherGo then
		gohelper.destroy(self._featherGo)

		self._featherGo = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	self:_clearBlur()
	MainController.instance:unregisterCallback(MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, self._onStep, self)
	StoryController.instance:unregisterCallback(StoryEvent.FrontItemFadeOut, self._onFrontItemFadeOut, self)
	self:_resetCameraPos()
end

return XRAnSkinInteraction
