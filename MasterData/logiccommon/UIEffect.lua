-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/UIEffect.lua

module("logiccommon.common.effect.UIEffect", package.seeall)

local UIEffect = class("UIEffect", GameEffect)

function UIEffect:ctor()
	UIEffect.super.ctor(self)

	self.view = nil
	self.hideEffWhileNotOnTop = true
	self.widget = nil
	self.ofsX = 0
	self.ofsY = 0
	self.scrollRect = nil
	self.customSortingLayer = nil
	self._isTop = true
	self.modifySortingOrder = true
	self.autoStopOnViewClose = true
end

function UIEffect:setTop(isTop)
	self._isTop = isTop

	if not goutil.isNil(self.effGo) then
		if isTop then
			if self.hideEffWhileNotOnTop then
				self:setVisible(true)
			end
		elseif self.hideEffWhileNotOnTop then
			self:setVisible(false)
		end
	end
end

function UIEffect:setVisible(visible, force)
	if self._visible == visible and not force then
		return
	end

	self._visible = visible

	if not goutil.isNil(self.effGo) then
		if visible and not UIEffectManager.instance:isVisible() then
			visible = false
		end

		GoUtil.SetVisible(self.effGo, visible)
	end
end

function UIEffect:setBelow()
	self._isBelow = true
end

function UIEffect:updateSortingOrder()
	if not self.modifySortingOrder then
		return
	end

	if not goutil.isNil(self.effGo) then
		if not self.customSortingLayer then
			if self.sortingOrder then
				if not self._isBelow then
					GoUtil.SetSortingOrder(self.effGo, self.sortingOrder + 1)
				else
					GoUtil.SetSortingOrder(self.effGo, self.sortingOrder - 20)
				end
			end
		else
			GoUtil.SetSortingOrder(self.effGo, self.customSortingLayer)
		end
	end
end

function UIEffect:setSortingOrder(customSortingLayer)
	self.customSortingLayer = customSortingLayer

	if not goutil.isNil(self.effGo) then
		GoUtil.SetSortingOrder(self.effGo, self.customSortingLayer)
	end
end

function UIEffect:setOffset(ofsX, ofsY)
	self.ofsX = ofsX or 0
	self.ofsY = ofsY or 0

	if not goutil.isNil(self.effGo) then
		UIEffectManager.instance:updateEffectPosition(self)
	end
end

function UIEffect:onEffectStart()
	UIEffectManager.instance:updateEffectPosition(self)
	UIEffect.super.onEffectStart(self)

	if self._isTop and self.view and self.hideEffWhileNotOnTop then
		self._isTop = GlobalModel.instance:isTopView(self.view._viewPresentor)
	end

	self:setTop(self._isTop)
	self:updateSortingOrder()
end

function UIEffect:setScrollRectClipping(scrollRect, viewSizeDeltaW, viewSizeDeltaH)
	if scrollRect then
		local mask = ParticleMask.Get(self.effGo)

		mask.viewSizeDeltaW = viewSizeDeltaW or 0
		mask.viewSizeDeltaH = viewSizeDeltaH or 0

		mask:SetScrollRect(scrollRect)
	end
end

function UIEffect:setClipping(clipRect, viewSizeDeltaW, viewSizeDeltaH)
	if clipRect then
		local mask = ParticleMask.Get(self.effGo)

		mask.viewSizeDeltaW = viewSizeDeltaW or 0
		mask.viewSizeDeltaH = viewSizeDeltaH or 0

		mask:SetMask(clipRect)
	end
end

local corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)

function UIEffect.GetWorldRect(rt)
	rt:GetWorldCorners(corners)

	local bottomLeft = corners[0]
	local topRight = corners[2]

	return bottomLeft, topRight
end

function UIEffect.GetIntersection(x1, y1, x2, y2, x3, y3, x4, y4)
	local xMin = Mathf.Max(x1, x3)
	local xMax = Mathf.Min(x2, x4)
	local yMin = Mathf.Max(y1, y3)
	local yMax = Mathf.Min(y2, y4)

	if xMin <= xMax and yMin <= yMax then
		return xMin, yMin, xMax, yMax
	else
		return 0, 0, 0, 0
	end
end

function UIEffect:update(deltaTime)
	UIEffect.super.update(self, deltaTime)

	if self:_checkIfChange() then
		self:_updateScrollRect()
	end
end

function UIEffect:_checkIfChange()
	if self._parentSVs then
		local parentSVs = self._parentSVs

		if not goutil.isNil(parentSVs) and parentSVs.Length >= 2 then
			local boo = false

			for i = 0, parentSVs.Length - 1 do
				local rt = parentSVs[i].viewport.gameObject.transform
				local x, y, z = Framework.TransformUtil.GetPos(rt, 0, 0, 0)
				local obj = self._SVsPosMap[i]

				if obj == nil or obj.x ~= x or obj.y ~= y or obj.z ~= z then
					obj = obj or {}
					obj.x = x
					obj.y = y
					obj.z = z
					self._SVsPosMap[i] = obj
					boo = true
				end
			end

			return boo
		end
	end

	return false
end

local v4dIdx = 1
local vector4List = {}

function UIEffect:_updateScrollRect()
	if self._parentSVs then
		local parentSVs = self._parentSVs

		if not goutil.isNil(parentSVs) and parentSVs.Length >= 2 then
			local rt = parentSVs[0].viewport.gameObject.transform
			local bottomLeft1, topRight1 = UIEffect.GetWorldRect(rt)
			local xMin, yMin, xMax, yMax = bottomLeft1.x, bottomLeft1.y, topRight1.x, topRight1.y

			for i = 1, parentSVs.Length - 1 do
				local rt2 = parentSVs[i].viewport.gameObject.transform
				local bottomLeft2, topRight2 = UIEffect.GetWorldRect(rt2)

				xMin, yMin, xMax, yMax = UIEffect:GetIntersection(yMin, xMax, yMax, bottomLeft2.x, bottomLeft2.y, topRight2.x, topRight2.y)
			end

			local vct4 = Vector4.New(xMin, yMin, xMax, yMax)

			vector4List[v4dIdx] = vct4

			self:setClipRect(vct4)
		end
	end
end

function UIEffect:setClipRect(clipRect, viewSizeDeltaW, viewSizeDeltaH)
	if clipRect then
		local mask = ParticleMask.Get(self.effGo)

		mask.viewSizeDeltaW = viewSizeDeltaW or 0
		mask.viewSizeDeltaH = viewSizeDeltaH or 0

		mask:SetClipRect(clipRect)
	end
end

function UIEffect:setMultiScrollRect(boo)
	self._isMultiScrollRect = boo

	self:_tryCreateparentSVs()
end

function UIEffect:_tryCreateparentSVs()
	if self.effGo and self._isMultiScrollRect then
		local parentSVs = self.effGo:GetComponentsInParent(typeof(UnityEngine.UI.ScrollRect), true)

		self._parentSVs = parentSVs
		self._SVsPosMap = {}

		for i = 0, parentSVs.Length - 1 do
			local rt = parentSVs[i].viewport.gameObject.transform
			local x, y, z = Framework.TransformUtil.GetPos(rt, 0, 0, 0)
			local obj = {}

			obj.x = x
			obj.y = y
			obj.z = z
			self._SVsPosMap[i] = obj
		end

		self:_updateScrollRect()
	end
end

function UIEffect:getEffectTime()
	if self.specifyTime and self.specifyTime > 0 then
		return self.specifyTime
	end
end

function UIEffect:_onEffectPlayFinish()
	if self.finishHandler then
		self.finishHandler(self.finishHandlerTarget, self)
	end

	if self.autoDestroy then
		UIEffectManager.instance:stopEffect(self)
	end
end

function UIEffect:setEffectGo(go)
	self.effGo = go

	self:_tryCreateparentSVs()
end

function UIEffect:onEffectDestroy()
	self.sortingOrder = nil
	self.sortingOrderGreatZero = nil

	if self.isPause and self.effGo then
		GoUtil.ResumeObject(self.effGo)

		self.isPause = nil
	end

	self._isMultiScrollRect = nil
	self._parentSVs = nil
end

return UIEffect
