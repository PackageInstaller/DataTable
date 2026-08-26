-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyBpTipViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyBpTipViewContainer", package.seeall)

local Turnback3BuyBpTipViewContainer = class("Turnback3BuyBpTipViewContainer", BaseViewContainer)

function Turnback3BuyBpTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3BuyBpTipView.New())

	return views
end

return Turnback3BuyBpTipViewContainer
