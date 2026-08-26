-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsEagleEye.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsEagleEye", package.seeall)

local StoryBgEffsEagleEye = class("StoryBgEffsEagleEye", StoryBgEffsBase)

function StoryBgEffsEagleEye:ctor()
	StoryBgEffsEagleEye.super.ctor(self)
end

function StoryBgEffsEagleEye:init(bgCo)
	StoryBgEffsEagleEye.super.init(self, bgCo)

	self._eagleEyePrefabPath = "ui/viewres/story/bg/radial_blur_controller.prefab"

	table.insert(self._resList, self._eagleEyePrefabPath)

	self._effInTime = 0.5
	self._effKeepTime = bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
end

function StoryBgEffsEagleEye:start(callback, callbackObj)
	StoryBgEffsEagleEye.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsEagleEye:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsEagleEye:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsEagleEye:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsEagleEye:onLoadFinished()
	StoryBgEffsEagleEye.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local prefAssetItem = self._loader:getAssetItem(self._eagleEyePrefabPath)
	local bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()

	self._eagleEyeGo = gohelper.clone(prefAssetItem:GetResource(), bgImgGo)
	self._eagleCtrl = self._eagleEyeGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self._eagleCtrl.float_01 = 0.2
	self._eagleCtrl.float_02 = 1.5

	local center = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUIPPValue("rgbSplitCenter", center)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitCenter", center)
	self:_setBlurLevel(1)

	if self._eyeTweenId then
		ZProj.TweenHelper.KillById(self._eyeTweenId)

		self._eyeTweenId = nil
	end

	self._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(1, 10, self._effInTime, self._setBlurLevel, self.onEffInFinished, self)
end

function StoryBgEffsEagleEye:reset(bgCo)
	StoryBgEffsEagleEye.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)
	self:_setViewTop(true)
end

function StoryBgEffsEagleEye:_setBlurLevel(lv)
	PostProcessingMgr.instance:setUIPPValue("radialBlurLevel", lv)
	PostProcessingMgr.instance:setUIPPValue("RadialBlurLevel", lv)
end

function StoryBgEffsEagleEye:onEffInFinished()
	self:_setBlurLevel(10)

	if self._eyeTweenId then
		ZProj.TweenHelper.KillById(self._eyeTweenId)

		self._eyeTweenId = nil
	end

	TaskDispatcher.runDelay(self.onEffKeepFinished, self, self._effKeepTime)
end

function StoryBgEffsEagleEye:onEffKeepFinished()
	if self._eyeTweenId then
		ZProj.TweenHelper.KillById(self._eyeTweenId)

		self._eyeTweenId = nil
	end

	self._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(10, 1, self._effOutTime, self._setBlurLevel, self.onEffOutFinished, self)
end

function StoryBgEffsEagleEye:onEffOutFinished()
	StoryBgEffsEagleEye.super.onEffOutFinished(self)

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsEagleEye:_clearEffs()
	self:_setBlurLevel(1)
	self:_setViewTop(false)

	if self._eagleCtrl then
		self._eagleCtrl.float_01 = 0
		self._eagleCtrl.float_02 = 0.001
		self._eagleCtrl = nil
	end

	if self._eagleEyeGo then
		gohelper.destroy(self._eagleEyeGo)

		self._eagleEyeGo = nil
	end

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgEffsEagleEye:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsEagleEye.super.destroy(self)

	if self._eyeTweenId then
		ZProj.TweenHelper.KillById(self._eyeTweenId)

		self._eyeTweenId = nil
	end

	TaskDispatcher.cancelTask(self.onEffKeepFinished, self)
	self:_clearEffs()
end

return StoryBgEffsEagleEye
