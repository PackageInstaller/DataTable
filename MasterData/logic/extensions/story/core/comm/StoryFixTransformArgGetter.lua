-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryFixTransformArgGetter.lua

module("logic.extensions.story.core.comm.StoryFixTransformArgGetter", package.seeall)

local M = class("StoryFixTransformArgGetter")

function M:ctor()
	self.positiongetter = StoryPositionArgGetter.New()
	self.rotationgetter = StoryRotationArgGetter.New()
	self.scalegetter = StoryScaleArgGetter.New()
end

function M:UpdateAsset(node)
	self.positiongetter:UpdateAsset(node)
	self.rotationgetter:UpdateAsset(node)
	self.scalegetter:UpdateAsset(node)
end

return M
