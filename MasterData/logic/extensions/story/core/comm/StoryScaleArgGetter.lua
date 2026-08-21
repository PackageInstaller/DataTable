-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryScaleArgGetter.lua

module("logic.extensions.story.core.comm.StoryScaleArgGetter", package.seeall)

local M = class("StoryScaleArgGetter")

function M:ctor()
	self.scalValid = false
	self.scale = nil
end

function M:UpdateAsset(node)
	self.scalValid = node:GetArgValueBoolean(StoryArgKeyConst.ScaValid)
	self.scale = node:GetArgValueVector3(StoryArgKeyConst.Scale)
end

return M
