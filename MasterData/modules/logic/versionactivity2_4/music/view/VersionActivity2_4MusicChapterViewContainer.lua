-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicChapterViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterViewContainer", package.seeall)

local VersionActivity2_4MusicChapterViewContainer = class("VersionActivity2_4MusicChapterViewContainer", BaseViewContainer)

function VersionActivity2_4MusicChapterViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicChapterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_left"))

	return views
end

function VersionActivity2_4MusicChapterViewContainer:buildTabViews(tabContainerId)
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

return VersionActivity2_4MusicChapterViewContainer
