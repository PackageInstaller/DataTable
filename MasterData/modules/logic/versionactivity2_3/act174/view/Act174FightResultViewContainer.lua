-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174FightResultViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174FightResultViewContainer", package.seeall)

local Act174FightResultViewContainer = class("Act174FightResultViewContainer", BaseViewContainer)

function Act174FightResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174FightResultView.New())

	return views
end

return Act174FightResultViewContainer
