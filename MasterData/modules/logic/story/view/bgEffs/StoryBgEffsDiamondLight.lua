-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsDiamondLight.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsDiamondLight", package.seeall)

local StoryBgEffsDiamondLight = class("StoryBgEffsDiamondLight", StoryBgEffsBase)

function StoryBgEffsDiamondLight:ctor()
	StoryBgEffsDiamondLight.super.ctor(self)
end

function StoryBgEffsDiamondLight:init(bgCo)
	StoryBgEffsDiamondLight.super.init(self, bgCo)

	self._effPrefPath = "ui/viewres/story/bg/v3a2_zuanshiguangban.prefab"
	self._rgbBlurPrefabPath = "ui/viewres/story/bg/storybg_rgbsplit_radialblur_ani.prefab"

	table.insert(self._resList, self._rgbBlurPrefabPath)
	table.insert(self._resList, self._effPrefPath)

	self._effLoaded = false
end

function StoryBgEffsDiamondLight:start(callback, callbackObj)
	StoryBgEffsDiamondLight.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsDiamondLight:onLoadFinished()
	StoryBgEffsDiamondLight.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local bgFrontGo = StoryViewMgr.instance:getStoryFrontBgGo()
	local prefAssetItem = self._loader:getAssetItem(self._effPrefPath)

	self._diamondlightGo = gohelper.clone(prefAssetItem:GetResource(), bgFrontGo)
	self._diamondlightAnim = self._diamondlightGo:GetComponent(typeof(UnityEngine.Animator))

	self._diamondlightAnim:Play("start", 0, 0)
	self._diamondlightAnim:SetBool("isEnd", false)

	local frontGo = StoryViewMgr.instance:getStoryFrontView()
	local blurPrefAssetItem = self._loader:getAssetItem(self._rgbBlurPrefabPath)

	self._rgbBlurGo = gohelper.clone(blurPrefAssetItem:GetResource(), frontGo)

	gohelper.setAsFirstSibling(self._rgbBlurGo)

	local img = self._rgbBlurGo:GetComponent(typeof(UnityEngine.UI.Image))
	local blitEff = StoryViewMgr.instance:getStoryBlitEffSecond()

	img.material:SetTexture("_MainTex", blitEff.capturedTexture)

	self._rgbBlurAnim = self._rgbBlurGo:GetComponent(typeof(UnityEngine.Animator))

	self._rgbBlurAnim:Play("start", 0, 0)
	self._rgbBlurAnim:SetBool("isEnd", false)
end

function StoryBgEffsDiamondLight:reset(bgCo)
	StoryBgEffsDiamondLight.super.reset(self, bgCo)
	self:_setViewTop(true)

	if bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		return
	end

	if not self._effLoaded then
		return
	end

	if self._rgbBlurAnim then
		self._rgbBlurAnim:SetBool("isEnd", true)
	end

	if self._diamondlightAnim then
		self._diamondlightAnim:SetBool("isEnd", true)
	end

	TaskDispatcher.cancelTask(self._onEffFinished, self)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("diamondLightEnding")
	TaskDispatcher.runDelay(self._onEffFinished, self, 4)
end

function StoryBgEffsDiamondLight:_onEffFinished()
	UIBlockMgr.instance:endBlock("diamondLightEnding")

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsDiamondLight:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsDiamondLight:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsDiamondLight:_setViewTop(set)
	local storyViewGo = StoryViewMgr.instance:getStoryView()
	local conGo = gohelper.findChild(storyViewGo, "#go_contentroot")
	local topGo = gohelper.findChild(storyViewGo, "#go_top")

	if set then
		gohelper.setLayer(conGo, UnityLayer.UITop, true)
		gohelper.setLayer(topGo, UnityLayer.UITop, true)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		gohelper.setLayer(conGo, UnityLayer.UISecond, true)
		gohelper.setLayer(topGo, UnityLayer.UISecond, true)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsDiamondLight:destroy()
	UIBlockMgr.instance:endBlock("diamondLightEnding")
	StoryBgEffsDiamondLight.super.destroy(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil

	TaskDispatcher.cancelTask(self._onEffFinished, self)

	if self._diamondlightGo then
		gohelper.destroy(self._diamondlightGo)

		self._diamondlightGo = nil
	end

	if self._rgbBlurGo then
		gohelper.destroy(self._rgbBlurGo)

		self._rgbBlurGo = nil
	end
end

return StoryBgEffsDiamondLight
