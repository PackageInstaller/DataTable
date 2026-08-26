-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsDissolveAndSoft.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsDissolveAndSoft", package.seeall)

local StoryHeroEffsDissolveAndSoft = class("StoryHeroEffsDissolveAndSoft", StoryHeroEffsBase)

function StoryHeroEffsDissolveAndSoft:ctor()
	StoryHeroEffsDissolveAndSoft.super.ctor(self)
end

function StoryHeroEffsDissolveAndSoft:init(go)
	StoryHeroEffsDissolveAndSoft.super.init(self)

	self._heroGo = go
end

function StoryHeroEffsDissolveAndSoft:start(inTime)
	StoryHeroEffsDissolveAndSoft.super.start(self)

	self._inTime = inTime and tonumber(inTime)

	self:loadRes()
end

function StoryHeroEffsDissolveAndSoft:onLoadFinished()
	StoryHeroEffsDissolveAndSoft.super.onLoadFinished(self)
	self:playEffect()
end

function StoryHeroEffsDissolveAndSoft:playEffect()
	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end

	local skeletonGraphic = self._heroGo:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	if not skeletonGraphic then
		return
	end

	if not self._mat then
		local rawMat = skeletonGraphic.material

		self._mat = UnityEngine.Object.Instantiate(rawMat)
	end

	if not self._mat then
		return
	end

	skeletonGraphic.material = self._mat

	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)

	if not self._inTime then
		local inTime = 3

		if inTime < 0.1 then
			self:_onDissolveFinished()
		else
			self._dissolveTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, inTime, self._onDissolveUpdate, self._onDissolveFinished, self)
		end
	end
end

function StoryHeroEffsDissolveAndSoft:_onDissolveUpdate(value)
	if not self._mat then
		return
	end

	local val1 = Mathf.Lerp(1, 0.04, value)

	self._mat:SetFloat("_DissolveThreshold", val1)

	local val2 = Mathf.Lerp(1, 0.4, value)

	self._mat:SetFloat("_DissolveThresholdSoft", val2)
end

function StoryHeroEffsDissolveAndSoft:_onDissolveFinished()
	self:_onDissolveUpdate(1)

	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end
end

function StoryHeroEffsDissolveAndSoft:destroy()
	StoryHeroEffsDissolveAndSoft.super.destroy(self)
	PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
	self:_onDissolveUpdate(0)

	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end
end

return StoryHeroEffsDissolveAndSoft
