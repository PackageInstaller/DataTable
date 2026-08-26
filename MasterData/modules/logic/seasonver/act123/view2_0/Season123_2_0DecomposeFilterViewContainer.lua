-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeFilterViewContainer", package.seeall)

local Season123_2_0DecomposeFilterViewContainer = class("Season123_2_0DecomposeFilterViewContainer", BaseViewContainer)

function Season123_2_0DecomposeFilterViewContainer:buildViews()
	return {
		Season123_2_0DecomposeFilterView.New()
	}
end

return Season123_2_0DecomposeFilterViewContainer
