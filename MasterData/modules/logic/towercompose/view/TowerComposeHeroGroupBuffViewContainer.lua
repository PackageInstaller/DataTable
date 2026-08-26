-- chunkname: @modules/logic/towercompose/view/TowerComposeHeroGroupBuffViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeHeroGroupBuffViewContainer", package.seeall)

local TowerComposeHeroGroupBuffViewContainer = class("TowerComposeHeroGroupBuffViewContainer", BaseViewContainer)

function TowerComposeHeroGroupBuffViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeHeroGroupBuffView.New())

	return views
end

return TowerComposeHeroGroupBuffViewContainer
