-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarPlayerFaceMat.lua

module("logiccommon.common.avatar.avatarobj.AvatarPlayerFaceMat", package.seeall)

local AvatarPlayerFaceMat = class("AvatarPlayerFaceMat", AvatarObject)

function AvatarPlayerFaceMat:ctor(ctrl)
	AvatarPlayerFaceMat.super.ctor(self)

	self._ctrl = ctrl
end

function AvatarPlayerFaceMat:load(assetPath)
	AvatarPlayerFaceMat.super.load(self, assetPath)
end

function AvatarPlayerFaceMat:destroy()
	AvatarPlayerFaceMat.super.destroy(self)

	self._ctrl = nil
end

function AvatarPlayerFaceMat:loadedHandle(loader)
	if loader == self._resLoader then
		local matobj = self:getResObject()

		if matobj then
			local mat = matobj.res:GetMainAsset()

			self._ctrl:changePlayerFaceMat(mat)
		end
	end

	AvatarPlayerFaceMat.super.loadedHandle(self, loader)
end

function AvatarPlayerFaceMat:callBackHandle(loader)
	if loader == self._resLoader then
		-- block empty
	end

	AvatarPlayerFaceMat.super.callBackHandle(self, loader)
end

function AvatarPlayerFaceMat:reset()
	self._assetPath = nil

	self._resLoader:clear()
end

return AvatarPlayerFaceMat
