-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3ReviewViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3ReviewViewContainer", package.seeall)

local Turnback3ReviewViewContainer = class("Turnback3ReviewViewContainer", BaseViewContainer)

function Turnback3ReviewViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3ReviewView.New())

	return views
end

return Turnback3ReviewViewContainer
