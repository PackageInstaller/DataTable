-- chunkname: @modules/logic/versionactivity1_9/matildagift/view/V1a9_ActivityShow_MatildagiftViewContainer.lua

module("modules.logic.versionactivity1_9.matildagift.view.V1a9_ActivityShow_MatildagiftViewContainer", package.seeall)

local V1a9_ActivityShow_MatildagiftViewContainer = class("V1a9_ActivityShow_MatildagiftViewContainer", BaseViewContainer)

function V1a9_ActivityShow_MatildagiftViewContainer:buildViews()
	local views = {}

	table.insert(views, V1a9_ActivityShow_MatildagiftView.New())

	return views
end

return V1a9_ActivityShow_MatildagiftViewContainer
