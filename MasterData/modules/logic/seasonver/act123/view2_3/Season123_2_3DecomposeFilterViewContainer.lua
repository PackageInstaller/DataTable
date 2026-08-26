-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3DecomposeFilterViewContainer", package.seeall)

local Season123_2_3DecomposeFilterViewContainer = class("Season123_2_3DecomposeFilterViewContainer", BaseViewContainer)

function Season123_2_3DecomposeFilterViewContainer:buildViews()
	return {
		Season123_2_3DecomposeFilterView.New()
	}
end

return Season123_2_3DecomposeFilterViewContainer
