-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryEyeViewContainer.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEyeViewContainer", package.seeall)

local VersionActivity2_8BossStoryEyeViewContainer = class("VersionActivity2_8BossStoryEyeViewContainer", BaseViewContainer)

function VersionActivity2_8BossStoryEyeViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_8BossStoryEyeView.New())

	return views
end

return VersionActivity2_8BossStoryEyeViewContainer
