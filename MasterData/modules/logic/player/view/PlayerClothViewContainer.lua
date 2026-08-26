-- chunkname: @modules/logic/player/view/PlayerClothViewContainer.lua

module("modules.logic.player.view.PlayerClothViewContainer", package.seeall)

local PlayerClothViewContainer = class("PlayerClothViewContainer", BaseViewContainer)

function PlayerClothViewContainer:buildViews()
	local listParam = ListScrollParam.New()

	listParam.scrollGOPath = "#scroll_skills"
	listParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listParam.prefabUrl = "#scroll_skills/Viewport/#go_skillitem"
	listParam.cellClass = PlayerClothItem
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.lineCount = 1
	listParam.cellWidth = 300
	listParam.cellHeight = 155
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = -4.34
	listParam.startSpace = 0
	self._clothListView = LuaListScrollView.New(PlayerClothListViewModel.instance, listParam)

	return {
		PlayerClothView.New(),
		self._clothListView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function PlayerClothViewContainer:buildTabViews(tabContainerId)
	if self.viewParam then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			not self.viewParam
		}, HelpEnum.HelpId.PlayCloth)

		return {
			self.navigateView
		}
	end
end

function PlayerClothViewContainer:onContainerInit()
	PlayerClothListViewModel.instance:update()
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, self._onSelectCloth, self)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self.navigateView.showHelpBtnIcon, self.navigateView)
end

function PlayerClothViewContainer:onContainerDestroy()
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, self._onSelectCloth, self)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self.navigateView.showHelpBtnIcon, self.navigateView)
end

function PlayerClothViewContainer:onContainerOpen()
	PlayerClothListViewModel.instance:update()
end

function PlayerClothViewContainer:_onSelectCloth(clothId)
	local mo = PlayerClothListViewModel.instance:getById(clothId)

	if mo then
		local index = PlayerClothListViewModel.instance:getIndex(mo)

		if index then
			self._index = index

			self._clothListView:selectCell(index, true)
		end
	end
end

return PlayerClothViewContainer
