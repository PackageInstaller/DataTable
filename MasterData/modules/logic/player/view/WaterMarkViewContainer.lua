-- chunkname: @modules/logic/player/view/WaterMarkViewContainer.lua

module("modules.logic.player.view.WaterMarkViewContainer", package.seeall)

local WaterMarkViewContainer = class("WaterMarkViewContainer", BaseViewContainer)

function WaterMarkViewContainer:buildViews()
	local views = {}

	self.waterMarkView = WaterMarkView.New()

	table.insert(views, self.waterMarkView)

	return views
end

return WaterMarkViewContainer
