-- chunkname: @modules/logic/explore/map/scene/ExploreMapClipObj.lua

module("modules.logic.explore.map.scene.ExploreMapClipObj", package.seeall)

local ExploreMapClipObj = class("ExploreMapClipObj", UserDataDispose)
local OcclusionThresholdId = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")
local toValue = 0.7
local time = 0.6

function ExploreMapClipObj:init(trans)
	self:__onInit()

	self._trans = trans
	self._renderers = trans:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)
	self._isClip = false
	self._isNowClip = false
	self._nowClipValue = nil
end

function ExploreMapClipObj:markClip(isClip)
	self._isClip = isClip
end

function ExploreMapClipObj:checkNow()
	if self._isClip ~= self._isNowClip then
		self._isNowClip = self._isClip

		if self._isClip then
			self:beginClip()
		else
			self:endClip()
		end
	end
end

function ExploreMapClipObj:beginClip()
	if not self._shareMats then
		self._shareMats = self:getUserDataTb_()
		self._matInsts = self:getUserDataTb_()

		for i = 0, self._renderers.Length - 1 do
			self._shareMats[i] = self._renderers[i].sharedMaterial
			self._matInsts[i] = self._renderers[i].material

			self._matInsts[i]:EnableKeyword("_OCCLUSION_CLIP")
			self._matInsts[i]:SetFloat(OcclusionThresholdId, 0)
		end
	end

	for i = 0, self._renderers.Length - 1 do
		local renderer = self._renderers[i]

		if not tolua.isnull(renderer) then
			renderer.material = self._matInsts[i]
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowClipValue or 0, toValue, time, self.onTween, self.onTweenEnd, self, nil, EaseType.Linear)
end

function ExploreMapClipObj:onTween(value)
	self._nowClipValue = value

	for i = 0, #self._matInsts do
		self._matInsts[i]:SetFloat(OcclusionThresholdId, value)
	end
end

function ExploreMapClipObj:onTweenEnd()
	self._tweenId = nil

	if not self._isNowClip then
		for i = 0, self._renderers.Length - 1 do
			local renderer = self._renderers[i]

			if not tolua.isnull(renderer) then
				renderer.material = self._shareMats[i]
			end
		end
	end
end

function ExploreMapClipObj:endClip()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowClipValue or toValue, 0, time, self.onTween, self.onTweenEnd, self, nil, EaseType.Linear)
end

function ExploreMapClipObj:clear()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._trans = nil
	self._renderers = nil
	self._mats = nil
	self._isClip = false
	self._isNowClip = false

	self:__onDispose()
end

return ExploreMapClipObj
