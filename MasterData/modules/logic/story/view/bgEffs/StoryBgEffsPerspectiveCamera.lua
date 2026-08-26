-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsPerspectiveCamera.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsPerspectiveCamera", package.seeall)

local StoryBgEffsPerspectiveCamera = class("StoryBgEffsPerspectiveCamera", StoryBgEffsBase)

function StoryBgEffsPerspectiveCamera:ctor()
	StoryBgEffsPerspectiveCamera.super.ctor(self)
end

function StoryBgEffsPerspectiveCamera:init(bgCo)
	StoryBgEffsPerspectiveCamera.super.init(self, bgCo)

	self._bgCo = bgCo
	self._camPrefPath = "effects/prefabs/story/v3a7_fakecammgr.prefab"
	self._camAnimPath = "ui/animations/dynamic/v3a7_mle_spinterface_blur_2.controller"

	table.insert(self._resList, self._camPrefPath)
	table.insert(self._resList, self._camAnimPath)

	self._effLoaded = false

	StoryController.instance:dispatchEvent(StoryEvent.OnPerspectiveDialogMat)
end

function StoryBgEffsPerspectiveCamera:start(callback, callbackObj)
	StoryBgEffsPerspectiveCamera.super.start(self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self:_setViewTop(true)
	self:loadRes()
end

function StoryBgEffsPerspectiveCamera:onLoadFinished()
	self._effLoaded = true

	StoryBgEffsPerspectiveCamera.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local prefabAssetItem = self._loader:getAssetItem(self._camPrefPath)
	local rootGo = StoryViewMgr.instance:getStoryHeroView()

	self._gocamerafake = gohelper.clone(prefabAssetItem:GetResource(), rootGo)

	gohelper.setAsFirstSibling(self._gocamerafake)

	self._spineGo = gohelper.findChild(self._gocamerafake, "spine")

	local animAssetItem = self._loader:getAssetItem(self._camAnimPath)
	local animInst = animAssetItem:GetResource()

	self._captureGo = PostProcessingMgr.instance:getCaptureView()
	self._capture = self._captureGo:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	self._capture.enabled = true
	self._captureAnim = gohelper.onceAddComponent(self._captureGo, typeof(UnityEngine.Animator))
	self._captureAnim.runtimeAnimatorController = animInst
	self._captureAnim.enabled = true

	self._captureAnim:Play("state2", 0, 0)
	StoryController.instance:dispatchEvent(StoryEvent.OnChangeHeroRoot, self._spineGo)
end

function StoryBgEffsPerspectiveCamera:reset(bgCo)
	StoryBgEffsPerspectiveCamera.super.reset(self, bgCo)
	self:_setViewTop(true)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	if bgCo.effDegree == 0 then
		self._captureAnim.enabled = true

		return
	end

	if self._captureAnim then
		self._captureAnim:Play("end", 0, 0)
	end

	if self._gocamerafake then
		local anim = self._gocamerafake:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			anim:Play("end", 0, 0)
		end
	end
end

function StoryBgEffsPerspectiveCamera:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsPerspectiveCamera:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsPerspectiveCamera:_setViewTop(set)
	return
end

function StoryBgEffsPerspectiveCamera:destroy()
	StoryController.instance:dispatchEvent(StoryEvent.OnResetPerspectiveDialogMat)
	StoryBgEffsPerspectiveCamera.super.destroy(self)
	self:_setViewTop(false)

	self._capture.enabled = false

	StoryController.instance:dispatchEvent(StoryEvent.OnChangeHeroRoot)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)

	if self._captureAnim then
		self._capture.enabled = false

		local player = SLFramework.AnimatorPlayer.Get(self._captureGo)

		if player then
			gohelper.removeComponent(self._captureGo, typeof(SLFramework.AnimatorPlayer))
		end

		gohelper.removeComponent(self._captureGo, typeof(UnityEngine.Animator))

		self._captureAnim = false
	end

	if self._gocamerafake then
		gohelper.destroy(self._gocamerafake)

		self._gocamerafake = nil
	end
end

return StoryBgEffsPerspectiveCamera
