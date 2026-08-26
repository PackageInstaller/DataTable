-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleViewContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleViewContainer", package.seeall)

local Rouge2_BossBattleViewContainer = class("Rouge2_BossBattleViewContainer", BaseViewContainer)

function Rouge2_BossBattleViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BossBattleView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Boss"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellClass = Rouge2_BossBattleListItem
	scrollParam.cellWidth = 800
	scrollParam.cellHeight = 700
	scrollParam.startSpace = 10
	scrollParam.cellSpaceH = 100
	self._scrollView = LuaMixScrollView.New(Rouge2_BossBattleListModel.instance, scrollParam)

	table.insert(views, self._scrollView)

	return views
end

function Rouge2_BossBattleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Rouge2_BossBattleViewContainer
