-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeSelectViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeSelectViewContainer", package.seeall)

local SurvivalDecreeSelectViewContainer = class("SurvivalDecreeSelectViewContainer", BaseViewContainer)

function SurvivalDecreeSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, SurvivalDecreeSelectView.New())

	return views
end

return SurvivalDecreeSelectViewContainer
