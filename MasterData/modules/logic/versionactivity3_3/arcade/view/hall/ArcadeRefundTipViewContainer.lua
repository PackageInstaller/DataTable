-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeRefundTipViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeRefundTipViewContainer", package.seeall)

local ArcadeRefundTipViewContainer = class("ArcadeRefundTipViewContainer", BaseViewContainer)

function ArcadeRefundTipViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeRefundTipView.New())

	return views
end

return ArcadeRefundTipViewContainer
