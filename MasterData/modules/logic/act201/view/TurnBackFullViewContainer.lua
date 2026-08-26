-- chunkname: @modules/logic/act201/view/TurnBackFullViewContainer.lua

module("modules.logic.act201.view.TurnBackFullViewContainer", package.seeall)

local TurnBackFullViewContainer = class("TurnBackFullViewContainer", BaseViewContainer)

function TurnBackFullViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnBackFullView.New())

	return views
end

return TurnBackFullViewContainer
