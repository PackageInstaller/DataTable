-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarUIBGCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarUIBGCtrl", package.seeall)

local AvatarUIBGCtrl = class("AvatarUIBGCtrl", AvatarController)

function AvatarUIBGCtrl:ctor(avatarBase)
	AvatarUIBGCtrl.super.ctor(self, avatarBase)

	self._uibg = AvatarUIBG.New(self)
	self._layer = nil
	self._bgParent = nil
	self._playEffView = nil
end

function AvatarUIBGCtrl:_getControllerType()
	return AvatarControllerType.UIBG
end

function AvatarUIBGCtrl:onAvatarLoaded()
	AvatarUIBGCtrl.super.onAvatarLoaded(self)
end

function AvatarUIBGCtrl:onAvatarLoadedCallBack()
	AvatarUIBGCtrl.super.onAvatarLoadedCallBack(self)
	self:switchUIBG()
end

function AvatarUIBGCtrl:onAvatarVisible()
	AvatarUIBGCtrl.super.onAvatarVisible(self)
	self._uibg:setVisible(true)
end

function AvatarUIBGCtrl:onAvatarInvisible()
	AvatarUIBGCtrl.super.onAvatarInvisible(self)
	self._uibg:setVisible(false)
end

function AvatarUIBGCtrl:onAvatarReset()
	AvatarUIBGCtrl.super.onAvatarReset(self)
	self._uibg:reset()
end

function AvatarUIBGCtrl:onAvatarDestroy()
	AvatarUIBGCtrl.super.onAvatarDestroy(self)

	self._bgParent = nil
	self._playEffView = nil
end

function AvatarUIBGCtrl:setLayer(layer)
	self._layer = layer

	self._uibg:setLayer(self._layer)
end

function AvatarUIBGCtrl:setBGParent(parent)
	if parent then
		self._bgParent = parent.transform or nil
	end

	self:switchUIBG()
end

function AvatarUIBGCtrl:getCurUIBGId()
	return self._avatar and self._avatar.avatarmo and self._avatar.avatarmo:getDataByType(AvatarDataType.UIBG)
end

function AvatarUIBGCtrl:setBGEffView(view)
	self._playEffView = view
end

function AvatarUIBGCtrl:getBGEffView()
	return self._playEffView
end

function AvatarUIBGCtrl:switchUIBG()
	local uiBGId = self:getCurUIBGId()

	if self._bgParent and uiBGId and uiBGId > 0 then
		self._uibg:setParent(self._bgParent)
		self._uibg:setLayer(self._layer)
		self._uibg:switchId(uiBGId)
	else
		self._uibg:reset()
	end
end

return AvatarUIBGCtrl
