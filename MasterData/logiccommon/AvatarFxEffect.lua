-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarFxEffect.lua

module("logiccommon.common.avatar.avatarobj.AvatarFxEffect", package.seeall)

local AvatarFxEffect = class("AvatarFxEffect", AvatarObject)

function AvatarFxEffect:ctor()
	AvatarFxEffect.super.ctor(self)

	self._playType = fxEffTypev or AvatarFXEffType.Always
end

function AvatarFxEffect:setLayer(layer)
	local setLayer = layer

	if setLayer == SceneLayer.MainPlayer_Value then
		setLayer = SceneLayer.Unit_Value
	end

	AvatarFxEffect.super.setLayer(self, setLayer)
end

function AvatarFxEffect:destroy()
	AvatarFxEffect.super.destroy(self)

	self._playType = AvatarFXEffType.Always
end

function AvatarFxEffect:setPlayType(fxEffTypev)
	self._playType = fxEffTypev or AvatarFXEffType.Always
end

function AvatarFxEffect:getPlayType()
	return self._playType
end

function AvatarFxEffect:updateEffState(updateType)
	local _updateType = updateType or AvatarFXEffType.Always

	if self._playType == AvatarFXEffType.Always then
		self:setVisible(true)

		return
	end

	self:setVisible(self._playType == _updateType)
end

return AvatarFxEffect
