-- chunkname: @modules/logic/custompickchoice/view/CustomPickChoiceViewContainer.lua

module("modules.logic.custompickchoice.view.CustomPickChoiceViewContainer", package.seeall)

local CustomPickChoiceViewContainer = class("CustomPickChoiceViewContainer", BaseViewContainer)

function CustomPickChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, CustomPickChoiceView.New())

	return views
end

return CustomPickChoiceViewContainer
