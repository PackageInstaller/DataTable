-- chunkname: @modules/logic/sodache/view/outside/SodacheUpgradeViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheUpgradeViewContainer", package.seeall)

local SodacheUpgradeViewContainer = class("SodacheUpgradeViewContainer", BaseViewContainer)

function SodacheUpgradeViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheUpgradeView.New())

	return views
end

return SodacheUpgradeViewContainer
