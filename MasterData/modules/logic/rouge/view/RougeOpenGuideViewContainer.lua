-- chunkname: @modules/logic/rouge/view/RougeOpenGuideViewContainer.lua

module("modules.logic.rouge.view.RougeOpenGuideViewContainer", package.seeall)

local RougeOpenGuideViewContainer = class("RougeOpenGuideViewContainer", BaseViewContainer)

function RougeOpenGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeOpenGuideView.New())

	return views
end

return RougeOpenGuideViewContainer
