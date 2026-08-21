-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryArgInfo.lua

module("logic.extensions.story.core.graph.assets.StoryArgInfo", package.seeall)

local M = class("StoryArgInfo", StoryConfigAssetBase)

function M:ctor()
	M.super.ctor(self)

	self.key = nil
	self.value = nil
end

function M:ValueToInt()
	return StoryUtils.ParseNumber(self.value)
end

function M:ValueToFloat()
	return StoryUtils.ParseNumber(self.value)
end

function M:ValueToBoolean()
	return StoryUtils.ParseBoolean(self.value)
end

function M:ValueToVector2()
	return StoryUtils.ParseVector2(self.value) or Vector2.zero
end

function M:ValueToVector3()
	return StoryUtils.ParseVector3(self.value) or Vector3.zero
end

function M:ValueToVector4()
	return StoryUtils.ParseVector4(self.value) or Vector4.zero
end

return M
