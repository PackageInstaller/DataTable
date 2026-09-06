-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarUISpine.lua

module("logiccommon.common.avatar.new.avatarobject.AvatarUISpine", package.seeall)

local AvatarUISpine = class("AvatarUISpine", AvatarObject)

function AvatarUISpine:ctor(ctrl)
	AvatarUISpine.super.ctor(self)

	self._ctrl = ctrl
end

function AvatarUISpine:setParent(parent)
	AvatarUISpine.super.setParent(self, parent)

	local resObject = self:getGameObject()

	if resObject then
		resObject.transform:SetAsLastSibling()
	end
end

function AvatarUISpine:reset()
	self._assetPath = nil

	self._resLoader:clear()
end

return AvatarUISpine
