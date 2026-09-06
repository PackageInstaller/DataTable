-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/animator/AvatarAnimCtrl.lua

module("logiccommon.common.avatar.animator.AvatarAnimCtrl", package.seeall)

local AvatarAnimCtrl = class("AvatarAnimCtrl")
local AMParams_Type_Float = UnityEngine.AnimatorControllerParameterType.Float
local AMParams_Type_Int = UnityEngine.AnimatorControllerParameterType.Int
local AMParams_Type_Bool = UnityEngine.AnimatorControllerParameterType.Bool

function AvatarAnimCtrl:ctor()
	self._animator = nil
	self._currAnims = nil
	self._params = nil
end

function AvatarAnimCtrl:setAnimator(animator)
	self._animator = animator
	self._params = nil

	if animator then
		self:parseParams()
	end
end

function AvatarAnimCtrl:getAnimator()
	return self._animator
end

function AvatarAnimCtrl:clearAnim()
	self:setAnimator(nil)

	self._animParams = nil
	self._currAnims = nil
end

function AvatarAnimCtrl:isPlaying(currAnim, layer)
	if not self._currAnims then
		return
	end

	return self._currAnims[layer or 0] == currAnim
end

function AvatarAnimCtrl:getParams()
	return self._params
end

function AvatarAnimCtrl:resetAnimParams()
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

function AvatarAnimCtrl:playAnim(currAnim, layer, normalizeTime)
	if self:isPlaying(currAnim, layer) then
		return
	end

	self._currAnims = self._currAnims or {}
	self._currAnims[layer or 0] = currAnim

	if self._animator then
		self._animator:Play(currAnim, layer or 0, normalizeTime or 0)
	end
end

function AvatarAnimCtrl:crossFadeInFixedTime(currAnim, layer, crossFadeFixed, normalizeTime)
	if self:isPlaying(currAnim, layer) then
		return
	end

	self._currAnims = self._currAnims or {}
	self._currAnims[layer or 0] = currAnim

	if self._animator then
		self._animator:CrossFadeInFixedTime(currAnim, crossFadeFixed or 0, layer or 0, normalizeTime or 0)
	end
end

function AvatarAnimCtrl:setUpdateMode(mode)
	if not self._animator then
		return
	end

	self._animator.updateMode = mode
end

function AvatarAnimCtrl:setCullingMode(mode)
	if not self._animator then
		return
	end

	self._animator.cullingMode = mode
end

function AvatarAnimCtrl:setBool(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetBool(id, val)
end

function AvatarAnimCtrl:setInteger(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetInteger(id, val)
end

function AvatarAnimCtrl:setFloat(id, val)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetFloat(id, val)
end

function AvatarAnimCtrl:setTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:SetTrigger(id)
end

function AvatarAnimCtrl:resetTrigger(id)
	if not self:_isParamsExist(id) then
		return
	end

	self._animator:ResetTrigger(id)
end

function AvatarAnimCtrl:setLayerWeight(idx, weight)
	if not self._animator then
		return
	end

	self._animator:SetLayerWeight(idx, weight)
end

function AvatarAnimCtrl:parseParams()
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

function AvatarAnimCtrl:_isAnimatorValid()
	if not self._animator or not self._animator.isActiveAndEnabled then
		return
	end

	return true
end

function AvatarAnimCtrl:_isParamsExist(id)
	if not self:_isAnimatorValid() then
		return
	end

	if not self._params or not self._params[id] then
		return
	end

	return true
end

return AvatarAnimCtrl
