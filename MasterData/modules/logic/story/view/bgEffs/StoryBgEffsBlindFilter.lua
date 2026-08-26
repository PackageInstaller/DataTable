-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBlindFilter.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBlindFilter", package.seeall)

local StoryBgEffsBlindFilter = class("StoryBgEffsBlindFilter", StoryBgEffsBase)

function StoryBgEffsBlindFilter:ctor()
	StoryBgEffsBlindFilter.super.ctor(self)
end

function StoryBgEffsBlindFilter:init(bgCo)
	StoryBgEffsBlindFilter.super.init(self, bgCo)

	self._filterEffPrefPath = ResUrl.getStoryBgEffect("storybg_blinder")

	table.insert(self._resList, self._filterEffPrefPath)

	self._effLoaded = false
end

function StoryBgEffsBlindFilter:start(callback, callbackObj)
	StoryBgEffsBlindFilter.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)

	self._blitEff = StoryViewMgr.instance:getStoryBlitEff()

	self:loadRes()
end

function StoryBgEffsBlindFilter:onLoadFinished()
	StoryBgEffsBlindFilter.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local prefAssetItem = self._loader:getAssetItem(self._filterEffPrefPath)
	local frontGo = StoryViewMgr.instance:getStoryFrontView()

	self._filterGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	self:_setBlindFilter()
end

local filterEffDegrees = {
	1,
	0.4,
	0.2,
	0
}

function StoryBgEffsBlindFilter:_setBlindFilter()
	gohelper.setAsFirstSibling(self._filterGo)

	self._imgFilter = self._filterGo:GetComponent(typeof(UnityEngine.UI.Image))

	self._imgFilter.material:SetTexture("_MainTex", self._blitEff.capturedTexture)

	if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_filterUpdate(filterEffDegrees[self._bgCo.effDegree + 1])
	else
		local value = self._imgFilter.material:GetFloat("_SourceColLerp")
		local value

		if self._bgCo.effDegree > 0 then
			value = 1
		end

		self._bgFilterId = ZProj.TweenHelper.DOTweenFloat(value, filterEffDegrees[self._bgCo.effDegree + 1], self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._filterUpdate, self._filterFinished, self)
	end

	self:_setViewTop(true)
	gohelper.setLayer(self._blitEff.gameObject, UnityLayer.UISecond, true)
end

function StoryBgEffsBlindFilter:_filterUpdate(value)
	self._imgFilter.material:SetFloat("_SourceColLerp", value)
end

function StoryBgEffsBlindFilter:_filterFinished()
	if self._bgFilterId then
		ZProj.TweenHelper.KillById(self._bgFilterId)

		self._bgFilterId = nil
	end
end

function StoryBgEffsBlindFilter:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsBlindFilter:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsBlindFilter:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsBlindFilter:reset(bgCo)
	StoryBgEffsBlindFilter.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	self:_setBlindFilter()
end

function StoryBgEffsBlindFilter:destroy()
	if self._bgFilterId then
		ZProj.TweenHelper.KillById(self._bgFilterId)

		self._bgFilterId = nil
	end

	if self._filterGo then
		gohelper.destroy(self._filterGo)

		self._filterGo = nil
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self:_setViewTop(false)
	gohelper.setLayer(self._blitEff.gameObject, UnityLayer.UI, true)
end

return StoryBgEffsBlindFilter
