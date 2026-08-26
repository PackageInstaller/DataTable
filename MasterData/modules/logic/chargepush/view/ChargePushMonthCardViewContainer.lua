-- chunkname: @modules/logic/chargepush/view/ChargePushMonthCardViewContainer.lua

module("modules.logic.chargepush.view.ChargePushMonthCardViewContainer", package.seeall)

local ChargePushMonthCardViewContainer = class("ChargePushMonthCardViewContainer", BaseViewContainer)

function ChargePushMonthCardViewContainer:buildViews()
	local views = {}

	table.insert(views, ChargePushMonthCardView.New())

	return views
end

return ChargePushMonthCardViewContainer
