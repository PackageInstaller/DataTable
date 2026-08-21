-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentUpgradeViewPresentor.lua

module("logic.extensions.playerinfo.view.monument.MonumentUpgradeViewPresentor", package.seeall)

local M = class("MonumentUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Monument_upgrade_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonumentUpgradeView.New())

	return views
end

return M
