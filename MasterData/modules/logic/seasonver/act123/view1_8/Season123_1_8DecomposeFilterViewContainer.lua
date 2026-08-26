-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8DecomposeFilterViewContainer", package.seeall)

local Season123_1_8DecomposeFilterViewContainer = class("Season123_1_8DecomposeFilterViewContainer", BaseViewContainer)

function Season123_1_8DecomposeFilterViewContainer:buildViews()
	return {
		Season123_1_8DecomposeFilterView.New()
	}
end

return Season123_1_8DecomposeFilterViewContainer
