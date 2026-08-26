-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeAccompanyViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyViewContainer", package.seeall)

local VersionActivity2_4MusicFreeAccompanyViewContainer = class("VersionActivity2_4MusicFreeAccompanyViewContainer", BaseViewContainer)

function VersionActivity2_4MusicFreeAccompanyViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicFreeAccompanyView.New())

	return views
end

return VersionActivity2_4MusicFreeAccompanyViewContainer
