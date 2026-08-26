-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeImmerseViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeImmerseViewContainer", package.seeall)

local VersionActivity2_4MusicFreeImmerseViewContainer = class("VersionActivity2_4MusicFreeImmerseViewContainer", BaseViewContainer)

function VersionActivity2_4MusicFreeImmerseViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicFreeImmerseView.New())

	return views
end

return VersionActivity2_4MusicFreeImmerseViewContainer
