-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1ShowHeroViewContainer", package.seeall)

local Season123_2_1ShowHeroViewContainer = class("Season123_2_1ShowHeroViewContainer", BaseViewContainer)

function Season123_2_1ShowHeroViewContainer:buildViews()
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1ShowHeroView.New()
	}
end

return Season123_2_1ShowHeroViewContainer
