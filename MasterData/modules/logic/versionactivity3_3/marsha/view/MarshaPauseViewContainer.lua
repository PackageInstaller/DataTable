-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaPauseViewContainer.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaPauseViewContainer", package.seeall)

local MarshaPauseViewContainer = class("MarshaPauseViewContainer", BaseViewContainer)

function MarshaPauseViewContainer:buildViews()
	local views = {}

	table.insert(views, MarshaPauseView.New())

	return views
end

return MarshaPauseViewContainer
