-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsEnterSplitScreen.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsEnterSplitScreen", package.seeall)

local StoryBgEffsEnterSplitScreen = class("StoryBgEffsEnterSplitScreen", StoryBgEffsBase)

function StoryBgEffsEnterSplitScreen:ctor()
	StoryBgEffsEnterSplitScreen.super.ctor(self)
end

function StoryBgEffsEnterSplitScreen:init(bgCo)
	StoryBgEffsEnterSplitScreen.super.init(self, bgCo)

	local bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()

	self._bgFrontImg = bgImgGo:GetComponent(gohelper.Type_Image)
	self._prefabPath = "ui/viewres/story/bg/v3a6_stencil_beforebg.prefab"
	self._matPath = "ui/materials/dynamic/ui_default_stencil.mat"
	self._screenSplitEffsPrefab2 = "ui/viewres/story/bg/v3a6_trans_splitscreen.prefab"

	table.insert(self._resList, self._prefabPath)
	table.insert(self._resList, self._matPath)
	table.insert(self._resList, self._screenSplitEffsPrefab2)

	self._effLoaded = false
end

function StoryBgEffsEnterSplitScreen:start(callback, callbackObj)
	StoryBgEffsEnterSplitScreen.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsEnterSplitScreen:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function StoryBgEffsEnterSplitScreen:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

function StoryBgEffsEnterSplitScreen:onLoadFinished()
	StoryBgEffsEnterSplitScreen.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local bgGo = StoryViewMgr.instance:getStoryBackgroundView()

	self._bgFrontImg.material = self._loader:getAssetItem(self._matPath):GetResource()

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	self._screenSplitGo = gohelper.clone(prefAssetItem:GetResource(), bgGo)

	local bottomBgGo = gohelper.findChild(bgGo, "#go_bottombg")

	if bottomBgGo then
		self._screenSplitGo.transform:SetSiblingIndex(bottomBgGo.transform:GetSiblingIndex())
	end

	gohelper.setActive(self._screenSplitGo, true)

	local transEffAssetItem = self._loader:getAssetItem(self._screenSplitEffsPrefab2)

	self._transEffectGo = gohelper.clone(transEffAssetItem:GetResource(), bgGo)

	PostProcessingMgr.instance:setUIPPValue("isLocalRGBSplit", true)
	PostProcessingMgr.instance:setUIPPValue("IsLocalRGBSplit", true)
	PostProcessingMgr.instance:setUIPPValue("rgbSplitStrength", 0.06)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitStrength", 0.06)
end

function StoryBgEffsEnterSplitScreen:reset(bgCo)
	StoryBgEffsEnterSplitScreen.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	self._bgFrontImg.material = self._loader:getAssetItem(self._matPath):GetResource()
end

function StoryBgEffsEnterSplitScreen:_onEffFinished()
	return
end

function StoryBgEffsEnterSplitScreen:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsEnterSplitScreen.super.destroy(self)

	if self._screenSplitGo then
		gohelper.destroy(self._screenSplitGo)

		self._screenSplitGo = nil
	end

	if self._transEffectGo then
		gohelper.destroy(self._transEffectGo)

		self._transEffectGo = nil
	end

	PostProcessingMgr.instance:setUIPPValue("isLocalRGBSplit", false)
	PostProcessingMgr.instance:setUIPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUIPPValue("IsLocalRGBSplit", false)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitStrength", 0)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsEnterSplitScreen
