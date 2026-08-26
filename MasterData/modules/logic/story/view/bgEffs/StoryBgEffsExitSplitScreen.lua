-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsExitSplitScreen.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsExitSplitScreen", package.seeall)

local StoryBgEffsExitSplitScreen = class("StoryBgEffsExitSplitScreen", StoryBgEffsBase)

function StoryBgEffsExitSplitScreen:ctor()
	StoryBgEffsExitSplitScreen.super.ctor(self)
end

function StoryBgEffsExitSplitScreen:init(bgCo)
	StoryBgEffsExitSplitScreen.super.init(self, bgCo)

	self._effLoaded = false
end

function StoryBgEffsExitSplitScreen:start(callback, callbackObj)
	StoryBgEffsExitSplitScreen.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsExitSplitScreen:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function StoryBgEffsExitSplitScreen:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

function StoryBgEffsExitSplitScreen:onLoadFinished()
	StoryBgEffsExitSplitScreen.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local bgGo = StoryViewMgr.instance:getStoryBackgroundView()
	local bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	local img = bgImgGo:GetComponent(gohelper.Type_Image)

	img.material = nil

	PostProcessingMgr.instance:setUIPPValue("isLocalRGBSplit", false)
	PostProcessingMgr.instance:setUIPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUIPPValue("IsLocalRGBSplit", false)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitStrength", 0)
end

function StoryBgEffsExitSplitScreen:reset(bgCo)
	StoryBgEffsExitSplitScreen.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
end

function StoryBgEffsExitSplitScreen:_onEffFinished()
	return
end

function StoryBgEffsExitSplitScreen:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsExitSplitScreen.super.destroy(self)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsExitSplitScreen
