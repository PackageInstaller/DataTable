-- chunkname: @modules/logic/rouge/view/RougerewardThemeTipViewContainer.lua

module("modules.logic.rouge.view.RougerewardThemeTipViewContainer", package.seeall)

local RougerewardThemeTipViewContainer = class("RougerewardThemeTipViewContainer", BaseViewContainer)

function RougerewardThemeTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RougerewardThemeTipView.New())

	return views
end

return RougerewardThemeTipViewContainer
