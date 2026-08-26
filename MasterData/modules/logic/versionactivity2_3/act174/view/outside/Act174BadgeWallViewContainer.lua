-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174BadgeWallViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174BadgeWallViewContainer", package.seeall)

local Act174BadgeWallViewContainer = class("Act174BadgeWallViewContainer", BaseViewContainer)

function Act174BadgeWallViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174BadgeWallView.New())

	return views
end

return Act174BadgeWallViewContainer
