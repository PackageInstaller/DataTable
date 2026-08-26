-- chunkname: @modules/logic/turnback/view/turnback3/TurnbackBpTabGroup.lua

module("modules.logic.turnback.view.turnback3.TurnbackBpTabGroup", package.seeall)

local TurnbackBpTabGroup = class("TurnbackBpTabGroup", TabViewGroup)

function TurnbackBpTabGroup:ctor(...)
	TurnbackBpTabGroup.super.ctor(self, ...)

	self.isInClosingTween = false
	self._tabAnims = {}
	self._closeViewIndex = nil
	self._openId = nil
end

function TurnbackBpTabGroup:_openTabView(tabId)
	if self._curTabId == tabId then
		return
	end

	TurnbackBpTabGroup.super._openTabView(self, tabId)
end

function TurnbackBpTabGroup:_setVisible(tabId, isVisible)
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

				TurnbackBpTabGroup.super._setVisible(self, tabId, false)
			end

			return
		end

		viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true

		TurnbackBpTabGroup.super._setVisible(self, tabId, true)

		if anim then
			anim:Play(UIAnimationName.Open)
		end

		self.viewContainer:dispatchEvent(TurnbackEvent.TapViewOpenAnimBegin, tabId)
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

			self.viewContainer:dispatchEvent(TurnbackEvent.TapViewCloseAnimBegin, tabId)
			anim:Play(UIAnimationName.Close, self.onCloseTweenFinish, self)
		else
			TurnbackBpTabGroup.super._setVisible(self, tabId, false)
		end
	end
end

function TurnbackBpTabGroup:onCloseTweenFinish()
	if not self._closeViewIndex then
		return
	end

	local closeIndex = self._closeViewIndex

	TurnbackBpTabGroup.super._setVisible(self, self._closeViewIndex, false)

	self._closeViewIndex = nil
	self.isInClosingTween = false

	if self._openId then
		self:_setVisible(self._openId, true)

		self._openId = nil
	end

	self.viewContainer:dispatchEvent(TurnbackEvent.TapViewCloseAnimEnd, closeIndex)
end

function TurnbackBpTabGroup:onDestroyView(...)
	self.isInClosingTween = nil
	self._tabAnims = nil
	self._closeViewIndex = nil
	self._openId = nil

	TurnbackBpTabGroup.super.onDestroyView(self, ...)
end

return TurnbackBpTabGroup
