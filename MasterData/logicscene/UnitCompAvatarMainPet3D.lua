-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAvatarMainPet3D.lua

module("logicscene.scene.unit.component.animation.UnitCompAvatarMainPet3D", package.seeall)

local UnitCompAvatarMainPet3D = class("UnitCompAvatarMainPet3D", UnitComponentBase)

function UnitCompAvatarMainPet3D:ctor(unit)
	UnitCompAvatarMainPet3D.super.ctor(self, unit)

	self._avatarMo = nil
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)
	self._avatar.useType = AvatarUseType.Scene
	self._defaultAnimState = AnimatorHash.animIdle
	self._curAnimState = nil
	self._playSpeed = 1

	local parent = self._unit.mountRoot:getAvatarRoot()

	self._avatar:setParent(parent.transform)
	self._avatar:setLayer(self._unit:getLayer())

	self._avatarMo = AvatarConfig.instance:getAvatarMoByCfgId(4)

	Framework.TransformUtil.SetLocalRotation(unit.go.transform, 0, 0, 0)
	self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onBodyLoaded, self)
end

function UnitCompAvatarMainPet3D:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UnitCompAvatarMainPet3D:getPlaySpeed()
	return self._playSpeed
end

function UnitCompAvatarMainPet3D:getAvatarGo()
	if self._avatar then
		return self._avatar:getGameObject()
	end
end

function UnitCompAvatarMainPet3D:getAnimator()
	if self._avatar then
		return self._avatar.animatorCtrl:getAnimator()
	end
end

function UnitCompAvatarMainPet3D:setActive(active)
	if self._avatar then
		-- block empty
	end
end

function UnitCompAvatarMainPet3D:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function UnitCompAvatarMainPet3D:_onBodyLoaded(avatar)
	if avatar == self._avatar then
		local go = self:getAvatarGo()

		if go then
			go.name = "UnitPet_" .. self._unit.id
		end

		self.dispatch(self, UnitNotify.SpineLoaded, self)
	end
end

function UnitCompAvatarMainPet3D:play(animState, isLoop, isForceRestart)
	if self._avatar then
		self._curAnimState = animState

		if animState == MainPlayerAnimState.Idle then
			self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animWalk)
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animIdle)
		elseif animState == MainPlayerAnimState.Move then
			self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animIdle)
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animWalk)
		end
	end
end

function UnitCompAvatarMainPet3D:fixedCrossTo(animState, time)
	if self._avatar then
		self._avatar.animatorCtrl:setTrigger(AnimatorHash.animWalk)
		self:_cleanStates()
		self._avatar.animatorCtrl:crossFadeInFixedTime(animState, time)
	end
end

function UnitCompAvatarMainPet3D:_cleanStates()
	if self._avatar then
		-- block empty
	end
end

function UnitCompAvatarMainPet3D:onDestroy()
	if self._avatar then
		self._avatar:setLayer(SceneLayer.Invisible_Value)

		self._avatar = AvatarsMgrNew.instance:removeAvatar(self._avatar)
		self._avatar = nil
	end

	self._avatarMo = nil
end

function UnitCompAvatarMainPet3D:onUnitVisible(go)
	self._isVisible = true

	if self._avatar then
		self._avatar:updateByMo(self._avatarMo)
		self._avatar:setVisible(true)
	end
end

function UnitCompAvatarMainPet3D:onUnitInVisible(go)
	self._isVisible = false

	if self._avatar then
		self._avatar:setVisible(false)
	end
end

return UnitCompAvatarMainPet3D
