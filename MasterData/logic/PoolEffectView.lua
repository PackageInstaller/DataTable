-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/PoolEffectView.lua

module("logic.extensions.warriortower.view.PoolEffectView", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local PoolEffectView = class("PoolEffectView")

function PoolEffectView.AddOnce(go)
	local component = PoolEffectView.Get(go)

	component = component or LuaComponentContainer.Add(go, PoolEffectView)

	return component
end

function PoolEffectView.Get(go)
	return (LuaComponentContainer.Get(go, PoolEffectView))
end

function PoolEffectView:ctor(target)
	self._go = target.gameObject
	self._waterImg = goutil.findChildImageComponent(self._go, "Img")
	self._effctGo = goutil.findChild(self._go, "Effect")
	self._scale = 1
	self._oriPos = GameUtil.getLocalPos(self._effctGo)
end

function PoolEffectView:OnDestroy()
	self:disableEffect()
end

function PoolEffectView:playEffect(scale)
	self._scale = scale

	if self._shuimianEffect == nil then
		self._shuimianEffect = UIEffectManager.instance:playHUDEffect("20190408/ui_shuimian.prefab", self._effctGo, true, nil, nil, function(finishHandlerTarget, eff)
			self._shuimianEffect = eff

			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(finishHandlerTarget._effctGo) + 1)
			finishHandlerTarget:setPercent(finishHandlerTarget._curPercent or 0)
		end, self, true)
	end

	if self._shuidiEffect == nil then
		self._shuidiEffect = UIEffectManager.instance:playHUDEffect("20190408/ui_shuidi.prefab", self._go, true, nil, nil, function(finishHandlerTarget, eff)
			self._shuidiEffect = eff

			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(finishHandlerTarget._effctGo) + 1)

			eff.effGo.transform.localPosition = eff.effGo.transform.localPosition + Vector3.up * finishHandlerTarget._scale / 1.8

			UIEffectManager.instance:updateEffectScale(finishHandlerTarget._shuidiEffect, finishHandlerTarget._scale, finishHandlerTarget._scale, finishHandlerTarget._scale)
		end, self, true)
	end
end

function PoolEffectView:setPercent(precent)
	self._curPercent = precent
	self._waterImg.fillAmount = precent

	local height = self._scale * precent
	local xScale = self._scale

	xScale = precent <= 0.5 and math.sqrt(precent * 4 - precent * precent * 4) * self._scale or math.sqrt((1 - precent) * 4 - (1 - precent) * (1 - precent) * 4) * self._scale

	GameUtil.setLocalPos(self._effctGo, self._oriPos.x, self._oriPos.y + height, self._oriPos.z)
	UIEffectManager.instance:updateEffectPosition(self._shuimianEffect)
	UIEffectManager.instance:updateEffectScale(self._shuimianEffect, xScale, self._scale, self._scale / 2)
end

function PoolEffectView:show(isShow)
	self._go:SetActive(isShow)
end

function PoolEffectView:disableEffect()
	if self._shuidiEffect then
		UIEffectManager.instance:stopEffect(self._shuidiEffect)
	end

	if self._shuimianEffect then
		UIEffectManager.instance:stopEffect(self._shuimianEffect)
	end

	self._shuidiEffect = nil
	self._shuimianEffect = nil
end

return PoolEffectView
