-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0ShowHeroViewContainer", package.seeall)

local Season123_2_0ShowHeroViewContainer = class("Season123_2_0ShowHeroViewContainer", BaseViewContainer)

function Season123_2_0ShowHeroViewContainer:buildViews()
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0ShowHeroView.New()
	}
end

return Season123_2_0ShowHeroViewContainer
