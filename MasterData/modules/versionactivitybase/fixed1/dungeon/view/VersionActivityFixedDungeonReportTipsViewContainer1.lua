-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/VersionActivityFixedDungeonReportTipsViewContainer1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.VersionActivityFixedDungeonReportTipsViewContainer1", package.seeall)

local VersionActivityFixedDungeonReportTipsViewContainer1 = class("VersionActivityFixedDungeonReportTipsViewContainer1", BaseViewContainer)

function VersionActivityFixedDungeonReportTipsViewContainer1:buildViews()
	local views = {}
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local reportTipsView1 = VersionActivityFixedHelper.getVersionActivityDungeonReportTipsView(bigVersion, smallVersion, scriptSuffix)

	table.insert(views, reportTipsView1.New())

	return views
end

return VersionActivityFixedDungeonReportTipsViewContainer1
