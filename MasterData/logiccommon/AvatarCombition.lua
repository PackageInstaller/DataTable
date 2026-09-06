-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarCombition.lua

module("logiccommon.common.avatar.AvatarCombition", package.seeall)

local AvatarCombition = class("AvatarCombition")

function AvatarCombition:ctor()
	self.key = nil

	self:reset()
end

function AvatarCombition:reset()
	self.skinnedMeshAtlas = nil
	self.combineMesh = nil
	self.uv = nil
	self.bones = nil
	self.refCount = 0
	self.key = nil
end

function AvatarCombition:retain()
	self.refCount = self.refCount + 1
end

function AvatarCombition:release()
	self.refCount = self.refCount - 1
end

function AvatarCombition:destroy()
	if self.refCount > 0 then
		error("尝试销毁合并的设置：key=" .. self.key .. "  refCount=" .. self.refCount)

		return
	end

	if self.skinnedMeshAtlas then
		PackTextureCache.instance:returnPackTexture(self.skinnedMeshAtlas)

		self.skinnedMeshAtlas = nil
	end

	if self.combineMesh then
		goutil.destroy(self.combineMesh)
	end

	self:reset()
end

function AvatarCombition:tryDestroy()
	if self.refCount == 0 then
		self:destroy()

		return true
	end
end

return AvatarCombition
