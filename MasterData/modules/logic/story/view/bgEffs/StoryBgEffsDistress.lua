-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsDistress.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsDistress", package.seeall)

local StoryBgEffsDistress = class("StoryBgEffsDistress", StoryBgEffsBase)

function StoryBgEffsDistress:ctor()
	StoryBgEffsDistress.super.ctor(self)
end

function StoryBgEffsDistress:init(bgCo)
	StoryBgEffsDistress.super.init(self, bgCo)

	self._distressPrefabPath = "ui/viewres/story/bg/storybg_vignette.prefab"

	table.insert(self._resList, self._distressPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsDistress:start(callback, callbackObj)
	StoryBgEffsDistress.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsDistress:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsDistress:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

local distressEffDegree = {
	0,
	0.6,
	0.8,
	1
}

function StoryBgEffsDistress:onLoadFinished()
	StoryBgEffsDistress.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local frontGo = StoryViewMgr.instance:getStoryFrontView()
	local prefAssetItem = self._loader:getAssetItem(self._distressPrefabPath)

	self._distressGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	gohelper.setAsFirstSibling(self._distressGo)

	self._img = self._distressGo:GetComponent(gohelper.Type_Image)

	local blitEffSecond = StoryViewMgr.instance:getStoryBlitEffSecond()

	self:_setDistressUpdate(0)
	self._img.material:SetTexture("_MainTex", blitEffSecond.capturedTexture)
	self:_killTween()

	if self._bgCo.effDegree < 1 then
		return
	end

	local endValue = distressEffDegree[self._bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._distressTweenId = ZProj.TweenHelper.DOTweenFloat(0, endValue, transTime, self._setDistressUpdate, self._onBgEffDistressFinished, self)
end

function StoryBgEffsDistress:reset(bgCo)
	StoryBgEffsDistress.super.reset(self, bgCo)
	self:_killTween()
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	self:_setViewTop(true)

	local startValue = self._img.material:GetFloat("_TotalFator")
	local endValue = distressEffDegree[bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._distressTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, transTime, self._setDistressUpdate, self._onBgEffDistressFinished, self)
end

function StoryBgEffsDistress:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsDistress:_setDistressUpdate(value)
	if not self._img or not self._img.material then
		return
	end

	self._img.material:SetFloat("_TotalFator", value)
end

function StoryBgEffsDistress:_onBgEffDistressFinished()
	self:_killTween()

	local value = self._img.material:GetFloat("_TotalFator")

	if value <= 0.05 and self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsDistress:_killTween()
	if self._distressTweenId then
		ZProj.TweenHelper.KillById(self._distressTweenId)

		self._distressTweenId = nil
	end
end

function StoryBgEffsDistress:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsDistress.super.destroy(self)

	if self._distressGo then
		gohelper.destroy(self._distressGo)

		self._distressGo = nil
	end

	self:_setViewTop(false)
	self:_setDistressUpdate(0)
	self:_killTween()

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsDistress
