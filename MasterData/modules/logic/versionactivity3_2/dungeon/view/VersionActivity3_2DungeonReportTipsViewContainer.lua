-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/VersionActivity3_2DungeonReportTipsViewContainer.lua

module("modules.logic.versionactivity3_2.dungeon.view.VersionActivity3_2DungeonReportTipsViewContainer", package.seeall)

local VersionActivity3_2DungeonReportTipsViewContainer = class("VersionActivity3_2DungeonReportTipsViewContainer", BaseViewContainer)

function VersionActivity3_2DungeonReportTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_2DungeonReportTipsView.New())

	return views
end

return VersionActivity3_2DungeonReportTipsViewContainer
