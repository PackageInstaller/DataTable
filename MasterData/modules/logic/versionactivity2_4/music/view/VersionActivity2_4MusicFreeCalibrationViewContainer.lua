-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeCalibrationViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationViewContainer", package.seeall)

local VersionActivity2_4MusicFreeCalibrationViewContainer = class("VersionActivity2_4MusicFreeCalibrationViewContainer", BaseViewContainer)

function VersionActivity2_4MusicFreeCalibrationViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicFreeCalibrationView.New())

	return views
end

return VersionActivity2_4MusicFreeCalibrationViewContainer
