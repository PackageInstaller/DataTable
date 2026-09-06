-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarFxEff.lua

module("logiccommon.common.avatar.AvatarFxEff", package.seeall)

local AvatarFxEff = class("AvatarFxEff")

function AvatarFxEff:ctor()
	self._resLoader = AvatarResLoader.New(true)
end

function AvatarFxEff:load(assetPath, hagPoint, fxEffType)
	self.hagPoint = hagPoint
	self.fxEffType = fxEffType or AvatarFXEffType.Always

	self._resLoader:load(assetPath)
end

function AvatarFxEff:setLayer(layer)
	self.layer = layer

	if self.layer == SceneLayer.MainPlayer_Value then
		self.layer = SceneLayer.Unit_Value
	end

	if self.layer then
		local resObject = self._resLoader:getResObject()

		if resObject then
			resObject:setLayer(self.layer)
		end
	end
end

function AvatarFxEff:updateParent()
	self._resLoader:setParent(self.hagPoint)
end

function AvatarFxEff:destroy()
	self._resLoader:clear()
end

function AvatarFxEff:setVisible(visible)
	local resObject = self._resLoader:getResObject()

	if resObject then
		resObject:setActive(visible)
	end
end

return AvatarFxEff
