-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarPig.lua

module("logiccommon.common.avatar.new.avatar.AvatarPig", package.seeall)

local AvatarPig = class("AvatarPig", AvatarBase)

function AvatarPig:ctor()
	AvatarPig.super.ctor(self)

	self.animatorCtrl = AvatarAnimatorCtrl.New(self)
	self.pendantsCtrl = AvatarPendantsCtrl.New(self)
	self.partsCtrl = AvatarPartsCtrl.New(self)

	self.addListener(self, AvatarNotify.OnAllPendantsLoaded, self._onAllPartsLoaded, self)
	self.addListener(self, AvatarNotify.OnAllPartLoaded, self._onAllPartsLoaded, self)
end

function AvatarPig:getAvatarCreateType()
	return AvatarCreateType.Pig
end

function AvatarPig:getNewUseMo()
	return AvatarPetMo.New()
end

function AvatarPig:_onAllPartsLoaded()
	if self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded() then
		self.dispatch(self, AvatarNotify.OnAvatarLoaded, self)
	end
end

function AvatarPig:setLayer(layer)
	AvatarPig.super.setLayer(self, layer)
	self.pendantsCtrl:setLayer(layer)
	self.partsCtrl:setLayer(layer)
end

function AvatarPig:destroy()
	AvatarPig.super.destroy(self)
	self:removeAllListener(AvatarNotify.OnAllPendantsLoaded)
	self:removeAllListener(AvatarNotify.OnAllPartLoaded)
end

function AvatarPig:isAllLoaded()
	return self:getGameObject() and self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded()
end

return AvatarPig
