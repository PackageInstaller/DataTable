-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5RecordWindowContainer", package.seeall)

local Season123_3_5RecordWindowContainer = class("Season123_3_5RecordWindowContainer", BaseViewContainer)

function Season123_3_5RecordWindowContainer:buildViews()
	return {
		Season123_3_5RecordWindow.New()
	}
end

return Season123_3_5RecordWindowContainer
