-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarUISpineCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarUISpineCtrl", package.seeall)

local AvatarUISpineCtrl = class("AvatarUISpineCtrl", AvatarController)

function AvatarUISpineCtrl:ctor(avatarBase)
	AvatarUISpineCtrl.super.ctor(self, avatarBase)

	self._uibg = AvatarUISpine.New(self)
	self._layer = nil
	self._bgParent = nil
end

function AvatarUISpineCtrl:_getControllerType()
	return AvatarControllerType.UISpine
end

function AvatarUISpineCtrl:getCurUIBGId()
	return self._avatar and self._avatar.avatarmo and self._avatar.avatarmo:getDataByType(AvatarDataType.UISpine)
end

function AvatarUISpineCtrl:switchUIBG()
	local uiBGId = self:getCurUIBGId()

	if self._bgParent and uiBGId and uiBGId > 0 then
		self._uibg:setParent(self._bgParent)

		local cfg = AvatarConfig.instance:getPartCfgById(uiBGId)

		if cfg and cfg.asset then
			local path = AvatarDataTypeName[AvatarDataType.UISpine]
			local resPath = GameUrl.getAvatarPart(cfg.asset, path, self._avatar.useType, cfg.isResSame)

			if self._uibg:getResPath() ~= resPath then
				self._uibg:reset()
			end

			self._uibg:load(resPath)
			self._uibg:setLayer(self._layer)
		end
	else
		self._uibg:reset()
	end
end

function AvatarUISpineCtrl:onAvatarDestroy()
	AvatarUISpineCtrl.super.onAvatarDestroy(self)

	self._bgParent = nil
end

function AvatarUISpineCtrl:setLayer(layer)
	self._layer = layer

	self._uibg:setLayer(self._layer)
end

function AvatarUISpineCtrl:setBGParent(parent)
	if parent then
		self._bgParent = parent.transform or nil
	end

	self:switchUIBG()
end

function AvatarUISpineCtrl:onAvatarLoaded()
	AvatarUISpineCtrl.super.onAvatarLoaded(self)
end

function AvatarUISpineCtrl:onAvatarLoadedCallBack()
	AvatarUISpineCtrl.super.onAvatarLoadedCallBack(self)
	self:switchUIBG()
end

function AvatarUISpineCtrl:onAvatarVisible()
	AvatarUISpineCtrl.super.onAvatarVisible(self)
	self._uibg:setVisible(true)
end

function AvatarUISpineCtrl:onAvatarInvisible()
	AvatarUISpineCtrl.super.onAvatarInvisible(self)
	self._uibg:setVisible(false)
end

function AvatarUISpineCtrl:onAvatarReset()
	AvatarUISpineCtrl.super.onAvatarReset(self)
	self._uibg:reset()
end

return AvatarUISpineCtrl
