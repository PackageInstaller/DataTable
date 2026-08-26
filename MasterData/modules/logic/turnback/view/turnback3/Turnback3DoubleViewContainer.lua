-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3DoubleViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3DoubleViewContainer", package.seeall)

local Turnback3DoubleViewContainer = class("Turnback3DoubleViewContainer", BaseViewContainer)

function Turnback3DoubleViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3DoubleView.New())

	return views
end

return Turnback3DoubleViewContainer
