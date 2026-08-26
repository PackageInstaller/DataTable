-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryLoadingViewContainer.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryLoadingViewContainer", package.seeall)

local VersionActivity2_8BossStoryLoadingViewContainer = class("VersionActivity2_8BossStoryLoadingViewContainer", BaseViewContainer)

function VersionActivity2_8BossStoryLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_8BossStoryLoadingView.New())

	return views
end

return VersionActivity2_8BossStoryLoadingViewContainer
