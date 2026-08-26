-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyBpViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyBpViewContainer", package.seeall)

local Turnback3BuyBpViewContainer = class("Turnback3BuyBpViewContainer", BaseViewContainer)

function Turnback3BuyBpViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3BuyBpView.New())

	return views
end

return Turnback3BuyBpViewContainer
