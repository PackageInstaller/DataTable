-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyMonthCardViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyMonthCardViewContainer", package.seeall)

local Turnback3BuyMonthCardViewContainer = class("Turnback3BuyMonthCardViewContainer", BaseViewContainer)

function Turnback3BuyMonthCardViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3BuyMonthCardView.New())

	return views
end

return Turnback3BuyMonthCardViewContainer
