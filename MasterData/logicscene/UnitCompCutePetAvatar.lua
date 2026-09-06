-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/cutepet/UnitCompCutePetAvatar.lua

module("logicscene.scene.unit.component.cutepet.UnitCompCutePetAvatar", package.seeall)

local UnitCompCutePetAvatar = class("UnitCompCutePetAvatar", UnitCompAvatarPet)

function UnitCompCutePetAvatar:ctor(unit)
	UnitCompCutePetAvatar.super.ctor(self, unit)
	Framework.TransformUtil.SetLocalRotation(unit.go.transform, 0, 0, 0)

	self._isInGarden = false
end

function UnitCompCutePetAvatar:play(animState, isLoop, isForceRestart)
	if self._avatar then
		self._curAnimState = animState

		self._avatar.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("garden"), self._isInGarden, true)

		if animState == UnitAnimState.Idle then
			self:_cleanStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false, true)
		elseif animState == UnitAnimState.Walk2 then
			self:_cleanStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, true, true)
		elseif animState == UnitAnimState.Eat then
			self:_cleanStates()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animEat)
		elseif animState == UnitAnimState.Touch then
			self:_cleanStates()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animTouch)
		end
	end
end

function UnitCompCutePetAvatar:_cleanStates()
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animEat)
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animTouch)
	self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false, true)
end

function UnitCompCutePetAvatar:changeGardenState(bool)
	self._isInGarden = bool
end

return UnitCompCutePetAvatar
