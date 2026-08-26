-- chunkname: @modules/logic/story/view/bgTrans/StoryBgTransScreenSplit.lua

module("modules.logic.story.view.bgTrans.StoryBgTransScreenSplit", package.seeall)

local StoryBgTransScreenSplit = class("StoryBgTransScreenSplit", StoryBgTransBase)

function StoryBgTransScreenSplit:ctor()
	StoryBgTransScreenSplit.super.ctor(self)
end

function StoryBgTransScreenSplit:init(transType)
	StoryBgTransScreenSplit.super.init(self)

	self._transInTime = 0
	self._transOutTime = 0.3
	self._exitScreenTransTime = 0.3
	self._transType = transType or StoryEnum.BgTransType.ScreenSplit

	if self._transType == StoryEnum.BgTransType.ScreenSplitExit then
		self._screenSplitTransPrefab = "ui/viewres/story/bg/v3a6_trans_splitscreen_total.prefab"

		table.insert(self._resList, self._screenSplitTransPrefab)
		StoryModel.instance:setInScreenSplitMode(false)
	else
		StoryModel.instance:setInScreenSplitMode(true)
	end
end

function StoryBgTransScreenSplit:start(callback, callbackObj)
	StoryBgTransScreenSplit.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
end

function StoryBgTransScreenSplit:onLoadFinished()
	StoryBgTransScreenSplit.super.onLoadFinished(self)

	if self._transType == StoryEnum.BgTransType.ScreenSplitExit then
		local bgGo = StoryViewMgr.instance:getStoryBackgroundView()
		local transEffAssetItem = self._loader:getAssetItem(self._screenSplitTransPrefab)

		self._transEffectGo = gohelper.clone(transEffAssetItem:GetResource(), bgGo)

		TaskDispatcher.runDelay(self.onSwitchBg, self, self._exitScreenTransTime)
	else
		TaskDispatcher.runDelay(self.onSwitchBg, self, self._transInTime)
	end
end

function StoryBgTransScreenSplit:onSwitchBg()
	StoryBgTransScreenSplit.super.onSwitchBg(self)
	TaskDispatcher.runDelay(self.onTransFinished, self, self._transOutTime)
end

function StoryBgTransScreenSplit:onTransFinished()
	StoryBgTransScreenSplit.super.onTransFinished(self)

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)
	end

	self:_clearTrans()
end

function StoryBgTransScreenSplit:_clearTrans()
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	PostProcessingMgr.instance:setUIPPValue("customPassActive", false)
	PostProcessingMgr.instance:setUIPPValue("CustomPassActive", false)

	if self._transEffectGo then
		gohelper.destroy(self._transEffectGo)

		self._transEffectGo = nil
	end

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgTransScreenSplit:destroy()
	StoryBgTransScreenSplit.super.destroy(self)
	TaskDispatcher.cancelTask(self.onSwitchBg, self)
	TaskDispatcher.cancelTask(self.onTransFinished, self)
	self:_clearTrans()
end

return StoryBgTransScreenSplit
