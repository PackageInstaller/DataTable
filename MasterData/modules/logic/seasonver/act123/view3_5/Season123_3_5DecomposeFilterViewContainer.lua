-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5DecomposeFilterViewContainer", package.seeall)

local Season123_3_5DecomposeFilterViewContainer = class("Season123_3_5DecomposeFilterViewContainer", BaseViewContainer)

function Season123_3_5DecomposeFilterViewContainer:buildViews()
	return {
		Season123_3_5DecomposeFilterView.New()
	}
end

return Season123_3_5DecomposeFilterViewContainer
