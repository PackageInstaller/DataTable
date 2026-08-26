-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsSetLayer.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsSetLayer", package.seeall)

local StoryBgEffsSetLayer = class("StoryBgEffsSetLayer", StoryBgEffsBase)

function StoryBgEffsSetLayer:ctor()
	StoryBgEffsSetLayer.super.ctor(self)
end

function StoryBgEffsSetLayer:init(bgCo)
	StoryBgEffsSetLayer.super.init(self, bgCo)
end

function StoryBgEffsSetLayer:start(callback, callbackObj)
	StoryBgEffsSetLayer.super.start(self)
	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsSetLayer:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsSetLayer:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsSetLayer:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsSetLayer:onLoadFinished()
	StoryBgEffsSetLayer.super.onLoadFinished(self)
end

function StoryBgEffsSetLayer:reset(bgCo)
	StoryBgEffsSetLayer.super.reset(self, bgCo)
	self:_setViewTop(true)
end

function StoryBgEffsSetLayer:destroy()
	StoryBgEffsSetLayer.super.destroy(self)
	self:_setViewTop(false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

return StoryBgEffsSetLayer
