-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBgShake.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBgShake", package.seeall)

local StoryBgEffsBgShake = class("StoryBgEffsBgShake", StoryBgEffsBase)

function StoryBgEffsBgShake:ctor()
	StoryBgEffsBgShake.super.ctor(self)
end

function StoryBgEffsBgShake:init(bgCo)
	self:setBgCo(bgCo)

	self._alive = true
	self.hasStarted = false
	self._shakeCameraAnimPath = "ui/animations/dynamic/simage_bgimg.controller"

	table.insert(self._resList, self._shakeCameraAnimPath)
end

function StoryBgEffsBgShake:setBgCo(bgCo)
	self._lastBgCo = self._bgCo
	self._bgCo = bgCo
end

function StoryBgEffsBgShake:start(callback, callbackObj)
	if self._bgCo.effDegree == 0 then
		return
	end

	StoryBgEffsBgShake.super.start(self, callback, callbackObj)
end

function StoryBgEffsBgShake:onLoadFinished()
	StoryBgEffsBgShake.super.onLoadFinished(self)

	self.animAssetItem = self._loader:getAssetItem(self._shakeCameraAnimPath)

	self:playEffect()
end

function StoryBgEffsBgShake:_startShake()
	UIBlockMgr.instance:endBlock("shakeEnding")
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._onShakeFinished, self)

	self._bgAnimator.enabled = true

	self._bgAnimator:SetBool("stoploop", false)

	local aniName = {
		"idle",
		"low",
		"middle",
		"high"
	}

	self._bgAnimator:Play(aniName[self._bgCo.effDegree + 1], 0, 0)

	self._bgAnimator.speed = self._bgCo.effRate

	TaskDispatcher.runDelay(self._shakeStop, self, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryBgEffsBgShake:_shakeStop()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("shakeEnding")
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._onShakeFinished, self)

	if self._bgAnimator then
		self._bgAnimator:SetBool("stoploop", true)
	end

	TaskDispatcher.runDelay(self._onShakeFinished, self, 0.67)
end

function StoryBgEffsBgShake:_onShakeFinished()
	UIBlockMgr.instance:endBlock("shakeEnding")
	self:callFinished()
end

function StoryBgEffsBgShake:reset(bgCo)
	self:setBgCo(bgCo)
	self:playEffect()
end

function StoryBgEffsBgShake:playEffect()
	if not self.animAssetItem then
		return
	end

	if gohelper.isNil(self._bgAnimator) then
		local animator = self.animAssetItem:GetResource()
		local frontGo = StoryViewMgr.instance:getStoryFrontBgGo()

		self._bgAnimator = gohelper.onceAddComponent(frontGo, typeof(UnityEngine.Animator))
		self._bgAnimator.enabled = false
		self._bgAnimator.runtimeAnimatorController = animator
	end

	local lastBgCo = self._lastBgCo
	local curBgCo = self._bgCo

	if not curBgCo then
		return
	end

	if lastBgCo then
		if curBgCo.effDegree > 0 then
			if curBgCo.effDegree ~= lastBgCo.effDegree or curBgCo.effRate ~= lastBgCo.effRate then
				self:playShakeByCo(curBgCo)
			else
				self._bgAnimator.enabled = true
			end
		else
			self:_shakeStop()
		end
	else
		self:playShakeByCo(curBgCo)
	end
end

function StoryBgEffsBgShake:playShakeByCo(bgCo)
	local delayTime = bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if delayTime < 0.1 then
		self:_startShake()
	else
		TaskDispatcher.runDelay(self._startShake, self, delayTime)
	end
end

function StoryBgEffsBgShake:destroy()
	StoryBgEffsBgShake.super.destroy(self)

	if self._bgAnimator then
		self._bgAnimator.runtimeAnimatorController = nil
	end

	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._onShakeFinished, self)
	UIBlockMgr.instance:endBlock("shakeEnding")
end

return StoryBgEffsBgShake
