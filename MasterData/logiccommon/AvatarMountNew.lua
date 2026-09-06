-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarMountNew.lua

module("logiccommon.common.avatar.new.avatar.AvatarMountNew", package.seeall)

local AvatarMountNew = class("AvatarMountNew", AvatarBase)

function AvatarMountNew:ctor(ctrl)
	AvatarMountNew.super.ctor(self)

	self._ctrl = ctrl
	self.animatorCtrl = AvatarAnimatorCtrl.New(self)
	self.effectsCtrl = AvatarEffectsCtrl.New(self)
	self.logicModule = AvatarMountLogicController.New(self)

	self.addListener(self, AvatarNotify.OnAimateStateChange, self._onAimateStateChange, self)
end

function AvatarMountNew:getAvatarCreateType()
	return AvatarCreateType.Mount
end

function AvatarMountNew:updateByMo()
	AvatarMountNew.super.updateByMo(self)
end

function AvatarMountNew:callBackHandle(loader)
	AvatarMountNew.super.callBackHandle(self, loader)
	self._ctrl:dispatch(AvatarNotify.OnMountLoaded, self)
end

function AvatarMountNew:destroy()
	AvatarMountNew.super.destroy(self)
end

function AvatarMountNew:reset()
	self._assetPath = nil

	self._resLoader:clear()
	AvatarMountNew.super.reset(self)
end

function AvatarMountNew:setLayer(layer)
	AvatarMountNew.super.setLayer(self, layer)
	self.effectsCtrl:setLayer(layer)
end

function AvatarMountNew:_onAimateStateChange(state)
	self.effectsCtrl:updateEffStates(state)
end

return AvatarMountNew
