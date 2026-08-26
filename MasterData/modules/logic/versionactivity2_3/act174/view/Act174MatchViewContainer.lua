-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174MatchViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174MatchViewContainer", package.seeall)

local Act174MatchViewContainer = class("Act174MatchViewContainer", BaseViewContainer)

function Act174MatchViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174MatchView.New())

	return views
end

return Act174MatchViewContainer
