-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryFixDirectionGetter.lua

module("logic.extensions.story.core.comm.StoryFixDirectionGetter", package.seeall)

local M = class("StoryFixDirectionGetter")

function M:ctor()
	self.isFixDir = true
	self.fixDirection = 0
	self.customDirection = nil
	self.fixDirectionVect = nil
end

function M:UpdateAsset(node)
	self.isFixDir = node:GetArgValueBoolean(StoryArgKeyConst.IsFixDirection)

	if not self.isFixDir then
		self.customDirection = node:GetArgValueVector3(StoryArgKeyConst.CustomDirectionValue)
	else
		self.fixDirection = node:GetArgValueNumber(StoryArgKeyConst.FixDirectionValue)

		if self.fixDirection == 0 then
			self.fixDirectionVect = Vector3.forward
		elseif self.fixDirection == 1 then
			self.fixDirectionVect = Vector3.back
		elseif self.fixDirection == 2 then
			self.fixDirectionVect = Vector3.left
		elseif self.fixDirection == 3 then
			self.fixDirectionVect = Vector3.right
		elseif self.fixDirection == 4 then
			self.fixDirectionVect = Vector3(-1, 0, 1)
		elseif self.fixDirection == 5 then
			self.fixDirectionVect = Vector3(1, 0, 1)
		elseif self.fixDirection == 6 then
			self.fixDirectionVect = Vector3(-1, 0, -1)
		elseif self.fixDirection == 7 then
			self.fixDirectionVect = Vector3(1, 0, -1)
		end
	end
end

return M
