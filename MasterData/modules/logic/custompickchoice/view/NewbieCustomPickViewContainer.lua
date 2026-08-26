-- chunkname: @modules/logic/custompickchoice/view/NewbieCustomPickViewContainer.lua

module("modules.logic.custompickchoice.view.NewbieCustomPickViewContainer", package.seeall)

local NewbieCustomPickViewContainer = class("NewbieCustomPickViewContainer", BaseViewContainer)

function NewbieCustomPickViewContainer:buildViews()
	local views = {}

	table.insert(views, NewbieCustomPickView.New())

	return views
end

return NewbieCustomPickViewContainer
