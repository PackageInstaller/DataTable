-- chunkname: @modules/logic/battlepass/view/BpBuyViewContainer.lua

module("modules.logic.battlepass.view.BpBuyViewContainer", package.seeall)

local BpBuyViewContainer = class("BpBuyViewContainer", BaseViewContainer)

function BpBuyViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "bg/#scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "bg/#scroll/item"
	scrollParam.cellClass = BpBuyBonusItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 146
	scrollParam.cellHeight = 146
	scrollParam.cellSpaceH = 35
	scrollParam.cellSpaceV = 33
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(BpBuyViewModel.instance, scrollParam))
	table.insert(views, BpBuyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function BpBuyViewContainer:buildTabViews()
	local buyCost = CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost)
	local currency = string.splitToNumber(buyCost, "#")[2]

	return {
		CurrencyView.New({
			currency
		})
	}
end

return BpBuyViewContainer
