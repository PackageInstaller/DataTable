-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_AssistViewContainer.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_AssistViewContainer", package.seeall)

local V3a9_BossRush_AssistViewContainer = class("V3a9_BossRush_AssistViewContainer", BaseViewContainer)

function V3a9_BossRush_AssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4

	local views = {}

	self.scrollView = self:instantiateListScrollView()

	table.insert(views, V3a9_BossRush_AssistView.New())
	table.insert(views, self.scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttopbtns"))

	return views
end

function V3a9_BossRush_AssistViewContainer:buildTabViews(tabContainerId)
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

function V3a9_BossRush_AssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a9_BossRush_AssistItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 296
	scrollParam.cellHeight = 636

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.03 + self.viewOpenAnimTime
	end

	return LuaListScrollViewWithAnimator.New(PickAssistListModel.instance, scrollParam, animationDelayTimes)
end

return V3a9_BossRush_AssistViewContainer
