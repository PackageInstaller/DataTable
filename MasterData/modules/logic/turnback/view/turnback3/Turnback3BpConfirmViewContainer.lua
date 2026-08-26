-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpConfirmViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpConfirmViewContainer", package.seeall)

local Turnback3BpConfirmViewContainer = class("Turnback3BpConfirmViewContainer", BaseViewContainer)

function Turnback3BpConfirmViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3BpConfirmView.New())

	return views
end

return Turnback3BpConfirmViewContainer
