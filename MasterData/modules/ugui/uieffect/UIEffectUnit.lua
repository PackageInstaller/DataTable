-- chunkname: @modules/ugui/uieffect/UIEffectUnit.lua

module("modules.ugui.uieffect.UIEffectUnit", package.seeall)

local UIEffectUnit = class("UIEffectUnit", LuaCompBase)

function UIEffectUnit:Refresh(targetGo, effectPath, width, height, rawImageWidth, rawImageHeight)
	if self._rawImage == nil then
		local rawImage = gohelper.onceAddComponent(targetGo, gohelper.Type_RawImage)

		rawImage.raycastTarget = false
		self._rawImage = rawImage
	end

	local transform = targetGo.transform

	recthelper.setSize(transform, rawImageWidth or width, rawImageHeight or height)

	if self._effectPath and self._effectPath == effectPath and self._width == width and self._height == height then
		return
	end

	self:_releaseEffect()

	self._effectPath = effectPath
	self._width = width
	self._height = height

	UIEffectManager.instance:_getEffect(effectPath, width, height, self._rawImage)
end

function UIEffectUnit:onDestroy()
	self:_releaseEffect()
end

function UIEffectUnit:_releaseEffect()
	if self._effectPath then
		UIEffectManager.instance:_putEffect(self._effectPath, self._width, self._height)

		self._effectPath = nil
	end
end

return UIEffectUnit
