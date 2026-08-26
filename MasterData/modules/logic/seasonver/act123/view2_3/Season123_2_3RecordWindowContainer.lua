-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3RecordWindowContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3RecordWindowContainer", package.seeall)

local Season123_2_3RecordWindowContainer = class("Season123_2_3RecordWindowContainer", BaseViewContainer)

function Season123_2_3RecordWindowContainer:buildViews()
	return {
		Season123_2_3RecordWindow.New()
	}
end

return Season123_2_3RecordWindowContainer
