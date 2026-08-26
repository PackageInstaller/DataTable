-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CardPackageViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CardPackageViewContainer", package.seeall)

local Season123_1_8CardPackageViewContainer = class("Season123_1_8CardPackageViewContainer", BaseViewContainer)

function Season123_1_8CardPackageViewContainer:buildViews()
	self:buildScrollViews()

	return {
		Season123_1_8CardPackageView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_1_8CardPackageViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_8CardGetViewHelp)
		navigateButtonsView:hideHelpIcon()

		return {
			navigateButtonsView
		}
	end
end

function Season123_1_8CardPackageViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_cardget/mask/#scroll_cardget"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_1_8CardPackageItem
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

return Season123_1_8CardPackageViewContainer
