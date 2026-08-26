-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBgShake.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBgShake", package.seeall)

local StoryBgEffsBgShake = class("StoryBgEffsBgShake", StoryBgEffsBase)

function StoryBgEffsBgShake:ctor()
	StoryBgEffsBgShake.super.ctor(self)
end

function StoryBgEffsBgShake:init(bgCo)
	StoryBgEffsBgShake.super.init(self, bgCo)

	self._bgCo = bgCo
	self._shakeCameraAnimPath = "ui/animations/dynamic/simage_bgimg.controller"

	table.insert(self._resList, self._shakeCameraAnimPath)
end

function StoryBgEffsBgShake:start(callback, callbackObj)
	StoryBgEffsBgShake.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
end

function StoryBgEffsBgShake:onLoadFinished()
	StoryBgEffsBgShake.super.onLoadFinished(self)

	local animator = self._loader:getAssetItem(self._shakeCameraAnimPath):GetResource()
	local frontGo = StoryViewMgr.instance:getStoryFrontBgGo()

	self._bgAnimator = gohelper.onceAddComponent(frontGo, typeof(UnityEngine.Animator))
	self._bgAnimator.enabled = false
	self._bgAnimator.runtimeAnimatorController = animator

	if self._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_startShake()
	else
		TaskDispatcher.runDelay(self._startShake, self, self._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
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

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsBgShake:reset(bgCo)
	if bgCo.effDegree > 0 and (bgCo.effDegree ~= self._bgCo.effDegree or bgCo.effRate ~= self._bgCo.effRate) then
		StoryBgEffsBgShake.super.reset(self, bgCo)

		if self._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_startShake()
		else
			TaskDispatcher.runDelay(self._startShake, self, self._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		return
	end

	StoryBgEffsBgShake.super.reset(self, bgCo)

	local stepId = StoryModel.instance:getCurStepId()
	local preSteps = StoryModel.instance:getPreSteps(stepId)

	if not preSteps or #preSteps < 1 then
		self:_shakeStop()

		return
	end

	local preStepCo = StoryStepModel.instance:getStepListById(preSteps[1])

	if not preStepCo then
		self:_shakeStop()

		return
	end

	if preStepCo.conversation.type ~= StoryEnum.ConversationType.BgEffStack and self._bgCo.effDegree < 1 then
		self:_shakeStop()
	end
end

function StoryBgEffsBgShake:destroy()
	StoryBgEffsBgShake.super.destroy(self)

	if self._bgAnimator then
		self._bgAnimator.runtimeAnimatorController = nil
	end

	self._finishedCallback = nil
	self._finishedCallbackObj = nil

	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._onShakeFinished, self)
	UIBlockMgr.instance:endBlock("shakeEnding")
end

return StoryBgEffsBgShake
