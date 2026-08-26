-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9ShowHeroViewContainer", package.seeall)

local Season123_1_9ShowHeroViewContainer = class("Season123_1_9ShowHeroViewContainer", BaseViewContainer)

function Season123_1_9ShowHeroViewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9ShowHeroView.New()
	}
end

return Season123_1_9ShowHeroViewContainer
