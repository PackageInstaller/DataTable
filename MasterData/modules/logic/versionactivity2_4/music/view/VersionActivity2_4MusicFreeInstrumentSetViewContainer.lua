-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeInstrumentSetViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetViewContainer", package.seeall)

local VersionActivity2_4MusicFreeInstrumentSetViewContainer = class("VersionActivity2_4MusicFreeInstrumentSetViewContainer", BaseViewContainer)

function VersionActivity2_4MusicFreeInstrumentSetViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicFreeInstrumentSetView.New())

	return views
end

return VersionActivity2_4MusicFreeInstrumentSetViewContainer
