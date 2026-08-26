-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsLineLight.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsLineLight", package.seeall)

local StoryBgEffsLineLight = class("StoryBgEffsLineLight", StoryBgEffsBase)

function StoryBgEffsLineLight:ctor()
	StoryBgEffsLineLight.super.ctor(self)
end

function StoryBgEffsLineLight:init(bgCo)
	StoryBgEffsLineLight.super.init(self, bgCo)

	self._lightPrefabPath = "ui/viewres/story/bg/storybg_energy_imbalance.prefab"

	table.insert(self._resList, self._lightPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsLineLight:start(callback, callbackObj)
	StoryBgEffsLineLight.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsLineLight:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function StoryBgEffsLineLight:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

local filterEffDegrees = {
	0,
	1
}

function StoryBgEffsLineLight:onLoadFinished()
	StoryBgEffsLineLight.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local frontGo = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")
	local prefAssetItem = self._loader:getAssetItem(self._lightPrefabPath)

	self._lightGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	gohelper.setAsFirstSibling(self._lightGo)

	self._originImg = gohelper.findChildImage(self._lightGo, "origin_line")
	self._offsetImg = gohelper.findChildImage(self._lightGo, "offset_line")

	local blitEffSecond = StoryViewMgr.instance:getStoryBlitEffSecond()

	self._originMat = self._originImg.material
	self._offsetMat = self._offsetImg.material

	self._originMat:SetTexture("_MainTex", blitEffSecond.capturedTexture)
	self._offsetMat:SetTexture("_MainTex", blitEffSecond.capturedTexture)
	self:_killTween()

	if self._bgCo.effDegree == 1 then
		return
	end

	local endValue = filterEffDegrees[self._bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._lightTweenId = ZProj.TweenHelper.DOTweenFloat(0, endValue, transTime, self._setLightUpdate, self._onEffFinished, self)
end

function StoryBgEffsLineLight:reset(bgCo)
	StoryBgEffsLineLight.super.reset(self, bgCo)
	self:_killTween()
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)

	local startValue = self._originMat:GetFloat("_SourceColLerp")
	local endValue = filterEffDegrees[bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._lightTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, transTime, self._setLightUpdate, self._onEffFinished, self)
end

function StoryBgEffsLineLight:_setLightUpdate(value)
	if not self._originImg or not self._originMat then
		return
	end

	self._originMat:SetFloat("_SourceColLerp", value)
	self._offsetMat:SetFloat("_SourceColLerp", value)
end

function StoryBgEffsLineLight:_onEffFinished()
	self:_killTween()

	local value = self._originMat:GetFloat("_SourceColLerp")

	if value >= 0.95 and self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsLineLight:_killTween()
	if self._lightTweenId then
		ZProj.TweenHelper.KillById(self._lightTweenId)

		self._lightTweenId = nil
	end
end

function StoryBgEffsLineLight:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsLineLight.super.destroy(self)

	if self._lightGo then
		gohelper.destroy(self._lightGo)

		self._lightGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	self:_setLightUpdate(0)
	self:_killTween()

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsLineLight
