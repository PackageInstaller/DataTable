-- chunkname: @modules/logic/story/view/bgTrans/StoryBgTransBloom.lua

module("modules.logic.story.view.bgTrans.StoryBgTransBloom", package.seeall)

local StoryBgTransBloom = class("StoryBgTransBloom", StoryBgTransBase)

function StoryBgTransBloom:ctor()
	StoryBgTransBloom.super.ctor(self)
end

local baseTime = 0.25

function StoryBgTransBloom:init()
	StoryBgTransBloom.super.init(self)
	self:setBgTransType(StoryEnum.BgTransType.Bloom1)

	self._bloomAnimPath = "ui/animations/dynamic/story_bloomchange.controller"

	table.insert(self._resList, self._bloomAnimPath)
end

function StoryBgTransBloom:setBgTransType(type)
	self._transType = type
	self._transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._transType)
end

function StoryBgTransBloom:start(callback, callbackObj)
	StoryBgTransBloom.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
	GameUtil.setActiveUIBlock("bgTrans", true, false)
end

function StoryBgTransBloom:onLoadFinished()
	StoryBgTransBloom.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local anim = self._loader:getAssetItem(self._bloomAnimPath):GetResource()
	local cameraRoot = CameraMgr.instance:getUICameraGO()

	self._animRoot = gohelper.findChild(cameraRoot, "PPUIVolume")
	self._bloomAnim = gohelper.onceAddComponent(self._animRoot, typeof(UnityEngine.Animator))
	self._bloomAnim.runtimeAnimatorController = anim

	if self._transMo.transTime > 0.01 then
		self._bloomAnim.speed = baseTime / self._transMo.transTime or 1
	end

	self._bloomAnim:Play("trans", 0, 0)
	TaskDispatcher.runDelay(self.onSwitchBg, self, self._transMo.transTime)
end

function StoryBgTransBloom:onSwitchBg()
	StoryBgTransBloom.super.onSwitchBg(self)
	TaskDispatcher.runDelay(self.onTransFinished, self, self._transMo.transTime)
end

function StoryBgTransBloom:onTransFinished()
	StoryBgTransBloom.super.onTransFinished(self)

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)
	end

	self:_clearTrans()
end

function StoryBgTransBloom:_clearTrans()
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	gohelper.removeComponent(self._animRoot, typeof(UnityEngine.Animator))

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgTransBloom:destroy()
	StoryBgTransBloom.super.destroy(self)
	TaskDispatcher.cancelTask(self.onSwitchBg, self)
	TaskDispatcher.cancelTask(self.onTransFinished, self)
	self:_clearTrans()
end

return StoryBgTransBloom
