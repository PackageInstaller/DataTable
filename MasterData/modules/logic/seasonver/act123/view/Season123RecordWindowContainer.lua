-- chunkname: @modules/logic/seasonver/act123/view/Season123RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view.Season123RecordWindowContainer", package.seeall)

local Season123RecordWindowContainer = class("Season123RecordWindowContainer", BaseViewContainer)

function Season123RecordWindowContainer:buildViews()
	return {
		Season123RecordWindow.New()
	}
end

return Season123RecordWindowContainer
