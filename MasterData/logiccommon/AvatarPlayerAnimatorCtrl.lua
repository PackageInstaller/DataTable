-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarPlayerAnimatorCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarPlayerAnimatorCtrl", package.seeall)

local AvatarPlayerAnimatorCtrl = class("AvatarPlayerAnimatorCtrl", AvatarAnimatorCtrl)

function AvatarPlayerAnimatorCtrl:ctor(avatarBase)
	AvatarPlayerAnimatorCtrl.super.ctor(self, avatarBase)

	self._mountCtrl = nil
	self._animators = nil
end

function AvatarPlayerAnimatorCtrl:_getControllerType()
	return AvatarControllerType.Animator
end

function AvatarPlayerAnimatorCtrl:SetMountCtrl(mountCtrl)
	self._mountCtrl = mountCtrl
end

function AvatarPlayerAnimatorCtrl:onAvatarLoadedCallBack()
	self:resetCurAnimators()
end

function AvatarPlayerAnimatorCtrl:onAvatarInvisible()
	self._animators = nil
end

function AvatarPlayerAnimatorCtrl:onAvatarReset()
	AvatarPlayerAnimatorCtrl.super.onAvatarReset(self)

	self._animators = nil
end

function AvatarPlayerAnimatorCtrl:resetCurAnimators()
	self._animators = {}

	local skeletonGo = self._avatar:getGameObject()

	if skeletonGo then
		local anim = skeletonGo:GetComponent(ComponentType.Animator)

		if anim and not goutil.isNil(anim) then
			table.insert(self._animators, anim)
		end

		local go = self._avatar:getBoneByPointType(AvatarHangPointType.Head)

		if go then
			local hairGo = goutil.findChild(go, "hair")

			if hairGo then
				anim = hairGo:GetComponent(ComponentType.Animator)

				if anim and not goutil.isNil(anim) then
					table.insert(self._animators, anim)
				end
			end
		end
	end
end

function AvatarPlayerAnimatorCtrl:getCurAnimators()
	if not self._animators then
		self:resetCurAnimators()
	end

	return self._animators
end

function AvatarPlayerAnimatorCtrl:play(currAnim)
	self._currAnim = currAnim

	if self._mountCtrl then
		if self._mountCtrl.isMounted then
			self:playAnim(currAnim, self._mountCtrl.mountLayerIndex, 0)

			if self._mountCtrl.mount:getGameObject() then
				self._mountCtrl.mount.animatorCtrl:play(currAnim, 0, 0)
			end
		end
	else
		self:playAnim(currAnim, 0, 0)
	end
end

function AvatarPlayerAnimatorCtrl:playAnim(currAnim, layer, normalizeTime)
	if self:isPlaying(currAnim, layer) then
		return
	end

	self._currAnim = currAnim

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		if goutil.isNil(anims[i]) then
			self._animators = nil

			break
		end

		anims[i]:Play(currAnim, layer or 0, normalizeTime or 0)
	end

	if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
	else
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
	end
end

function AvatarPlayerAnimatorCtrl:crossFadeInFixedTime(currAnim, layer, crossFadeFixed, normalizeTime)
	if self._mountCtrl then
		if self._mountCtrl.isMounted then
			AvatarPlayerAnimatorCtrl.super.crossFadeInFixedTime(self, currAnim, self._mountCtrl.mountLayerIndex, crossFadeFixed, 0)

			if self._mountCtrl.mount:getGameObject() then
				self._mountCtrl.mount.animatorCtrl:crossFadeInFixedTime(currAnim, 0, crossFadeFixed, 0)
			end
		end
	else
		if self:isPlaying(currAnim, layer) then
			return
		end

		self._currAnim = currAnim

		local anims = self:getCurAnimators()

		for i = 1, #anims do
			anims[i]:CrossFadeInFixedTime(currAnim, crossFadeFixed or 0, layer or 0, normalizeTime or 0)
		end

		if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
		else
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
		end
	end
end

function AvatarPlayerAnimatorCtrl:setBool(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	if self._mountCtrl and self._mountCtrl.mount and self._mountCtrl.isMounted and self._mountCtrl.mount:getGameObject() then
		self._mountCtrl.mount.animatorCtrl:setBool(id, val)
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		anims[i]:SetBool(id, val)
	end

	if id == AnimatorHash.animWalk then
		if val then
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
		else
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
		end
	elseif val then
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
	end

	self:_cacheParam(AnimatorParamsType.Bool, id, val)
end

function AvatarPlayerAnimatorCtrl:setInteger(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		anims[i]:SetInteger(id, val)
	end

	if self._mountCtrl and self._mountCtrl.mount and self._mountCtrl.isMounted and self._mountCtrl.mount:getGameObject() then
		self._mountCtrl.mount.animatorCtrl:setInteger(id, val)
	end
end

function AvatarPlayerAnimatorCtrl:setFloat(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims - 1 do
		anims[i]:SetFloat(id, val)
	end

	if self._mountCtrl and self._mountCtrl.mount and self._mountCtrl.isMounted and self._mountCtrl.mount:getGameObject() then
		self._mountCtrl.mount.animatorCtrl:setFloat(id, val)
	end
end

function AvatarPlayerAnimatorCtrl:setTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		anims[i]:SetTrigger(id)
	end

	if self._mountCtrl and self._mountCtrl.mount and self._mountCtrl.isMounted and self._mountCtrl.mount:getGameObject() then
		self._mountCtrl.mount.animatorCtrl:setTrigger(id, val)
	end
end

function AvatarPlayerAnimatorCtrl:resetTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		anims[i]:ResetTrigger(id)
	end
end

function AvatarPlayerAnimatorCtrl:setLayerWeight(idx, weight)
	local anims = self:getCurAnimators()

	if anims then
		for i = 1, #anims do
			anims[i]:SetLayerWeight(idx, weight)
		end
	end
end

function AvatarPlayerAnimatorCtrl:parseParams()
	if self._params then
		return
	end

	if not self:_isAnimatorValid() then
		return
	end

	local anims = self:getCurAnimators()

	for i = 1, #anims do
		-- block empty
	end

	local prams = self._animator.parameters
	local len = prams.Length - 1

	for i = 0, len do
		self._params = self._params or {}
		self._params[prams[i].nameHash] = prams[i]
	end
end

return AvatarPlayerAnimatorCtrl
