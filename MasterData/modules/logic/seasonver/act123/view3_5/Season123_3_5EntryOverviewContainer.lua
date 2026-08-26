-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EntryOverviewContainer", package.seeall)

local Season123_3_5EntryOverviewContainer = class("Season123_3_5EntryOverviewContainer", BaseViewContainer)

function Season123_3_5EntryOverviewContainer:buildViews()
	return {
		Season123_3_5CheckCloseView.New(),
		Season123_3_5EntryOverview.New()
	}
end

return Season123_3_5EntryOverviewContainer
