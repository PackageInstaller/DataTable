-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsPenetration.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsPenetration", package.seeall)

local StoryBgEffsPenetration = class("StoryBgEffsPenetration", StoryBgEffsBase)

function StoryBgEffsPenetration:ctor()
	StoryBgEffsPenetration.super.ctor(self)
end

function StoryBgEffsPenetration:init(bgCo)
	self._bgCo = bgCo

	StoryBgEffsPenetration.super.init(self, bgCo)

	self._penetrationPrefabPath = string.format("effects/prefabs/story/v3a3_yuncengchuansuo_1.prefab")

	table.insert(self._resList, self._penetrationPrefabPath)
end

function StoryBgEffsPenetration:start(callback, callbackObj)
	StoryBgEffsPenetration.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsPenetration:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsPenetration:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsPenetration:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsPenetration:onLoadFinished()
	StoryBgEffsPenetration.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local prefabAssetItem = self._loader:getAssetItem(self._penetrationPrefabPath)
	local penetrationGo = prefabAssetItem:GetResource(self._penetrationPrefabPath)
	local rootGo = StoryViewMgr.instance:getStoryView()

	self._goPenetration = gohelper.clone(penetrationGo, rootGo)
	self._penetrationAnim = self._goPenetration:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setAsFirstSibling(self._goPenetration)
end

function StoryBgEffsPenetration:reset(bgCo)
	StoryBgEffsPenetration.super.reset(self, bgCo)

	self._bgCo = bgCo

	StoryTool.enablePostProcess(true)
	self:_setViewTop(true)

	if self._bgCo.effDegree ~= 0 then
		if self._penetrationAnim then
			self._penetrationAnim:Play("end", 0, 0)
		end

		TaskDispatcher.cancelTask(self._onEndFinished, self)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("penetrationEnding")
		TaskDispatcher.runDelay(self._onEndFinished, self, 4)
	end
end

function StoryBgEffsPenetration:_onEndFinished()
	UIBlockMgr.instance:endBlock("penetrationEnding")

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsPenetration:destroy()
	StoryBgEffsPenetration.super.destroy(self)
	self:_setViewTop(false)

	if self._goPenetration then
		gohelper.destroy(self._goPenetration)

		self._goPenetration = nil
	end

	TaskDispatcher.cancelTask(self._onEndFinished, self)
	UIBlockMgr.instance:endBlock("penetrationEnding")
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

return StoryBgEffsPenetration
