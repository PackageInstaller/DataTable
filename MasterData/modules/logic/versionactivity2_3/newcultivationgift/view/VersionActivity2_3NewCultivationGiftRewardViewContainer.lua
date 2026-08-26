-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftRewardViewContainer.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftRewardViewContainer", package.seeall)

local VersionActivity2_3NewCultivationGiftRewardViewContainer = class("VersionActivity2_3NewCultivationGiftRewardViewContainer", BaseViewContainer)

function VersionActivity2_3NewCultivationGiftRewardViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_reward/viewport/content/#go_rewarditem"
	scrollParam.cellClass = VersionActivity2_3NewCultivationRewardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 250
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 20
	scrollParam.endSpace = 10
	scrollParam.minUpdateCountInFrame = 100

	local views = {}

	table.insert(views, VersionActivity2_3NewCultivationGiftRewardView.New())
	table.insert(views, LuaListScrollView.New(VersionActivity2_3NewCultivationGiftRewardListModel.instance, scrollParam))

	return views
end

return VersionActivity2_3NewCultivationGiftRewardViewContainer
