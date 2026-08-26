-- chunkname: @modules/logic/partycloth/view/PartyClothLotteryViewContainer.lua

module("modules.logic.partycloth.view.PartyClothLotteryViewContainer", package.seeall)

local PartyClothLotteryViewContainer = class("PartyClothLotteryViewContainer", BaseViewContainer)

function PartyClothLotteryViewContainer:buildViews()
	local views = {}

	self:buildScrollView(views)
	table.insert(views, PartyClothLotteryView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function PartyClothLotteryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

function PartyClothLotteryViewContainer:overrideClose()
	PartyClothController.instance:backToLobby()
	self:closeThis()
end

function PartyClothLotteryViewContainer:buildScrollView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_Suit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = PartyClothEnum.ResPath.LotterySuitItem
	scrollParam.cellClass = PartyClothSuitItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 504
	scrollParam.cellHeight = 176
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 10

	table.insert(views, LuaListScrollView.New(PartyClothSuitListModel.instance, scrollParam))
end

return PartyClothLotteryViewContainer
