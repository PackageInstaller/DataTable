-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatResultViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultViewContainer", package.seeall)

local VersionActivity2_4MusicBeatResultViewContainer = class("VersionActivity2_4MusicBeatResultViewContainer", BaseViewContainer)

function VersionActivity2_4MusicBeatResultViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicBeatResultView.New())

	return views
end

return VersionActivity2_4MusicBeatResultViewContainer
