-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9RecordWindowContainer", package.seeall)

local Season123_1_9RecordWindowContainer = class("Season123_1_9RecordWindowContainer", BaseViewContainer)

function Season123_1_9RecordWindowContainer:buildViews()
	return {
		Season123_1_9RecordWindow.New()
	}
end

return Season123_1_9RecordWindowContainer
