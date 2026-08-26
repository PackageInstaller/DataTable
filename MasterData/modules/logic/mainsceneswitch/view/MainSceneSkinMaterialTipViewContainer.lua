-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipViewContainer.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewContainer", package.seeall)

local MainSceneSkinMaterialTipViewContainer = class("MainSceneSkinMaterialTipViewContainer", BaseViewContainer)

function MainSceneSkinMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, MainSceneSkinMaterialTipView.New())
	table.insert(views, MainSceneSkinMaterialTipViewBanner.New())

	return views
end

return MainSceneSkinMaterialTipViewContainer
