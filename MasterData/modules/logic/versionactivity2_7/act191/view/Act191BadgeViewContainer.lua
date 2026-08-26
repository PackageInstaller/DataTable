-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191BadgeViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191BadgeViewContainer", package.seeall)

local Act191BadgeViewContainer = class("Act191BadgeViewContainer", BaseViewContainer)

function Act191BadgeViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191BadgeView.New())

	return views
end

return Act191BadgeViewContainer
