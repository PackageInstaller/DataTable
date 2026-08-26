-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8ShowHeroViewContainer", package.seeall)

local Season123_1_8ShowHeroViewContainer = class("Season123_1_8ShowHeroViewContainer", BaseViewContainer)

function Season123_1_8ShowHeroViewContainer:buildViews()
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8ShowHeroView.New()
	}
end

return Season123_1_8ShowHeroViewContainer
