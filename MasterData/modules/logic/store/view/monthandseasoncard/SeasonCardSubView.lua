-- chunkname: @modules/logic/store/view/monthandseasoncard/SeasonCardSubView.lua

module("modules.logic.store.view.monthandseasoncard.SeasonCardSubView", package.seeall)

local SeasonCardSubView = class("SeasonCardSubView", StoreSeasonCardView)

function SeasonCardSubView:_btnbuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)

	local var_1_0 = StatEnum.EventName.ClickRecommendPage
	local var_1_1 = {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store
	}

	var_1_1[StatEnum.EventProperties.RecommendPageId] = tostring((self.config or nil) and (self.config.id or ""))

	if self.config then
		var_1_1[StatEnum.EventProperties.RecommendPageName] = self.config.name or "StoreSeasonCardView"
	end

	var_1_1[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()

	StatController.instance:track(var_1_0, var_1_1)

	local goodId = StoreEnum.SeasonCardGoodsId
	local packageMo = StoreModel.instance:getGoodsMO(goodId)

	if not packageMo or packageMo:isSoldOut() then
		GameFacade.showToast(ToastEnum.SeasonCardSoldOutTip)

		return
	end

	StoreController.instance:openPackageStoreGoodsView(packageMo)
end

function SeasonCardSubView:getTabIndex(id)
	if self.viewContainer and self.viewContainer.getMonthAndSeasonTabIndex and (self.config or id) then
		return self.viewContainer:getMonthAndSeasonTabIndex(id or self.config.id)
	end

	return 1
end

return SeasonCardSubView
