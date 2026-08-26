-- chunkname: @modules/logic/story/define/StoryHeroPreviewEnum.lua

module("modules.logic.story.define.StoryHeroPreviewEnum", package.seeall)

local StoryHeroPreviewEnum = _M

StoryHeroPreviewEnum.Direction = {
	Right = 2,
	Middle = 1,
	Left = 0
}
StoryHeroPreviewEnum.HeroType = {
	Live2D = 1,
	Spine = 0
}

return StoryHeroPreviewEnum
