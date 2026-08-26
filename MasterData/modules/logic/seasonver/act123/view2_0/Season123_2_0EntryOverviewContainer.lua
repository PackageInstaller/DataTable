-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EntryOverviewContainer", package.seeall)

local Season123_2_0EntryOverviewContainer = class("Season123_2_0EntryOverviewContainer", BaseViewContainer)

function Season123_2_0EntryOverviewContainer:buildViews()
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0EntryOverview.New()
	}
end

return Season123_2_0EntryOverviewContainer
