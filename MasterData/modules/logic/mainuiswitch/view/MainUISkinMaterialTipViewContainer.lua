-- chunkname: @modules/logic/mainuiswitch/view/MainUISkinMaterialTipViewContainer.lua

module("modules.logic.mainuiswitch.view.MainUISkinMaterialTipViewContainer", package.seeall)

local MainUISkinMaterialTipViewContainer = class("MainUISkinMaterialTipViewContainer", BaseViewContainer)

function MainUISkinMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, MainUISkinMaterialTipView.New())
	table.insert(views, MainUISkinMaterialTipViewBanner.New())

	return views
end

return MainUISkinMaterialTipViewContainer
