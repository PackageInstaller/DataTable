-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryOverviewContainer", package.seeall)

local Season123_1_8EntryOverviewContainer = class("Season123_1_8EntryOverviewContainer", BaseViewContainer)

function Season123_1_8EntryOverviewContainer:buildViews()
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8EntryOverview.New()
	}
end

return Season123_1_8EntryOverviewContainer
