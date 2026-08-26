-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickViewContainer.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickViewContainer", package.seeall)

local SummonSimulationPickViewContainer = class("SummonSimulationPickViewContainer", BaseViewContainer)

function SummonSimulationPickViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonSimulationPickView.New())

	return views
end

return SummonSimulationPickViewContainer
