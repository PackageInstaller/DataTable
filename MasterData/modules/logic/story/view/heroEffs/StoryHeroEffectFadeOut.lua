-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffectFadeOut.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffectFadeOut", package.seeall)

local StoryHeroEffectFadeOut = class("StoryHeroEffectFadeOut")

function StoryHeroEffectFadeOut:fadeOut(fadeOutGo, time)
	if gohelper.isNil(fadeOutGo) then
		return
	end

	time = time or 1

	local anims = fadeOutGo:GetComponentsInChildren(typeof(UnityEngine.Animator))

	for i = 0, anims.Length - 1 do
		local anim = anims[i]

		if anim and anim.gameObject ~= fadeOutGo then
			anim.enabled = false
		end
	end

	self._renderList = {}

	local particles = fadeOutGo:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))
	local renderType = typeof(UnityEngine.Renderer)

	for i = 0, particles.Length - 1 do
		local go = particles[i].gameObject
		local renderer = go:GetComponent(renderType)

		if renderer then
			renderer:SetPropertyBlock(nil)
			table.insert(self._renderList, renderer)
		end
	end

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, time, self.setTransparency, self._fadeOutFinished, self, nil, EaseType.Linear)
end

function StoryHeroEffectFadeOut:_fadeOutFinished()
	self:setTransparency(0)
end

function StoryHeroEffectFadeOut:setTransparency(value)
	if not self._renderList then
		return
	end

	for _, renderer in ipairs(self._renderList) do
		if not gohelper.isNil(renderer) then
			local materials = renderer.materials

			for j = 0, materials.Length - 1 do
				local material = materials[j]

				if not gohelper.isNil(material) and material:HasProperty("_MainColor") then
					local mainColor = material:GetColor("_MainColor")

					mainColor.a = value

					material:SetColor("_MainColor", mainColor)
				end
			end
		end
	end
end

function StoryHeroEffectFadeOut:destroy()
	return
end

return StoryHeroEffectFadeOut
