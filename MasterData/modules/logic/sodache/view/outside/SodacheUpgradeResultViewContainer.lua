-- chunkname: @modules/logic/sodache/view/outside/SodacheUpgradeResultViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheUpgradeResultViewContainer", package.seeall)

local SodacheUpgradeResultViewContainer = class("SodacheUpgradeResultViewContainer", BaseViewContainer)

function SodacheUpgradeResultViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheUpgradeResultView.New())

	return views
end

return SodacheUpgradeResultViewContainer
