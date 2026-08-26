-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174EndLessViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174EndLessViewContainer", package.seeall)

local Act174EndLessViewContainer = class("Act174EndLessViewContainer", BaseViewContainer)

function Act174EndLessViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174EndLessView.New())

	return views
end

return Act174EndLessViewContainer
