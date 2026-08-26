-- chunkname: @modules/logic/chargepush/view/ChargePushCommonGiftViewContainer.lua

module("modules.logic.chargepush.view.ChargePushCommonGiftViewContainer", package.seeall)

local ChargePushCommonGiftViewContainer = class("ChargePushCommonGiftViewContainer", BaseViewContainer)

function ChargePushCommonGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, ChargePushCommonGiftView.New())

	return views
end

return ChargePushCommonGiftViewContainer
