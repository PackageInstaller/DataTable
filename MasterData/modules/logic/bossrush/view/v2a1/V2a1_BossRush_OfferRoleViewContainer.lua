-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_OfferRoleViewContainer.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleViewContainer", package.seeall)

local V2a1_BossRush_OfferRoleViewContainer = class("V2a1_BossRush_OfferRoleViewContainer", BaseViewContainer)

function V2a1_BossRush_OfferRoleViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Left/#scroll_Char"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V2a1_BossRush_OfferRoleItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 225
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 20

	local scrollView = LuaListScrollView.New(BossRushEnhanceRoleViewListModel.instance, scrollParam)

	return {
		scrollView,
		V2a1_BossRush_OfferRoleView.New()
	}
end

return V2a1_BossRush_OfferRoleViewContainer
