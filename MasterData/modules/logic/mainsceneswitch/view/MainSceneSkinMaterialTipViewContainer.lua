-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipViewContainer.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewContainer", package.seeall)

local MainSceneSkinMaterialTipViewContainer = class("MainSceneSkinMaterialTipViewContainer", BaseViewContainer)

function MainSceneSkinMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateMaterialTipView.New())
	table.insert(views, DecorateMaterialTipViewBanner.New())

	return views
end

return MainSceneSkinMaterialTipViewContainer
