-- chunkname: @modules/logic/seasonver/act123/view/Season123ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123ShowHeroViewContainer", package.seeall)

local Season123ShowHeroViewContainer = class("Season123ShowHeroViewContainer", BaseViewContainer)

function Season123ShowHeroViewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123ShowHeroView.New()
	}
end

return Season123ShowHeroViewContainer
