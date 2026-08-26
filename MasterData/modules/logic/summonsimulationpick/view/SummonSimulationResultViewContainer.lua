-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationResultViewContainer.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationResultViewContainer", package.seeall)

local SummonSimulationResultViewContainer = class("SummonSimulationResultViewContainer", BaseViewContainer)

function SummonSimulationResultViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonSimulationResultView.New())

	return views
end

return SummonSimulationResultViewContainer
