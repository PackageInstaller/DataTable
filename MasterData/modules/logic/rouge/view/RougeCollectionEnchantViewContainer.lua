-- chunkname: @modules/logic/rouge/view/RougeCollectionEnchantViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionEnchantViewContainer", package.seeall)

local RougeCollectionEnchantViewContainer = class("RougeCollectionEnchantViewContainer", BaseViewContainer)

function RougeCollectionEnchantViewContainer:buildViews()
	local enchantScrollParam = ListScrollParam.New()

	enchantScrollParam.scrollGOPath = "right/#scroll_enchants"
	enchantScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	enchantScrollParam.prefabUrl = "right/#scroll_enchants/Viewport/Content/#go_enchantitem"
	enchantScrollParam.cellClass = RougeCollectionEnchantListItem
	enchantScrollParam.scrollDir = ScrollEnum.ScrollDirV
	enchantScrollParam.lineCount = 3
	enchantScrollParam.cellWidth = 186
	enchantScrollParam.cellHeight = 186
	enchantScrollParam.cellSpaceH = 0
	enchantScrollParam.cellSpaceV = 0
	enchantScrollParam.startSpace = 9
	enchantScrollParam.endSpace = 0
	self._enchantScrollView = LuaListScrollView.New(RougeCollectionEnchantListModel.instance, enchantScrollParam)

	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionEnchantView.New(),
		self._enchantScrollView
	}
end

function RougeCollectionEnchantViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeCollectionEnchantViewContainer
