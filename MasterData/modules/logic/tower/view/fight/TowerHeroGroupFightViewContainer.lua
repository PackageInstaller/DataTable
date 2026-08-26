-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupFightViewContainer.lua

module("modules.logic.tower.view.fight.TowerHeroGroupFightViewContainer", package.seeall)

local TowerHeroGroupFightViewContainer = class("TowerHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function TowerHeroGroupFightViewContainer:addLastViews(views)
	table.insert(views, TowerHeroGroupBossView.New())
end

function TowerHeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = TowerHeroGroupFightView.New()
	self._heroGroupFightListView = TowerHeroGroupListView.New()
end

function TowerHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function TowerHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	return true
end

return TowerHeroGroupFightViewContainer
