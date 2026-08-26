-- chunkname: @modules/logic/rouge2/map/view/relicsdrop/Rouge2_RelicsDropViewContainer.lua

module("modules.logic.rouge2.map.view.relicsdrop.Rouge2_RelicsDropViewContainer", package.seeall)

local Rouge2_RelicsDropViewContainer = class("Rouge2_RelicsDropViewContainer", BaseViewContainer)

function Rouge2_RelicsDropViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_RelicsDropView.New())

	return views
end

function Rouge2_RelicsDropViewContainer:buildTabViews(tabContainerId)
	return
end

return Rouge2_RelicsDropViewContainer
