-- chunkname: @modules/logic/store/view/recommend/StoreRecommendBaseSubView.lua

module("modules.logic.store.view.recommend.StoreRecommendBaseSubView", package.seeall)

local StoreRecommendBaseSubView = class("StoreRecommendBaseSubView", BaseView)

function StoreRecommendBaseSubView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreRecommendBaseSubView:addEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function StoreRecommendBaseSubView:removeEvents()
	self._btn:RemoveClickListener()
end

function StoreRecommendBaseSubView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function StoreRecommendBaseSubView:onOpen()
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Open, 0, 0)
		self._animator:Update(0)
	end
end

function StoreRecommendBaseSubView:switchClose(callBack, callBackObj)
	if self._animator then
		self._animator.enabled = false
	end

	if self._animatorPlayer then
		self._animatorPlayer:Play(UIAnimationName.Close, callBack, callBackObj)
	end
end

function StoreRecommendBaseSubView:stopAnimator()
	if self._animatorPlayer then
		self._animatorPlayer:Stop()
	end

	if self._animator then
		self._animator.enabled = false
	end
end

function StoreRecommendBaseSubView:getTabIndex(id)
	if self.viewContainer and self.viewContainer.getRecommendTabIndex and (self.config or id) then
		return self.viewContainer:getRecommendTabIndex(id or self.config.id)
	end

	return 1
end

function StoreRecommendBaseSubView:onClose()
	return
end

return StoreRecommendBaseSubView
