-- chunkname: @modules/logic/fightuiswitch/view/FightUISkinMaterialTipViewContainer.lua

module("modules.logic.fightuiswitch.view.FightUISkinMaterialTipViewContainer", package.seeall)

local FightUISkinMaterialTipViewContainer = class("FightUISkinMaterialTipViewContainer", BaseViewContainer)

function FightUISkinMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, FightUISkinMaterialTipView.New())
	table.insert(views, FightUISkinMaterialTipViewBanner.New())

	return views
end

return FightUISkinMaterialTipViewContainer
