-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsDissolve.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsDissolve", package.seeall)

local StoryHeroEffsDissolve = class("StoryHeroEffsDissolve", StoryHeroEffsBase)

function StoryHeroEffsDissolve:ctor()
	StoryHeroEffsDissolve.super.ctor(self)
end

function StoryHeroEffsDissolve:init(go)
	StoryHeroEffsDissolve.super.init(self)

	self._heroGo = go
end

function StoryHeroEffsDissolve:start(inTime)
	StoryHeroEffsDissolve.super.start(self)

	self._inTime = inTime and tonumber(inTime)

	self:loadRes()
end

function StoryHeroEffsDissolve:onLoadFinished()
	StoryHeroEffsDissolve.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local skeletonGraphic = self._heroGo:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	if not skeletonGraphic then
		return
	end

	self._mat = skeletonGraphic.material

	if not self._mat then
		return
	end

	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end

	if not self._inTime then
		local inTime = 3

		if inTime < 0.1 then
			self:_onDissolveFinished()
		else
			self._dissolveTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, inTime, self._onDissolveUpdate, self._onDissolveFinished, self)
		end
	end
end

function StoryHeroEffsDissolve:_onDissolveUpdate(value)
	self._mat:SetFloat("_DissolveThreshold", value)
end

function StoryHeroEffsDissolve:_onDissolveFinished()
	self:_onDissolveUpdate(0)

	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end
end

function StoryHeroEffsDissolve:destroy()
	StoryHeroEffsDissolve.super.destroy(self)
	self:_onDissolveUpdate(1)

	if self._dissolveTweenId then
		ZProj.TweenHelper.KillById(self._dissolveTweenId)

		self._dissolveTweenId = nil
	end
end

return StoryHeroEffsDissolve
