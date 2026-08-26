-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ShowHeroViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ShowHeroViewContainer", package.seeall)

local Season123_3_5ShowHeroViewContainer = class("Season123_3_5ShowHeroViewContainer", BaseViewContainer)

function Season123_3_5ShowHeroViewContainer:buildViews()
	return {
		Season123_3_5CheckCloseView.New(),
		Season123_3_5ShowHeroView.New()
	}
end

return Season123_3_5ShowHeroViewContainer
