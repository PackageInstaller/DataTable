-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickChoiceViewContainer.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewContainer", package.seeall)

local SummonNewCustomPickChoiceViewContainer = class("SummonNewCustomPickChoiceViewContainer", BaseViewContainer)

function SummonNewCustomPickChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonNewCustomPickChoiceView.New())
	table.insert(views, SummonNewCustomPickChoiceViewList.New())

	return views
end

return SummonNewCustomPickChoiceViewContainer
