-- chunkname: @modules/logic/seasonver/act123/view/Season123DecomposeFilterViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123DecomposeFilterViewContainer", package.seeall)

local Season123DecomposeFilterViewContainer = class("Season123DecomposeFilterViewContainer", BaseViewContainer)

function Season123DecomposeFilterViewContainer:buildViews()
	return {
		Season123DecomposeFilterView.New()
	}
end

return Season123DecomposeFilterViewContainer
