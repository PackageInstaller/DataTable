-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsFullGray.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsFullGray", package.seeall)

local StoryBgEffsFullGray = class("StoryBgEffsFullGray", StoryBgEffsBase)

function StoryBgEffsFullGray:ctor()
	StoryBgEffsFullGray.super.ctor(self)
end

function StoryBgEffsFullGray:init(bgCo)
	StoryBgEffsFullGray.super.init(self, bgCo)
end

function StoryBgEffsFullGray:onStartEffect()
	self:_updateValue(0)
	self:_apply()
end

function StoryBgEffsFullGray:_apply()
	self:_killTween()

	if self._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_updateValue(1)
		else
			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._updateValue, self._tweenFinished, self)
		end
	elseif self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_updateValue(0.5)
	else
		local value = PostProcessingMgr.instance:getUIPPValue("Saturation")

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(value, 0.5, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._updateValue, self._tweenFinished, self)
	end
end

function StoryBgEffsFullGray:_updateValue(value)
	PostProcessingMgr.instance:setUIPPValue("saturation", value)
	PostProcessingMgr.instance:setUIPPValue("Saturation", value)
end

function StoryBgEffsFullGray:_tweenFinished()
	self:_killTween()
end

function StoryBgEffsFullGray:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsFullGray:reset(bgCo)
	StoryBgEffsFullGray.super.reset(self, bgCo)
	self:_apply()
end

function StoryBgEffsFullGray:destroy()
	self:_killTween()
	self:_updateValue(0.5)
	StoryBgEffsFullGray.super.destroy(self)
end

return StoryBgEffsFullGray
