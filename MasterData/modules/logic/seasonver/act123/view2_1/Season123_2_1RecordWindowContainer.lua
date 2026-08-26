-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1RecordWindowContainer", package.seeall)

local Season123_2_1RecordWindowContainer = class("Season123_2_1RecordWindowContainer", BaseViewContainer)

function Season123_2_1RecordWindowContainer:buildViews()
	return {
		Season123_2_1RecordWindow.New()
	}
end

return Season123_2_1RecordWindowContainer
