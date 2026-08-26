-- chunkname: @modules/logic/story/view/StoryCompBase.lua

module("modules.logic.story.view.StoryCompBase", package.seeall)

local StoryCompBase = class("StoryCompBase", LuaCompBase)

function StoryCompBase:init(go)
	self.compGO = go

	self:onInit()
end

function StoryCompBase:onInit()
	return
end

return StoryCompBase
