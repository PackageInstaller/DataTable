-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarFakePlayer.lua

module("logiccommon.common.avatar.new.avatar.AvatarFakePlayer", package.seeall)

local AvatarFakePlayer = class("AvatarFakePlayer", AvatarBase)

function AvatarFakePlayer:ctor(ctrl)
	AvatarFakePlayer.super.ctor(self)

	self._ctrl = ctrl
	self.useType = AvatarUseType.Scene
	self.nakesCtrl = AvatarNakePartsCtrl.New(self)
	self.effectsCtrl = AvatarEffectsCtrl.New(self)
	self.pendantsCtrl = AvatarPendantsCtrl.New(self)
	self.partsCtrl = AvatarPartsCtrl.New(self)
	self.animatorCtrl = AvatarPlayerAnimatorCtrl.New(self)

	self.addListener(self, AvatarNotify.OnAllPendantsLoaded, self._onAllPartsLoaded, self)
	self.addListener(self, AvatarNotify.OnAllPartLoaded, self._onAllPartsLoaded, self)
end

function AvatarFakePlayer:getAvatarCreateType()
	return AvatarCreateType.FakePlayer
end

function AvatarFakePlayer:getNewUseMo()
	return AvatarPlayerMo.New()
end

function AvatarFakePlayer:setLayer(layer)
	AvatarFakePlayer.super.setLayer(self, layer)
	self.pendantsCtrl:setLayer(layer)
	self.partsCtrl:setLayer(layer)
	self.effectsCtrl:setLayer(layer)
end

function AvatarFakePlayer:destroy()
	AvatarFakePlayer.super.destroy(self)
	self:removeAllListener(AvatarNotify.OnAllPendantsLoaded)
	self:removeAllListener(AvatarNotify.OnAllPartLoaded)
end

function AvatarFakePlayer:reset()
	self._assetPath = nil

	self._resLoader:clear()
	AvatarFakePlayer.super.reset(self)

	local go = self:getGameObject()

	if go then
		local syncMout = SyncPositionByBones.Get(go)

		if syncMout then
			syncMout.enabled = false
		end
	end
end

function AvatarFakePlayer:updateByMo(mo)
	if not mo then
		return
	end

	if mo and mo:isAllSame(self.avatarmo) and self:getGameObject() then
		self.avatarmo.isMount = false

		return
	end

	if self.avatarmo then
		if self.avatarmo.skeleton ~= mo.skeleton then
			self:reset()
		end
	else
		self.avatarmo = self:getNewUseMo()
	end

	self.avatarmo:copyDataByMo(mo)

	if not self.avatarmo then
		print("avatar type load nil mo :" .. self:getAvatarCreateType())
	end

	self:updateState()
end

function AvatarFakePlayer:loadedHandle(loader)
	AvatarFakePlayer.super.loadedHandle(self, loader)

	if self.pendantsCtrl:isAllPendantLoaded() and not self.partsCtrl:isAllPartLoaded() then
		-- block empty
	end
end

function AvatarFakePlayer:_onAllPartsLoaded()
	if self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded() then
		self.nakesCtrl:updateNakeParts()
		self:setLayer(self._layer)
		self.animatorCtrl:resetCurAnimators()
		self.effectsCtrl:buildSuitEffsByCfg()
		self.effectsCtrl:updateSuitEffStates()
		self._ctrl:dispatch(AvatarNotify.OnFakerAvatarLoader, self)
	end
end

function AvatarFakePlayer:setParent(parent)
	AvatarFakePlayer.super.setParent(self, parent)

	local go = self:getGameObject()

	if go then
		local skecfg = AvatarConfig.instance:getSkeletonCfgById(self.avatarmo.skeleton)

		if skecfg then
			if not skecfg.role_scale then
				GameUtil.setLocalScale(go, skecfg.role_scale, skecfg.role_scale, skecfg.role_scale)
			end
		end

		GameUtil.setLocalRotation(go, 90, 0, 0)
	end

	self.dispatch(self, AvatarNotify.OnSetParentFinish, self)
end

function AvatarFakePlayer:_updateParent()
	AvatarFakePlayer.super._updateParent(self)
end

function AvatarFakePlayer:isAllLoaded()
	return self:getGameObject() and self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded()
end

return AvatarFakePlayer
