-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/VersionActivity3_4DungeonReportTipsViewContainer.lua

module("modules.logic.versionactivity3_4.dungeon.view.VersionActivity3_4DungeonReportTipsViewContainer", package.seeall)

local VersionActivity3_4DungeonReportTipsViewContainer = class("VersionActivity3_4DungeonReportTipsViewContainer", BaseViewContainer)

function VersionActivity3_4DungeonReportTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_4DungeonReportTipsView.New())

	return views
end

return VersionActivity3_4DungeonReportTipsViewContainer
