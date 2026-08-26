-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4DoubleViewContainer.lua

module("modules.logic.turnback.view.turnback4.Turnback4DoubleViewContainer", package.seeall)

local Turnback4DoubleViewContainer = class("Turnback4DoubleViewContainer", BaseViewContainer)

function Turnback4DoubleViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback4DoubleView.New())

	return views
end

return Turnback4DoubleViewContainer
