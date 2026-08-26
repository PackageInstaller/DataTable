-- chunkname: @modules/logic/rouge2/map/view/buffdrop/Rouge2_BuffDropViewContainer.lua

module("modules.logic.rouge2.map.view.buffdrop.Rouge2_BuffDropViewContainer", package.seeall)

local Rouge2_BuffDropViewContainer = class("Rouge2_BuffDropViewContainer", BaseViewContainer)

function Rouge2_BuffDropViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BuffDropView.New())

	return views
end

function Rouge2_BuffDropViewContainer:buildTabViews(tabContainerId)
	return
end

return Rouge2_BuffDropViewContainer
