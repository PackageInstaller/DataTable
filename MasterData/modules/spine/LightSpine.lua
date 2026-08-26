-- chunkname: @modules/spine/LightSpine.lua

module("modules.spine.LightSpine", package.seeall)

local LightSpine = class("LightSpine", BaseSpine)

LightSpine.TypeSkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation)
LightSpine.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)

function LightSpine.Create(gameObj, isStory)
	local ret = MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, LightSpine)

	ret._isStory = isStory

	return ret
end

function LightSpine:_onResLoaded()
	self._sharedMaterials = nil
	self._retryGetSharedMats = 0

	LightSpine.super._onResLoaded(self)
end

function LightSpine:getBoundsMinMaxPos()
	local meshRenderer = self:getRenderer()
	local bounds = meshRenderer.bounds

	return bounds.min, bounds.max
end

function LightSpine:initSkeletonComponent()
	self._skeletonComponent = self._spineGo:GetComponent(LightSpine.TypeSkeletonAnimation)

	self._skeletonComponent:Initialize(false)

	self._skeletonComponent.freeze = self._bFreeze
	self._animationEvent = LightSpine.TypeSpineAnimationEvent
	self._mountroot = gohelper.findChild(self._spineGo, "mountroot")
end

function LightSpine:changeRenderQueue(value)
	return
end

function LightSpine:setStencilRef(iValue)
	if gohelper.isNil(self._spineGo) then
		return
	end

	local mats = self:getSharedMats()
	local len = mats.Length

	for i = 0, len - 1 do
		local material = mats[i]

		material:SetFloat(ShaderPropertyId.Stencil, iValue)
	end

	if self._mountroot then
		gohelper.setActive(self._mountroot, iValue == 0)
	end
end

function LightSpine:setStencilValues(ref, comp, op)
	if gohelper.isNil(self._spineGo) then
		return
	end

	local mats = self:getSharedMats()
	local len = mats.Length

	for i = 0, len - 1 do
		local material = mats[i]

		material:SetFloat(ShaderPropertyId.Stencil, ref)
		material:SetFloat(ShaderPropertyId.StencilComp, comp)
		material:SetFloat(ShaderPropertyId.StencilOp, op)
	end
end

function LightSpine:getSharedMats()
	if not self._sharedMaterials then
		local render = self:getRenderer()

		self._sharedMaterials = render.sharedMaterials
	elseif self._retryGetSharedMats and self._retryGetSharedMats <= 6 then
		self._retryGetSharedMats = self._retryGetSharedMats + 1

		local render = self:getRenderer()

		self._sharedMaterials = render.sharedMaterials

		if self._sharedMaterials.Length > 1 then
			self._retryGetSharedMats = nil
		end
	end

	return self._sharedMaterials
end

function LightSpine:setMainColor(color)
	local mats = self:getSharedMats()
	local len = mats.Length

	for i = 0, len - 1 do
		local material = mats[i]

		MaterialUtil.setMainColor(material, color)
	end
end

function LightSpine:setLumFactor(value)
	local mats = self:getSharedMats()
	local len = mats.Length

	for i = 0, len - 1 do
		local material = mats[i]

		material:SetFloat(ShaderPropertyId.LumFactor, value)
	end
end

return LightSpine
