-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3PanelViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3PanelViewContainer", package.seeall)

local Turnback3PanelViewContainer = class("Turnback3PanelViewContainer", BaseViewContainer)

function Turnback3PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3PanelView.New())

	return views
end

return Turnback3PanelViewContainer
