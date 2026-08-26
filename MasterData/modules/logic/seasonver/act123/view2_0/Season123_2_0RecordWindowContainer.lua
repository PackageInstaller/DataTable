-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0RecordWindowContainer", package.seeall)

local Season123_2_0RecordWindowContainer = class("Season123_2_0RecordWindowContainer", BaseViewContainer)

function Season123_2_0RecordWindowContainer:buildViews()
	return {
		Season123_2_0RecordWindow.New()
	}
end

return Season123_2_0RecordWindowContainer
