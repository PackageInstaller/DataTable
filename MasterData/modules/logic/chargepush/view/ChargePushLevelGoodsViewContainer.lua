-- chunkname: @modules/logic/chargepush/view/ChargePushLevelGoodsViewContainer.lua

module("modules.logic.chargepush.view.ChargePushLevelGoodsViewContainer", package.seeall)

local ChargePushLevelGoodsViewContainer = class("ChargePushLevelGoodsViewContainer", BaseViewContainer)

function ChargePushLevelGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, ChargePushLevelGoodsView.New())

	return views
end

return ChargePushLevelGoodsViewContainer
