-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/view/V2a8_WuErLiXiGiftViewContainer.lua

module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftViewContainer", package.seeall)

local V2a8_WuErLiXiGiftViewContainer = class("V2a8_WuErLiXiGiftViewContainer", DecalogPresentViewContainer)

function V2a8_WuErLiXiGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a8_WuErLiXiGiftView.New())

	return views
end

return V2a8_WuErLiXiGiftViewContainer
