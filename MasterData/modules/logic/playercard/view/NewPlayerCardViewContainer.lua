-- chunkname: @modules/logic/playercard/view/NewPlayerCardViewContainer.lua

module("modules.logic.playercard.view.NewPlayerCardViewContainer", package.seeall)

local NewPlayerCardViewContainer = class("NewPlayerCardViewContainer", BaseViewContainer)

function NewPlayerCardViewContainer:buildViews()
	local views = {}

	self.playercardview = NewPlayerCardView.New()

	table.insert(views, self.playercardview)
	table.insert(views, PlayerCardAchievement.New())
	table.insert(views, PlayerCardThemeView.New())
	table.insert(views, PlayerCardPlayerInfo.New())
	self:buildThemeScrollView(views)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function NewPlayerCardViewContainer:buildTabViews(tabContainerId)
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

function NewPlayerCardViewContainer:buildThemeScrollView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "bottom/#scroll_theme"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "bottom/#scroll_theme/viewport/Content/#go_themeitem"
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

function NewPlayerCardViewContainer:_overrideClose()
	local isopen = PlayerCardModel.instance:getIsOpenSkinView()

	if not isopen then
		self:closeThis()
	else
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBottomView)
	end
end

return NewPlayerCardViewContainer
