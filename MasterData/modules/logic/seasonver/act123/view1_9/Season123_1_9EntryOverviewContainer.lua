-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EntryOverviewContainer", package.seeall)

local Season123_1_9EntryOverviewContainer = class("Season123_1_9EntryOverviewContainer", BaseViewContainer)

function Season123_1_9EntryOverviewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9EntryOverview.New()
	}
end

return Season123_1_9EntryOverviewContainer
