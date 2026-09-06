-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarAnimatorCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarAnimatorCtrl", package.seeall)

local AvatarAnimatorCtrl = class("AvatarAnimatorCtrl", AvatarController)
local AMParams_Type_Float = UnityEngine.AnimatorControllerParameterType.Float
local AMParams_Type_Int = UnityEngine.AnimatorControllerParameterType.Int
local AMParams_Type_Bool = UnityEngine.AnimatorControllerParameterType.Bool

function AvatarAnimatorCtrl:ctor(avatarBase)
	AvatarAnimatorCtrl.super.ctor(self, avatarBase)

	self._animator = nil
	self._currAnim = nil
	self._currAnims = nil
	self._animatorLayers = nil
	self._params = nil
	self._lastAniParam = nil
end

function AvatarAnimatorCtrl:_getControllerType()
	return AvatarControllerType.Animator
end

function AvatarAnimatorCtrl:onAvatarLoaded()
	AvatarAnimatorCtrl.super.onAvatarLoaded(self)

	local skeletonGo = self._avatar:getGameObject()
	local animator = skeletonGo:GetComponent(ComponentType.Animator)

	self:setAnimator(animator)
end

function AvatarAnimatorCtrl:onAvatarLoadedCallBack()
	AvatarAnimatorCtrl.super.onAvatarLoadedCallBack(self)
end

function AvatarAnimatorCtrl:onAvatarInvisible()
	AvatarAnimatorCtrl.super.onAvatarInvisible(self)
end

function AvatarAnimatorCtrl:onAvatarVisible()
	AvatarAnimatorCtrl.super.onAvatarVisible(self)
end

function AvatarAnimatorCtrl:onAvatarReset()
	AvatarAnimatorCtrl.super.onAvatarReset(self)
	self:setAnimator(nil)

	self._currAnims = nil
	self._params = nil
	self._currAnim = nil
	self._lastAniParam = nil
end

function AvatarAnimatorCtrl:onAvatarDestroy()
	AvatarAnimatorCtrl.super.onAvatarDestroy(self)
end

function AvatarAnimatorCtrl:getAnimator()
	return self._animator
end

function AvatarAnimatorCtrl:setAnimator(animator)
	self._animator = animator
	self._params = nil
	self._animatorLayers = nil

	if animator then
		self:parseParams()
		self:resetAniLayer()
	end
end

function AvatarAnimatorCtrl:isPlaying(currAnim, layer)
	if not self._currAnims then
		return
	end

	return self._currAnims[layer or 0] == currAnim
end

function AvatarAnimatorCtrl:getParams()
	return self._params
end

function AvatarAnimatorCtrl:resetAnimParams()
	if not self._params then
		return
	end

	for k, v in pairs(self._params) do
		if v.type == AMParams_Type_Bool then
			self:setBool(k, v.defaultBool)
		elseif v.type == AMParams_Type_Float then
			self:setFloat(k, v.defaultFloat)
		elseif v.type == AMParams_Type_Int then
			self:setInteger(k, v.defaultInt)
		end
	end
end

function AvatarAnimatorCtrl:play(currAnim)
	self._currAnim = currAnim

	self:playAnim(currAnim, 0, 0)
end

function AvatarAnimatorCtrl:playAnim(currAnim, layer, normalizeTime)
	if self:isPlaying(currAnim, layer) then
		return
	end

	self._currAnims = self._currAnims or {}
	self._currAnims[layer or 0] = currAnim

	if self._animator then
		self._animator:Play(currAnim, layer or 0, normalizeTime or 0)
	end

	if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
	else
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
	end
end

function AvatarAnimatorCtrl:crossFadeInFixedTime(currAnim, layer, crossFadeFixed, normalizeTime)
	if self:isPlaying(currAnim, layer) then
		return
	end

	self._currAnims = self._currAnims or {}
	self._currAnims[layer or 0] = currAnim

	if self._animator then
		self._animator:CrossFadeInFixedTime(currAnim, crossFadeFixed or 0, layer or 0, normalizeTime or 0)
	end

	if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
	else
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
	end
end

function AvatarAnimatorCtrl:setUpdateMode(mode)
	if not self._animator then
		return
	end

	self._animator.updateMode = mode
end

function AvatarAnimatorCtrl:setCullingMode(mode)
	if not self._animator then
		return
	end

	self._animator.cullingMode = mode
end

function AvatarAnimatorCtrl:setBool(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetBool(id, val)

	if id == AnimatorHash.animWalk then
		if val then
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.WalkOnly)
		else
			self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
		end
	elseif val then
		self._avatar:dispatch(AvatarNotify.OnAimateStateChange, AvatarFXEffType.IdleOnly)
	end
end

function AvatarAnimatorCtrl:setInteger(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetInteger(id, val)
end

function AvatarAnimatorCtrl:setFloat(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetFloat(id, val)
end

function AvatarAnimatorCtrl:setTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetTrigger(id)
end

function AvatarAnimatorCtrl:resetTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:ResetTrigger(id)
end

function AvatarAnimatorCtrl:setLayerWeight(idx, weight)
	if not self._animator then
		return
	end

	self._animator:SetLayerWeight(idx, weight)
end

function AvatarAnimatorCtrl:setLayer(idx)
	local id = checkint(idx)

	if self._animator and self._animatorLayers then
		for k, v in pairs(self._animatorLayers) do
			self:setLayerWeight(v, id == v and 1 or 0)
		end
	end
end

function AvatarAnimatorCtrl:setLayerByLayerName(layerName)
	if self._animator and self._animatorLayers then
		local id = self._animatorLayers[layerName]

		self:setLayer(id)
	end
end

function AvatarAnimatorCtrl:setLayerWeightByLayerName(layerName, weight)
	if layerName then
		::label_27_0::

		local var_27_0 = self._animator

		if self._animator then
			var_27_0 = self._animatorLayers

			if self._animatorLayers then
				local idx = self._animatorLayers[layerName]

				if idx then
					self._animator:SetLayerWeight(idx, weight)
				end
			end
		end
	end
end

function AvatarAnimatorCtrl:parseParams()
	if self._params then
		return
	end

	if not self:_isAnimatorValid() then
		return
	end

	local prams = self._animator.parameters
	local len = prams.Length - 1

	for i = 0, len do
		self._params = self._params or {}
		self._params[prams[i].nameHash] = prams[i]
	end
end

function AvatarAnimatorCtrl:resetAniLayer()
	local layerCount = self._animator.layerCount

	self._animatorLayers = {}

	for i = 0, layerCount - 1 do
		local name = self._animator:GetLayerName(i)

		self._animatorLayers[name] = i
	end
end

function AvatarAnimatorCtrl:_isAnimatorValid()
	if not self._animator or goutil.isNil(self._animator) or not self._animator.isActiveAndEnabled then
		return
	end

	return true
end

function AvatarAnimatorCtrl:_isParamsExist(id)
	if not self:_isAnimatorValid() then
		return
	end

	if not self._params or not self._params[id] then
		return
	end

	return true
end

function AvatarAnimatorCtrl:_cacheParam(type, id, val)
	local param = AnimatorParams.New()

	param.type = type
	param.id = id
	param.value = val
	self._lastAniParam = param
end

function AvatarAnimatorCtrl:replayAnim()
	if self._lastAniParam and self._lastAniParam.type == AnimatorParamsType.Bool then
		self:setBool(self._lastAniParam.id, self._lastAniParam.value)
	end

	self._lastAniParam = nil
end

return AvatarAnimatorCtrl
