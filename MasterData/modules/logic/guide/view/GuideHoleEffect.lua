-- chunkname: @modules/logic/guide/view/GuideHoleEffect.lua

module("modules.logic.guide.view.GuideHoleEffect", package.seeall)

local GuideHoleEffect = class("GuideHoleEffect", LuaCompBase)

function GuideHoleEffect:ctor()
	self.showMask = false
end

function GuideHoleEffect:init(go)
	self.go = go
	self._transform = go.transform
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))

	if self._animator then
		self._animator.enabled = false
	end

	self._childList = self:getUserDataTb_()

	local transform = go.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		table.insert(self._childList, child)
	end
end

function GuideHoleEffect:setSize(width, height, isStepEditor)
	if self._width == width and self._height == height then
		return
	end

	self:setVisible(true)
	self:_playEffect(isStepEditor)

	self._width = width
	self._height = height

	for i, v in ipairs(self._childList) do
		recthelper.setSize(v, width, height)
	end
end

function GuideHoleEffect:_playEffect(isStepEditor)
	TaskDispatcher.cancelTask(self._playLoop, self)

	if not self.showMask or isStepEditor then
		self:_playLoop()
	else
		if not self._animator then
			return
		end

		self._animator.enabled = true

		self._animator:Play("edge_once")
	end
end

function GuideHoleEffect:_playLoop()
	if not self._animator then
		return
	end

	self._animator.enabled = true

	self._animator:Play("edge_loop")
end

function GuideHoleEffect:setVisible(value)
	if not value then
		self._width = nil
		self._height = nil
	end

	gohelper.setActive(self.go, value)
end

function GuideHoleEffect:addToParent(parentGO)
	gohelper.addChild(parentGO, self.go)
	gohelper.setAsFirstSibling(self.go)
	recthelper.setAnchor(self._transform, 0, 0)
end

function GuideHoleEffect:addEventListeners()
	return
end

function GuideHoleEffect:removeEventListeners()
	return
end

function GuideHoleEffect:onStart()
	return
end

function GuideHoleEffect:onDestroy()
	TaskDispatcher.cancelTask(self._playLoop, self)
end

return GuideHoleEffect
