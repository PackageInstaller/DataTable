-- chunkname: @modules/logic/store/view/recommend/GiftPacksView.lua

module("modules.logic.store.view.recommend.GiftPacksView", package.seeall)

local GiftPacksView = class("GiftPacksView", StoreRecommendBaseSubView)

function GiftPacksView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftPacksView:addEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function GiftPacksView:removeEvents()
	self._btn:RemoveClickListener()
end

function GiftPacksView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._btn = gohelper.findChildClickWithAudio(self.viewGO, "view/#simage_bg")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")

	self._simagebg:LoadImage(ResUrl.getStoreGiftPackBg("bg"))
end

function GiftPacksView:onUpdateParam()
	return
end

function GiftPacksView:_onClick()
	GameFacade.jumpByAdditionParam("10170")
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "713",
		[StatEnum.EventProperties.RecommendPageName] = "精选组合推荐",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
end

function GiftPacksView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return GiftPacksView
