-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarPlayer.lua

module("logiccommon.common.avatar.new.avatar.AvatarPlayer", package.seeall)

local AvatarPlayer = class("AvatarPlayer", AvatarBase)

function AvatarPlayer:ctor()
	AvatarPlayer.super.ctor(self)

	self.nakesCtrl = AvatarNakePartsCtrl.New(self)
	self.effectsCtrl = AvatarEffectsCtrl.New(self)
	self.pendantsCtrl = AvatarPendantsCtrl.New(self)
	self.partsCtrl = AvatarPartsCtrl.New(self)
	self.animatorCtrl = AvatarPlayerAnimatorCtrl.New(self)
	self.mountCtrl = AvatarMountCtrl.New(self)
	self.faceMatCtrl = AvatarPlayerFaceMatCtrl.New(self)
	self.UIBGCtrl = AvatarUIBGCtrl.New(self)
	self.UISpineCtrl = AvatarUISpineCtrl.New(self)

	self.animatorCtrl:SetMountCtrl(self.mountCtrl)
	self.addListener(self, AvatarNotify.OnAllPendantsLoaded, self._onAllPartsLoaded, self)
	self.addListener(self, AvatarNotify.OnAllPartLoaded, self._onAllPartsLoaded, self)

	self._layer = SceneLayer.Invisible_Value
end

function AvatarPlayer:getAvatarCreateType()
	return AvatarCreateType.Player
end

function AvatarPlayer:reset(isNotResetData)
	AvatarPlayer.super.reset(self, isNotResetData)
	self:resetDyBone()
end

function AvatarPlayer:resetDyBone()
	local go = self:getGameObject()

	if not goutil.isNil(go) then
		local Type = System.Type
		local typeImageConversion = Type.GetType("DynamicBone")
		local compsC = go:GetComponents(typeImageConversion)
		local bitor = 65535
		local func = tolua.gettypemethod(typeImageConversion, "SetupParticles", bitor)

		for i = 0, compsC.Length - 1 do
			local obj = compsC[i]

			func:Call(obj)
		end

		func:Destroy()
	end
end

function AvatarPlayer:updateByMo(mo)
	if not mo then
		return
	end

	if mo and mo:isAllSame(self.avatarmo) and self:getGameObject() then
		self.avatarmo.isMount = mo.isMount

		self.mountCtrl:_updateMountState()

		return
	end

	if self.mountCtrl.isMounted and self.avatarmo and self.avatarmo.mount ~= mo.mount and mo.isMount then
		self.mountCtrl.isMounted = nil
	end

	if self.avatarmo then
		if self.avatarmo.skeleton ~= mo.skeleton then
			self:reset(true)
		end
	else
		self.avatarmo = self:getNewUseMo()
	end

	self.avatarmo:copyDataByMo(mo)

	if not self.avatarmo then
		print("avatar type load nil mo :" .. self:getAvatarCreateType())
	end

	self:updateState()
	self.UIBGCtrl:switchUIBG()
	self.UISpineCtrl:switchUIBG()
end

function AvatarPlayer:getNewUseMo()
	return AvatarPlayerMo.New()
end

function AvatarPlayer:loadedHandle(loader)
	AvatarPlayer.super.loadedHandle(self, loader)

	if not self.pendantsCtrl:isAllPendantLoaded() or not self.partsCtrl:isAllPartLoaded() then
		local resObject = self:getGameObject()

		if resObject then
			Framework.GameObjectUtil.SetLayerRecursively(resObject, SceneLayer.Invisible_Value)
		end
	end
end

function AvatarPlayer:_onAllPartsLoaded()
	if self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded() then
		self.mountCtrl:updateMountingLayer()
		self.nakesCtrl:updateNakeParts()
		self:setLayer(self._layer)
		self.animatorCtrl:resetCurAnimators()
		self.effectsCtrl:buildSuitEffsByCfg()
		self.effectsCtrl:updateSuitEffStates()
		self.dispatch(self, AvatarNotify.OnAvatarLoaded, self)
	end
end

function AvatarPlayer:setLayer(layer)
	AvatarPlayer.super.setLayer(self, layer)
	self.pendantsCtrl:setLayer(layer)
	self.partsCtrl:setLayer(layer)
	self.mountCtrl:setLayer(layer)
	self.effectsCtrl:setLayer(layer)
	self.UIBGCtrl:setLayer(layer)
	self.UISpineCtrl:setLayer(layer)
end

function AvatarPlayer:updateExtBgParent(uibgParent, uiSpineParent, view)
	self.UIBGCtrl:setBGParent(uibgParent)
	self.UIBGCtrl:setBGEffView(view)
	self.UISpineCtrl:setBGParent(uiSpineParent)
end

function AvatarPlayer:setParent(parent)
	AvatarPlayer.super.setParent(self, parent)

	local go = self:getGameObject()

	if go then
		local skecfg = AvatarConfig.instance:getSkeletonCfgById(self.avatarmo.skeleton)

		if skecfg then
			if not skecfg.role_scale then
				GameUtil.setLocalScale(go, skecfg.role_scale, skecfg.role_scale, skecfg.role_scale)
			end
		end
	end

	self.dispatch(self, AvatarNotify.OnSetParentFinish, self)
end

function AvatarPlayer:_updateParent()
	AvatarPlayer.super._updateParent(self)
end

function AvatarPlayer:destroy()
	AvatarPlayer.super.destroy(self)
	self:removeAllListener(AvatarNotify.OnAllPendantsLoaded)
	self:removeAllListener(AvatarNotify.OnAllPartLoaded)
end

function AvatarPlayer:onSetActive(active)
	if active and self:getGameObject() then
		self.mountCtrl:updateMountingLayer()
	end
end

function AvatarPlayer:isAllLoaded()
	return self:getGameObject() and self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded() and self.mountCtrl:isMountLoaded()
end

return AvatarPlayer
