-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/VersionActivity3_5DungeonReportTipsViewContainer.lua

module("modules.logic.versionactivity3_5.dungeon.view.VersionActivity3_5DungeonReportTipsViewContainer", package.seeall)

local VersionActivity3_5DungeonReportTipsViewContainer = class("VersionActivity3_5DungeonReportTipsViewContainer", BaseViewContainer)

function VersionActivity3_5DungeonReportTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_5DungeonReportTipsView.New())

	return views
end

return VersionActivity3_5DungeonReportTipsViewContainer
