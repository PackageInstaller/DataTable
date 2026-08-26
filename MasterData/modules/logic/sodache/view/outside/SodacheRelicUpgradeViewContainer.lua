-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicUpgradeViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheRelicUpgradeViewContainer", package.seeall)

local SodacheRelicUpgradeViewContainer = class("SodacheRelicUpgradeViewContainer", BaseViewContainer)

function SodacheRelicUpgradeViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheRelicUpgradeView.New())

	return views
end

return SodacheRelicUpgradeViewContainer
