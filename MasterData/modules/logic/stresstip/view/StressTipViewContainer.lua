-- chunkname: @modules/logic/stresstip/view/StressTipViewContainer.lua

module("modules.logic.stresstip.view.StressTipViewContainer", package.seeall)

local StressTipViewContainer = class("StressTipViewContainer", BaseViewContainer)

function StressTipViewContainer:buildViews()
	local views = {}

	table.insert(views, StressTipView.New())

	return views
end

return StressTipViewContainer
