-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4ProgressViewContainer.lua

module("modules.logic.turnback.view.turnback4.Turnback4ProgressViewContainer", package.seeall)

local Turnback4ProgressViewContainer = class("Turnback4ProgressViewContainer", BaseViewContainer)

function Turnback4ProgressViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback4ProgressView.New())

	return views
end

return Turnback4ProgressViewContainer
