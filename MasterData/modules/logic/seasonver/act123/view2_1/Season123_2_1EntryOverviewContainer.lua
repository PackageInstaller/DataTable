-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryOverviewContainer", package.seeall)

local Season123_2_1EntryOverviewContainer = class("Season123_2_1EntryOverviewContainer", BaseViewContainer)

function Season123_2_1EntryOverviewContainer:buildViews()
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1EntryOverview.New()
	}
end

return Season123_2_1EntryOverviewContainer
