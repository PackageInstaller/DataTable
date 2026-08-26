-- chunkname: @modules/logic/partycloth/view/PartyClothViewContainer.lua

module("modules.logic.partycloth.view.PartyClothViewContainer", package.seeall)

local PartyClothViewContainer = class("PartyClothViewContainer", BaseViewContainer)

function PartyClothViewContainer:buildViews()
	local views = {}

	self:buildScrollView(views)
	table.insert(views, PartyClothView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function PartyClothViewContainer:buildTabViews(tabContainerId)
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
	end
end

function PartyClothViewContainer:overrideClose()
	PartyClothController.instance:backToLobby()
	self:closeThis()
end

function PartyClothViewContainer:buildScrollView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_UI/Right/#scroll_Suit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = PartyClothEnum.ResPath.SuitItem
	scrollParam.cellClass = PartyClothSuitItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 700
	scrollParam.cellHeight = 190
	scrollParam.cellSpaceV = -4
	scrollParam.emptyScrollParam = EmptyScrollParam.New()

	scrollParam.emptyScrollParam:setFromView("#go_UI/Right/go_Empty")
	table.insert(views, LuaListScrollView.New(PartyClothSuitListModel.instance, scrollParam))

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "#go_UI/Right/#scroll_Cloth"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = PartyClothEnum.ResPath.PartItem
	scrollParam1.cellClass = PartyClothPartItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 3
	scrollParam1.cellWidth = 230
	scrollParam1.cellHeight = 230
	scrollParam1.emptyScrollParam = EmptyScrollParam.New()

	scrollParam1.emptyScrollParam:setFromView("#go_UI/Right/go_Empty")
	table.insert(views, LuaListScrollView.New(PartyClothPartListModel.instance, scrollParam1))
end

return PartyClothViewContainer
