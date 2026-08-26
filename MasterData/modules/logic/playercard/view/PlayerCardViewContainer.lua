-- chunkname: @modules/logic/playercard/view/PlayerCardViewContainer.lua

module("modules.logic.playercard.view.PlayerCardViewContainer", package.seeall)

local PlayerCardViewContainer = class("PlayerCardViewContainer", BaseViewContainer)

function PlayerCardViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardCharacterView.New())
	table.insert(views, PlayerCardView.New())
	table.insert(views, PlayerCardThemeView.New())

	self.animatorView = PlayerCardAnimatorView.New()

	table.insert(views, self.animatorView)
	self:buildThemeScrollView(views)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function PlayerCardViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function PlayerCardViewContainer:buildThemeScrollView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Bottom/#scroll_theme"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Bottom/#scroll_theme/viewport/Content/#go_themeitem"
	scrollParam.cellClass = PlayerCardThemeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 404
	scrollParam.cellHeight = 172
	scrollParam.cellSpaceH = 16
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 4
	scrollParam.endSpace = 0
	self.scrollView = LuaListScrollView.New(PlayerCardThemeListModel.instance, scrollParam)

	table.insert(views, self.scrollView)
end

function PlayerCardViewContainer:_overrideClose()
	if self.animatorView:isInThemeView() then
		self.animatorView:closeThemeView()

		return
	end

	self:closeThis()
end

return PlayerCardViewContainer
