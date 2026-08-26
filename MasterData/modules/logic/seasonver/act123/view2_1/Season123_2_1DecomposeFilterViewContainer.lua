-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1DecomposeFilterViewContainer", package.seeall)

local Season123_2_1DecomposeFilterViewContainer = class("Season123_2_1DecomposeFilterViewContainer", BaseViewContainer)

function Season123_2_1DecomposeFilterViewContainer:buildViews()
	return {
		Season123_2_1DecomposeFilterView.New()
	}
end

return Season123_2_1DecomposeFilterViewContainer
