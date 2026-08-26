-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3ShowHeroViewContainer", package.seeall)

local Season123_2_3ShowHeroViewContainer = class("Season123_2_3ShowHeroViewContainer", BaseViewContainer)

function Season123_2_3ShowHeroViewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3ShowHeroView.New()
	}
end

return Season123_2_3ShowHeroViewContainer
