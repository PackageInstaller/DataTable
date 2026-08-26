-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyLevelRewardViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardViewContainer", package.seeall)

local OdysseyLevelRewardViewContainer = class("OdysseyLevelRewardViewContainer", BaseViewContainer)

function OdysseyLevelRewardViewContainer:buildViews()
	local views = {}

	self:buildLevelScrollViews()
	table.insert(views, OdysseyLevelRewardView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, self.scrollView)

	return views
end

function OdysseyLevelRewardViewContainer:buildTabViews(tabContainerId)
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

function OdysseyLevelRewardViewContainer:buildLevelScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Reward/#scroll_RewardList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/Reward/#scroll_RewardList/Viewport/#go_Content/#go_rewarditem"
	scrollParam.cellClass = OdysseyLevelRewardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 384
	scrollParam.cellHeight = 300
	scrollParam.cellSpaceH = 42
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 18
	scrollParam.frameUpdateMs = 100
	self.scrollView = LuaListScrollView.New(OdysseyTaskModel.instance, scrollParam)
end

return OdysseyLevelRewardViewContainer
