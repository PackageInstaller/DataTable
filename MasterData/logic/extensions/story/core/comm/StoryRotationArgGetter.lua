-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryRotationArgGetter.lua

module("logic.extensions.story.core.comm.StoryRotationArgGetter", package.seeall)

local M = class("StoryRotationArgGetter")

function M:ctor()
	self.rotValid = false
	self.rotation = nil
end

function M:UpdateAsset(node)
	self.rotValid = node:GetArgValueBoolean(StoryArgKeyConst.RotValid)
	self.rotation = node:GetArgValueVector3(StoryArgKeyConst.Rotation)
end

return M
