-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9DecomposeFilterViewContainer", package.seeall)

local Season123_1_9DecomposeFilterViewContainer = class("Season123_1_9DecomposeFilterViewContainer", BaseViewContainer)

function Season123_1_9DecomposeFilterViewContainer:buildViews()
	return {
		Season123_1_9DecomposeFilterView.New()
	}
end

return Season123_1_9DecomposeFilterViewContainer
