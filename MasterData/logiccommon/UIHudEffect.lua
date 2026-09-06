-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/UIHudEffect.lua

module("logiccommon.common.effect.UIHudEffect", package.seeall)

local UIHudEffect = class("UIHudEffect", UIScreenEffect)

function UIHudEffect:ctor()
	UIHudEffect.super.ctor(self)

	self.widget = nil
	self.keepScale = nil
end

function UIHudEffect:onEffectStart()
	UIHudEffect.super.onEffectStart(self)
	self.effGo.transform:SetParent(self.widget.transform)
	Framework.TransformUtil.SetLocalPos(self.effGo.transform, 0, 0, 0)

	if not self.keepScale and not self.scale then
		Framework.TransformUtil.SetLocalScale(self.effGo.transform, 1, 1, 1)
	end

	if self.widget.gameObject.layer ~= self.layer then
		self:setLayer(self.widget.gameObject.layer)
	end
end

function UIHudEffect:setVisible(visible)
	self._visible = visible

	if self.effGo then
		if visible and not UIEffectManager.instance:isVisible() then
			visible = false
		end

		GoUtil.SetVisible(self.effGo, visible)
	end
end

function UIHudEffect:setScrollRectClipping(scrollRect, viewSizeDeltaW, viewSizeDeltaH)
	local mask = ParticleMask.Get(self.effGo)

	mask.viewSizeDeltaW = viewSizeDeltaW or 0
	mask.viewSizeDeltaH = viewSizeDeltaH or 0

	if scrollRect then
		mask:SetScrollRect(scrollRect)
	end
end

function UIHudEffect:setClipping(clipRect, viewSizeDeltaW, viewSizeDeltaH)
	if clipRect then
		local mask = ParticleMask.Get(self.effGo)

		mask.viewSizeDeltaW = viewSizeDeltaW or 0
		mask.viewSizeDeltaH = viewSizeDeltaH or 0

		mask:SetMask(clipRect)
	end
end

function UIHudEffect:setClippingByScrollRect()
	local parentSV = self.effGo:GetComponentInParent(typeof(UnityEngine.UI.ScrollRect))

	if parentSV then
		self:setScrollRectClipping(parentSV)
	end
end

return UIHudEffect
