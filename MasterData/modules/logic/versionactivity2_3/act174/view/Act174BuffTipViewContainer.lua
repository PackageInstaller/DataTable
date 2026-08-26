-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174BuffTipViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174BuffTipViewContainer", package.seeall)

local Act174BuffTipViewContainer = class("Act174BuffTipViewContainer", BaseViewContainer)

function Act174BuffTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174BuffTipView.New())

	return views
end

return Act174BuffTipViewContainer
