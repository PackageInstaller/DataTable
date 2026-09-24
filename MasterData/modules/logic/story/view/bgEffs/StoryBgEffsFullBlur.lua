-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsFullBlur.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsFullBlur", package.seeall)

local StoryBgEffsFullBlur = class("StoryBgEffsFullBlur", StoryBgEffsBase)

function StoryBgEffsFullBlur:ctor()
	StoryBgEffsFullBlur.super.ctor(self)
end

function StoryBgEffsFullBlur:init(bgCo)
	StoryBgEffsFullBlur.super.init(self, bgCo)
end

function StoryBgEffsFullBlur:onStartEffect()
	self:_apply()
end

function StoryBgEffsFullBlur:_apply()
	if self._bgCo.effDegree == StoryEnum.EffDegree.None then
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, self._bgCo.effDegree, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function StoryBgEffsFullBlur:reset(bgCo)
	StoryBgEffsFullBlur.super.reset(self, bgCo)
	self:_apply()
end

function StoryBgEffsFullBlur:destroy()
	StoryBgEffsFullBlur.super.destroy(self)
end

return StoryBgEffsFullBlur
