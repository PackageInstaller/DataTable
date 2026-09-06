-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAvatar.lua

module("logicscene.scene.unit.component.animation.UnitCompAvatar", package.seeall)

local UnitCompAvatar = class("UnitCompAvatar", UnitComponentBase)

function UnitCompAvatar:ctor(unit)
	UnitCompAvatar.super.ctor(self, unit)

	self._avatarMo = nil
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(unit:getAvatarType())
	self._avatar.useType = AvatarUseType.Scene
	self._defaultAnimState = AnimatorHash.animIdle
	self._curAnimState = nil
	self._playSpeed = 1
	self._isVisible = false

	local parent = self._unit.mountRoot:getAvatarRoot()

	self._avatar:setParent(parent.transform)
	self._avatar:setLayer(self._unit:getLayer())
	Framework.TransformUtil.SetLocalRotation(unit.go.transform, -20, 0, 0)
	self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onBodyLoaded, self)
	self._avatar:addListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
end

function UnitCompAvatar:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UnitCompAvatar:getPlaySpeed()
	return self._playSpeed
end

function UnitCompAvatar:getAvatarGo()
	if self._avatar then
		return self._avatar:getGameObject()
	end
end

function UnitCompAvatar:getAnimator()
	if self._avatar then
		return self._avatar.animatorCtrl:getAnimator()
	end
end

function UnitCompAvatar:getAnimState()
	local state

	return (self._avatar or nil) and self._curAnimState or self._defaultAnimState
end

function UnitCompAvatar:startMount()
	if self._avatarMo then
		self._avatarMo.isMount = true
	end

	if self._avatar then
		self._avatar.mountCtrl:startMount()
	end
end

function UnitCompAvatar:dismount()
	if self._avatarMo then
		self._avatarMo.isMount = nil
	end

	if self._avatar then
		self._avatar.mountCtrl:dismount()
	end
end

function UnitCompAvatar:setActive(active)
	if self._avatar then
		self._avatar:onSetActive(active)
	end
end

function UnitCompAvatar:_updatePlaySpeed()
	return
end

function UnitCompAvatar:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function UnitCompAvatar:getAvatarMo()
	return self._avatarMo
end

function UnitCompAvatar:setBody(avatarMo)
	self._avatarMo = avatarMo
end

function UnitCompAvatar:getAvatar()
	return self._avatar
end

function UnitCompAvatar:isBodyLoaded()
	return self._avatar and self._avatar:isAllLoaded()
end

function UnitCompAvatar:_onBodyLoaded(avatar)
	if avatar == self._avatar then
		self.dispatch(self, UnitNotify.SpineLoaded, self)
	end
end

function UnitCompAvatar:_onMountLoaded(mount)
	if self._avatar and self._unit then
		self._unit:onMountLoadedFinish(mount)
	end
end

function UnitCompAvatar:update()
	if not self._isVisible then
		return
	end
end

function UnitCompAvatar:_clearSittingDownStatus()
	if self._isSittingDown or self._unit:isFrozenMove() then
		self._isSittingDown = nil

		self._unit:unfrozenMove()
	end
end

function UnitCompAvatar:play(animState)
	if self._avatar then
		self._curAnimState = animState

		if animState == MainPlayerAnimState.Idle then
			self:_clearStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Move then
			self:_clearStates()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Dig then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animDig, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Search then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animSearch, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Unlock then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animUnlock, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Bandage then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animBandage, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Salute then
			self:_clearStates()
			self._unit:dismount()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animSalute)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Chop then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animChop, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Pick then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animPick, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Bomb then
			self._unit:dismount()
			self._avatar.animatorCtrl:setBool(AnimatorHash.animBomb, true)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Dance then
			self:_clearStates()
			self._unit:dismount()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animDance)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Cloths1041 then
			self:_clearStates()
			self._unit:dismount()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animCloths1041)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Greet then
			self:_clearStates()
			self._unit:dismount()
			self._avatar.animatorCtrl:setTrigger(AnimatorHash.animGreet)
			self:_clearSittingDownStatus()
		elseif animState == MainPlayerAnimState.Sit then
			local animator = self:getAnimator()

			if not animator then
				return
			end

			self:_clearStates()
			self._unit:dismount()
			self._unit:setVisible(false)
			self._unit:setVisible(true)
			self._avatar.animatorCtrl:setBool(AnimatorHash.animSit, true)

			local behaviours = animator:GetBehaviours(AnimatorHash.animSitPath, 0)

			if behaviours and behaviours.Length > 0 then
				self._sitAnimListener = behaviours[0]

				self._sitAnimListener:AddListener(self._onSitAnimFinished, self)
			end

			self._isSittingDown = true

			self._unit:frozenMove()
		end
	end
end

function UnitCompAvatar:handleQueryFindWay()
	if self._isSittingDown and self._avatar then
		self._isSittingDown = nil

		self._avatar.animatorCtrl:setBool(AnimatorHash.animSit, false)
	end
end

function UnitCompAvatar:_onSitAnimFinished(state, animator, stateInfo, layerIndex)
	if state == AnimatorListener.STATE_ENTER then
		-- block empty
	elseif state == AnimatorListener.STATE_FINISH or state == AnimatorListener.STATE_EXIT then
		self._isSittingDown = nil

		self._unit:unfrozenMove()
	end
end

function UnitCompAvatar:fixedCrossTo(animState, time)
	if self._avatar then
		self._avatar.animatorCtrl:setBool(AnimatorHash.animWalk, false)
		self:_clearStates()
		self._avatar.animatorCtrl:crossFadeInFixedTime(animState, time)
	end
end

function UnitCompAvatar:_clearStates()
	if self._avatar then
		self._avatar.animatorCtrl:setBool(AnimatorHash.animDig, false)
		self._avatar.animatorCtrl:setBool(AnimatorHash.animSearch, false)
		self._avatar.animatorCtrl:setBool(AnimatorHash.animUnlock, false)
		self._avatar.animatorCtrl:setBool(AnimatorHash.animBandage, false)
		self._avatar.animatorCtrl:setBool(AnimatorHash.animChop, false)
		self._avatar.animatorCtrl:setBool(AnimatorHash.animSit, false)
		self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animCloths1041)
		self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animDance)
		self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animGreet)
		self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animSalute)
	end
end

function UnitCompAvatar:onDestroy()
	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onBodyLoaded, self)
		self._avatar:removeListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)

		self._avatar = AvatarsMgrNew.instance:removeAvatar(self._avatar)
		self._avatar = nil
	end

	self._avatarMo = nil
end

function UnitCompAvatar:onUnitVisible(go)
	self._isVisible = true

	if self._avatar then
		self._avatar:setOwnerUserId(self._unit.id)
		self._avatar:updateByMo(self._avatarMo)
		self._avatar:setVisible(true)

		if self._unit.isMounting and not self._avatarMo.isMount then
			self._unit:dismount()
		end

		self._unit.isMounting = self._avatarMo.isMount
	end
end

function UnitCompAvatar:onUnitInVisible(go)
	self._isSittingDown = nil

	self._unit:unfrozenMove()

	self._isVisible = false

	if self._avatar then
		self._avatar:setVisible(false)
	end
end

function UnitCompAvatar:getHandPoint(PointType)
	if self._avatar then
		return self._avatar:getBoneByPointType(PointType)
	end
end

return UnitCompAvatar
