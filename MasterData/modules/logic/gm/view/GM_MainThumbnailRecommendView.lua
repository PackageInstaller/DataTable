-- chunkname: @modules/logic/gm/view/GM_MainThumbnailRecommendView.lua

module("modules.logic.gm.view.GM_MainThumbnailRecommendView", package.seeall)

local GM_MainThumbnailRecommendView = class("GM_MainThumbnailRecommendView", BaseView)

function GM_MainThumbnailRecommendView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
	self._item3Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item3/Toggle")
end

function GM_MainThumbnailRecommendView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
	self._item3Toggle:AddOnValueChanged(self._onItem3ToggleValueChanged, self)
end

function GM_MainThumbnailRecommendView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
	self._item3Toggle:RemoveOnValueChanged()
end

function GM_MainThumbnailRecommendView:onOpen()
	self:_refreshItem1()
	self:_refreshItem2()
	self:_refreshItem3()
end

function GM_MainThumbnailRecommendView:onDestroyView()
	return
end

GM_MainThumbnailRecommendView.s_ShowAllBanner = false

function GM_MainThumbnailRecommendView:_refreshItem1()
	self._item1Toggle.isOn = GM_MainThumbnailRecommendView.s_ShowAllBanner
end

function GM_MainThumbnailRecommendView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_MainThumbnailRecommendView.s_ShowAllBanner = isOn

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, isOn)
end

GM_MainThumbnailRecommendView.s_ShowAllTabId = false

function GM_MainThumbnailRecommendView:_refreshItem2()
	self._item2Toggle.isOn = GM_MainThumbnailRecommendView.s_ShowAllTabId
end

function GM_MainThumbnailRecommendView:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn

	GM_MainThumbnailRecommendView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, isOn)
end

GM_MainThumbnailRecommendView.s_StopBannerLoopAnim = false

function GM_MainThumbnailRecommendView:_refreshItem3()
	self._item3Toggle.isOn = GM_MainThumbnailRecommendView.s_StopBannerLoopAnim
end

function GM_MainThumbnailRecommendView:_onItem3ToggleValueChanged()
	local isOn = self._item3Toggle.isOn

	GM_MainThumbnailRecommendView.s_StopBannerLoopAnim = isOn

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, isOn)
end

return GM_MainThumbnailRecommendView
