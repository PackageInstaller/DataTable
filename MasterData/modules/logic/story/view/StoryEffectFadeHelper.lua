-- chunkname: @modules/logic/story/view/StoryEffectFadeHelper.lua

module("modules.logic.story.view.StoryEffectFadeHelper", package.seeall)

local StoryEffectFadeHelper = class("StoryEffectFadeHelper")

function StoryEffectFadeHelper:init(go)
	self._go = go
	self._initRenderAlphas = {}
	self._renderGos = {}

	local particles = self._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, particles.Length - 1 do
		local name = particles[i].gameObject.name

		if not string.nilorempty(name) then
			table.insert(self._renderGos, particles[i].gameObject)
		end
	end

	local meshs = self._go.transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for i = 0, meshs.Length - 1 do
		local name = meshs[i].gameObject.name

		if not string.nilorempty(name) then
			table.insert(self._renderGos, meshs[i].gameObject)
		end
	end

	for _, go in ipairs(self._renderGos) do
		local renderer = go:GetComponent(typeof(UnityEngine.Renderer))

		if renderer then
			local sharedMaterials = renderer.sharedMaterials

			for j = 0, sharedMaterials.Length - 1 do
				local material = sharedMaterials[j]

				if not gohelper.isNil(material) and material:HasProperty("_MainColor") then
					local mainColor = material:GetColor("_MainColor")

					self._initRenderAlphas[go.name .. "_" .. material.name] = {
						mainColor.r,
						mainColor.g,
						mainColor.b,
						mainColor.a
					}
				end
			end
		end
	end
end

function StoryEffectFadeHelper:setTransparency(value)
	for _, go in ipairs(self._renderGos) do
		local renderer = go:GetComponent(typeof(UnityEngine.Renderer))

		if renderer then
			local sharedMaterials = renderer.sharedMaterials

			for j = 0, sharedMaterials.Length - 1 do
				local material = sharedMaterials[j]

				if not gohelper.isNil(material) and material:HasProperty("_MainColor") and self._initRenderAlphas[go.name .. "_" .. material.name] then
					local mainColor = material:GetColor("_MainColor")

					mainColor.a = value * self._initRenderAlphas[go.name .. "_" .. material.name][4]

					material:SetColor("_MainColor", mainColor)
				end
			end
		end
	end
end

function StoryEffectFadeHelper:setEffectLoop(isLoop)
	local particles = self._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, particles.Length - 1 do
		local main = particles[i].main

		main.loop = isLoop
	end
end

function StoryEffectFadeHelper:destroy()
	if not self._go or not self._go.transform then
		return
	end

	for _, go in ipairs(self._renderGos) do
		local renderer = go:GetComponent(typeof(UnityEngine.Renderer))

		if renderer then
			local sharedMaterials = renderer.sharedMaterials

			for j = 0, sharedMaterials.Length - 1 do
				local material = sharedMaterials[j]

				if not gohelper.isNil(material) and material:HasProperty("_MainColor") and self._initRenderAlphas[go.name .. "_" .. material.name] then
					local mainColor = material:GetColor("_MainColor")

					mainColor.a = self._initRenderAlphas[go.name .. "_" .. material.name][4]

					material:SetColor("_MainColor", mainColor)
				end
			end
		end
	end

	self._initRenderAlphas = nil
	self._renderGos = nil
end

return StoryEffectFadeHelper
