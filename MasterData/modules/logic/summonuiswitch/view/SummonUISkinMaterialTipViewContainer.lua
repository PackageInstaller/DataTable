-- chunkname: @modules/logic/summonuiswitch/view/SummonUISkinMaterialTipViewContainer.lua

module("modules.logic.summonuiswitch.view.SummonUISkinMaterialTipViewContainer", package.seeall)

local SummonUISkinMaterialTipViewContainer = class("SummonUISkinMaterialTipViewContainer", BaseViewContainer)

function SummonUISkinMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonUISkinMaterialTipView.New())
	table.insert(views, SummonUISkinMaterialTipViewBanner.New())

	return views
end

return SummonUISkinMaterialTipViewContainer
