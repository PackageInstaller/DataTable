-- chunkname: @IQIGame\\Util\\EntityShowUtil.lua

EntityShowUtil = {
	TempColor = Color.white
}

function EntityShowUtil.SetAlpha(go, alpha)
	local graphics = go:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)
	local renderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, graphics.Length - 1 do
		local graphic = graphics[i]
		local color = graphic.color

		color.a = alpha
		graphic.color = color
	end

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		if renderer:GetType().FullName == "UnityEngine.SpriteRenderer" then
			local color = renderer.color

			color.a = alpha
			renderer.color = color
		elseif renderer.sharedMaterial ~= nil and renderer.sharedMaterial:HasProperty("_Color") then
			local materialPropertyBlock = renderer:GetPropertyBlock()
			local color = materialPropertyBlock:GetColor("_Color")

			if color.r == 0 and color.g == 0 and color.b == 0 and color.a == 0 then
				color = renderer.sharedMaterial:GetColor("_Color")
			end

			color.a = alpha

			materialPropertyBlock:SetColor("_Color", color)
			renderer:SetPropertyBlock()
		end
	end

	return graphics.Length > 0 or renderers.Length > 0
end

function EntityShowUtil.SetColor(go, color)
	local graphics = go:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)
	local renderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, graphics.Length - 1 do
		local graphic = graphics[i]

		graphic.color = color
	end

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		if renderer:GetType().FullName == "UnityEngine.SpriteRenderer" then
			renderer.color = color
		elseif renderer.sharedMaterial ~= nil and renderer.sharedMaterial:HasProperty("_Color") then
			local materialPropertyBlock = renderer:GetPropertyBlock()

			materialPropertyBlock:SetColor("_Color", color)
			renderer:SetPropertyBlock()
		end
	end

	return graphics.Length > 0 or renderers.Length > 0
end
