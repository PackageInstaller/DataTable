-- chunkname: @modules/logic/abyss/view/AbyssEnterViewContainer.lua

module("modules.logic.abyss.view.AbyssEnterViewContainer", package.seeall)

local AbyssEnterViewContainer = class("AbyssEnterViewContainer", BaseViewContainer)

function AbyssEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, AbyssEnterView.New())

	return views
end

return AbyssEnterViewContainer
