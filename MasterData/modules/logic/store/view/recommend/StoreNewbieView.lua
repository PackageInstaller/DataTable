-- chunkname: @modules/logic/store/view/recommend/StoreNewbieView.lua

module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

local StoreNewbieView = class("StoreNewbieView", StoreRecommendBaseSubView)

function StoreNewbieView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreNewbieView:addEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function StoreNewbieView:removeEvents()
	self._btn:RemoveClickListener()
end

function StoreNewbieView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local gotmp = gohelper.findChild(self.viewGO, "recommend")

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(gotmp)
	self._btn = gohelper.getClickWithAudio(self.viewGO)
end

function StoreNewbieView:onUpdateParam()
	return
end

function StoreNewbieView:_onClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function StoreNewbieView:onDestroyView()
	return
end

return StoreNewbieView
