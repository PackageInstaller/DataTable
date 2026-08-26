-- chunkname: @modules/logic/investigate/view/InvestigateTipsViewContainer.lua

module("modules.logic.investigate.view.InvestigateTipsViewContainer", package.seeall)

local InvestigateTipsViewContainer = class("InvestigateTipsViewContainer", BaseViewContainer)

function InvestigateTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, InvestigateTipsView.New())

	return views
end

return InvestigateTipsViewContainer
