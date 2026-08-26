-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupTargetViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupTargetViewContainer", package.seeall)

local Season166HeroGroupTargetViewContainer = class("Season166HeroGroupTargetViewContainer", BaseViewContainer)

function Season166HeroGroupTargetViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166HeroGroupTargetView.New())

	return views
end

return Season166HeroGroupTargetViewContainer
