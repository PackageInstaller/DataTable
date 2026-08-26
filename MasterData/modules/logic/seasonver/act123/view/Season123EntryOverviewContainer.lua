-- chunkname: @modules/logic/seasonver/act123/view/Season123EntryOverviewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EntryOverviewContainer", package.seeall)

local Season123EntryOverviewContainer = class("Season123EntryOverviewContainer", BaseViewContainer)

function Season123EntryOverviewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123EntryOverview.New()
	}
end

return Season123EntryOverviewContainer
