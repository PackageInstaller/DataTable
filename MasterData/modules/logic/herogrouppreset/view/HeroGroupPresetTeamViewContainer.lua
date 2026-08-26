-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTeamViewContainer.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamViewContainer", package.seeall)

local HeroGroupPresetTeamViewContainer = class("HeroGroupPresetTeamViewContainer", BaseViewContainer)

function HeroGroupPresetTeamViewContainer:buildViews()
	local views = {}

	table.insert(views, HeroGroupPresetTeamView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	self:_addTabList(views)
	self:_addItemList(views)

	return views
end

function HeroGroupPresetTeamViewContainer:_addTabList(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_tab"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = HeroGroupPresetTeamTabItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 482
	scrollParam.cellHeight = 171
	scrollParam.cellSpaceH = 8
	scrollParam.cellSpaceV = 0.8
	scrollParam.startSpace = -6

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(HeroGroupPresetTabListModel.instance, scrollParam, animationDelayTimes))
end

function HeroGroupPresetTeamViewContainer:_addItemList(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_group"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = HeroGroupPresetTeamItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1340
	scrollParam.cellHeight = 220
	scrollParam.cellSpaceV = 58.8
	scrollParam.startSpace = 45

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(HeroGroupPresetItemListModel.instance, scrollParam, animationDelayTimes))
end

function HeroGroupPresetTeamViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return HeroGroupPresetTeamViewContainer
