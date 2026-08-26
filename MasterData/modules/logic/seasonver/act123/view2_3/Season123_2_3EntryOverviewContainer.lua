-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryOverviewContainer", package.seeall)

local Season123_2_3EntryOverviewContainer = class("Season123_2_3EntryOverviewContainer", BaseViewContainer)

function Season123_2_3EntryOverviewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3EntryOverview.New()
	}
end

return Season123_2_3EntryOverviewContainer
