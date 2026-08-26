-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsFilter.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsFilter", package.seeall)

local StoryBgEffsFilter = class("StoryBgEffsFilter", StoryBgEffsBase)

function StoryBgEffsFilter:ctor()
	StoryBgEffsFilter.super.ctor(self)
end

function StoryBgEffsFilter:init(bgCo)
	StoryBgEffsFilter.super.init(self, bgCo)

	self._filterPrefabPath = "ui/viewres/story/bg/storybg_oil_painting.prefab"

	table.insert(self._resList, self._filterPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsFilter:start(callback, callbackObj)
	StoryBgEffsFilter.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsFilter:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function StoryBgEffsFilter:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

local filterEffDegrees = {
	0,
	0.6,
	0.8,
	1
}

function StoryBgEffsFilter:onLoadFinished()
	StoryBgEffsFilter.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local frontGo = StoryViewMgr.instance:getStoryFrontView()
	local prefAssetItem = self._loader:getAssetItem(self._filterPrefabPath)

	self._filterGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	gohelper.setAsFirstSibling(self._filterGo)

	self._img = self._filterGo:GetComponent(gohelper.Type_Image)

	local blitEffSecond = StoryViewMgr.instance:getStoryBlitEffSecond()

	self._img.material:SetTexture("_MainTex", blitEffSecond.capturedTexture)
	self:_killTween()

	if self._bgCo.effDegree < 1 then
		return
	end

	local endValue = filterEffDegrees[self._bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._filterTweenId = ZProj.TweenHelper.DOTweenFloat(0, endValue, transTime, self._setFilterUpdate, self._onEffFinished, self)
end

function StoryBgEffsFilter:reset(bgCo)
	StoryBgEffsFilter.super.reset(self, bgCo)
	self:_killTween()
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)

	local startValue = self._img.material:GetFloat("_Transition")
	local endValue = filterEffDegrees[bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._filterTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, transTime, self._setFilterUpdate, self._onEffFinished, self)
end

function StoryBgEffsFilter:_setFilterUpdate(value)
	if not self._img or not self._img.material then
		return
	end

	self._img.material:SetFloat("_Transition", value)
end

function StoryBgEffsFilter:_onEffFinished()
	self:_killTween()

	local value = self._img.material:GetFloat("_Transition")

	if value <= 0.05 and self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsFilter:_killTween()
	if self._filterTweenId then
		ZProj.TweenHelper.KillById(self._filterTweenId)

		self._filterTweenId = nil
	end
end

function StoryBgEffsFilter:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsFilter.super.destroy(self)

	if self._filterGo then
		gohelper.destroy(self._filterGo)

		self._filterGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	self:_setFilterUpdate(0)
	self:_killTween()

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsFilter
