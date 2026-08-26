-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114ScoreReportViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114ScoreReportViewContainer", package.seeall)

local Activity114ScoreReportViewContainer = class("Activity114ScoreReportViewContainer", BaseViewContainer)

function Activity114ScoreReportViewContainer:buildViews()
	return {
		Activity114ScoreReportView.New()
	}
end

return Activity114ScoreReportViewContainer
