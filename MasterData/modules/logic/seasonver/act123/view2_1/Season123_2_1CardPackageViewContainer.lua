-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CardPackageViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CardPackageViewContainer", package.seeall)

local Season123_2_1CardPackageViewContainer = class("Season123_2_1CardPackageViewContainer", BaseViewContainer)

function Season123_2_1CardPackageViewContainer:buildViews()
	self:buildScrollViews()

	return {
		Season123_2_1CardPackageView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_1CardPackageViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigateButtonsView:setHelpId(HelpEnum.HelpId.Season2_1CardGetViewHelp)
		navigateButtonsView:hideHelpIcon()

		return {
			navigateButtonsView
		}
	end
end

function Season123_2_1CardPackageViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_cardget/mask/#scroll_cardget"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_1CardPackageItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 204
	scrollParam.cellHeight = 290
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 50
	scrollParam.frameUpdateMs = 100

	local delayTimes = {}

	for i = 1, 15 do
		delayTimes[i] = math.ceil(i / 5) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(Season123CardPackageModel.instance, scrollParam, delayTimes)
end

return Season123_2_1CardPackageViewContainer
