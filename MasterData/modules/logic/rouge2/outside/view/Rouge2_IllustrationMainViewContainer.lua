-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationMainViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationMainViewContainer", package.seeall)

local Rouge2_IllustrationMainViewContainer = class("Rouge2_IllustrationMainViewContainer", BaseViewContainer)

function Rouge2_IllustrationMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_IllustrationMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(2, "#go_content"))

	return views
end

function Rouge2_IllustrationMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local illustrationView = {}
		local illustrationScrollParam = MixScrollParam.New()

		illustrationScrollParam.scrollGOPath = "#scroll_view"
		illustrationScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		illustrationScrollParam.prefabUrl = self._viewSetting.otherRes[1]
		illustrationScrollParam.cellClass = Rouge2_IllustrationListPage
		illustrationScrollParam.scrollDir = ScrollEnum.ScrollDirH
		illustrationScrollParam.lineCount = 1
		illustrationScrollParam.cellSpaceH = 0
		illustrationScrollParam.cellSpaceV = 0
		illustrationScrollParam.startSpace = 0
		illustrationScrollParam.endSpace = 120

		table.insert(illustrationView, LuaMixScrollView.New(Rouge2_IllustrationListModel.instance, illustrationScrollParam))
		table.insert(illustrationView, Rouge2_IllustrationListView.New())
		table.insert(illustrationView, Rouge2_ScrollAudioView.New())

		local reviewView = {}

		table.insert(reviewView, Rouge2_ReviewView.New())
		table.insert(reviewView, Rouge2_ScrollAudioView.New())

		return {
			MultiView.New(illustrationView),
			MultiView.New(reviewView)
		}
	end
end

function Rouge2_IllustrationMainViewContainer:selectTabView(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

return Rouge2_IllustrationMainViewContainer
