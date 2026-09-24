-- chunkname: @modules/logic/custompickchoice/view/SummonCustomPickViewContainer.lua

module("modules.logic.custompickchoice.view.SummonCustomPickViewContainer", package.seeall)

local SummonCustomPickViewContainer = class("SummonCustomPickViewContainer", BaseViewContainer)

function SummonCustomPickViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonCustomPickView.New())
	table.insert(views, SummonCustomPickViewList.New())

	return views
end

return SummonCustomPickViewContainer
