-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonFragmentInfoViewContainer1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonFragmentInfoViewContainer1", package.seeall)

local VersionActivityFixedDungeonFragmentInfoViewContainer1 = class("VersionActivityFixedDungeonFragmentInfoViewContainer1", BaseViewContainer)

function VersionActivityFixedDungeonFragmentInfoViewContainer1:buildViews()
	local views = {}
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local dungeonFragmentInfoView = VersionActivityFixedHelper.getVersionActivityDungeonFragmentInfoView(bigVersion, smallVersion, scriptSuffix)

	table.insert(views, dungeonFragmentInfoView.New())

	return views
end

return VersionActivityFixedDungeonFragmentInfoViewContainer1
