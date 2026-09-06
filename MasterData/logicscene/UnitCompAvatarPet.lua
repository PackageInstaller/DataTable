-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAvatarPet.lua

module("logicscene.scene.unit.component.animation.UnitCompAvatarPet", package.seeall)

local UnitCompAvatarPet = class("UnitCompAvatarPet", UnitComponentBase)

function UnitCompAvatarPet:ctor(unit)
	UnitCompAvatarPet.super.ctor(self, unit)

	self._avatarMo = nil
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(self:getAvatarType())
	self._avatar.useType = AvatarUseType.Scene
	self._defaultAnimState = AnimatorHash.animIdle
	self._curAnimState = nil
	self._playSpeed = 1

	local parent = self._unit.mountRoot:getAvatarRoot()

	self._avatar:setParent(parent.transform)
	self._avatar:setLayer(self._unit:getLayer())
	Framework.TransformUtil.SetLocalRotation(unit.go.transform, -20, 0, 0)
	self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onBodyLoaded, self)
end

function UnitCompAvatarPet:getAvatarType()
	return AvatarCreateType.Pig
end

function UnitCompAvatarPet:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UnitCompAvatarPet:getPlaySpeed()
	return self._playSpeed
end

function UnitCompAvatarPet:getAvatarGo()
	if self._avatar then
		return self._avatar:getGameObject()
	end
end

function UnitCompAvatarPet:getAnimator()
	if self._avatar then
		return self._avatar.animatorCtrl:getAnimator()
	end
end

function UnitCompAvatarPet:setActive(active)
	if self._avatar then
		-- block empty
	end
end

function UnitCompAvatarPet:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function UnitCompAvatarPet:setBody(avatarMo)
	self._avatarMo = avatarMo
end

function UnitCompAvatarPet:_onBodyLoaded(avatar)
	if avatar == self._avatar then
		self.dispatch(self, UnitNotify.SpineLoaded, self)
	end
end

function UnitCompAvatarPet:play(animState, isLoop, isForceRestart)
	if self._avatar then
		self._curAnimState = animState

		if animState == MainPlayerAnimState.Idle then
			self:_cleanStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false, true)
		elseif animState == MainPlayerAnimState.Move then
			self:_cleanStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, true, true)
		end
	end
end

function UnitCompAvatarPet:fixedCrossTo(animState, time)
	if self._avatar then
		self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false, true)
		self:_cleanStates()
		self._avatar.animatorCtrl:crossFadeInFixedTime(animState, time)
	end
end

function UnitCompAvatarPet:_cleanStates()
	if self._avatar then
		-- block empty
	end
end

function UnitCompAvatarPet:onDestroy()
	self._unit = nil

	if self._avatar then
		self._avatar:setLayer(SceneLayer.Invisible_Value)

		self._avatar = AvatarsMgrNew.instance:removeAvatar(self._avatar)
		self._avatar = nil
	end

	self._avatarMo = nil
end

function UnitCompAvatarPet:onUnitVisible(go)
	self._isVisible = true

	if self._avatar then
		self._avatar:updateByMo(self._avatarMo)
		self._avatar:setVisible(true)
	end
end

function UnitCompAvatarPet:onUnitInVisible(go)
	self._isVisible = false

	if self._avatar then
		self._avatar:setVisible(false)
	end
end

return UnitCompAvatarPet
