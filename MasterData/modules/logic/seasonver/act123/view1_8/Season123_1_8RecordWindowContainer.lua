-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8RecordWindowContainer", package.seeall)

local Season123_1_8RecordWindowContainer = class("Season123_1_8RecordWindowContainer", BaseViewContainer)

function Season123_1_8RecordWindowContainer:buildViews()
	return {
		Season123_1_8RecordWindow.New()
	}
end

return Season123_1_8RecordWindowContainer
