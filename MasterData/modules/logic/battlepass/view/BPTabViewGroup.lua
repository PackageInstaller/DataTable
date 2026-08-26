-- chunkname: @modules/logic/battlepass/view/BPTabViewGroup.lua

module("modules.logic.battlepass.view.BPTabViewGroup", package.seeall)

local BPTabViewGroup = class("BPTabViewGroup", TabViewGroup)

function BPTabViewGroup:ctor(...)
	BPTabViewGroup.super.ctor(self, ...)

	self.isInClosingTween = false
	self._tabAnims = {}
	self._closeViewIndex = nil
	self._openId = nil
end

function BPTabViewGroup:_openTabView(tabId)
	if self._curTabId == tabId then
		return
	end

	BPTabViewGroup.super._openTabView(self, tabId)
end

function BPTabViewGroup:_setVisible(tabId, isVisible)
	local viewGO = self._tabViews[tabId].viewGO
	local anim = self._tabAnims[tabId]
	local isNew = false

	if anim == nil then
		anim = viewGO:GetComponent(typeof(UnityEngine.Animator)) and ZProj.ProjAnimatorPlayer.Get(viewGO) or false
		self._tabAnims[tabId] = anim
		isNew = true
	end

	if isVisible then
		if self.isInClosingTween then
			self._openId = tabId

			if self._closeViewIndex ~= tabId then
				if isNew then
					viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = false
				end

				BPTabViewGroup.super._setVisible(self, tabId, false)
			end

			return
		end

		viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true

		BPTabViewGroup.super._setVisible(self, tabId, true)

		if anim then
			anim:Play(UIAnimationName.Open)
		end

		self.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, tabId)
	else
		if self.isInClosingTween then
			return
		end

		if self._openId == tabId then
			self._openId = nil
		end

		if anim then
			self.isInClosingTween = true
			self._closeViewIndex = tabId

			self.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimBegin, tabId)
			anim:Play(UIAnimationName.Close, self.onCloseTweenFinish, self)
		else
			BPTabViewGroup.super._setVisible(self, tabId, false)
		end
	end
end

function BPTabViewGroup:onCloseTweenFinish()
	if not self._closeViewIndex then
		return
	end

	local closeIndex = self._closeViewIndex

	BPTabViewGroup.super._setVisible(self, self._closeViewIndex, false)

	self._closeViewIndex = nil
	self.isInClosingTween = false

	if self._openId then
		self:_setVisible(self._openId, true)

		self._openId = nil
	end

	self.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimEnd, closeIndex)
end

function BPTabViewGroup:onDestroyView(...)
	self.isInClosingTween = nil
	self._tabAnims = nil
	self._closeViewIndex = nil
	self._openId = nil

	BPTabViewGroup.super.onDestroyView(self, ...)
end

return BPTabViewGroup
