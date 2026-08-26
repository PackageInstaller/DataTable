-- chunkname: @modules/logic/tower/view/fight/TowerDeepHeroGroupFightViewContainer.lua

module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightViewContainer", package.seeall)

local TowerDeepHeroGroupFightViewContainer = class("TowerDeepHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function TowerDeepHeroGroupFightViewContainer:addLastViews(views)
	table.insert(views, TowerHeroGroupBossView.New())
	table.insert(views, TowerDeepHeroGroupInfoView.New())
end

function TowerDeepHeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = TowerDeepHeroGroupFightView.New()
	self._heroGroupFightListView = TowerHeroGroupListView.New()
end

function TowerDeepHeroGroupFightViewContainer:getFightLevelView()
	return TowerDeepHeroGroupFightViewLevel.New()
end

function TowerDeepHeroGroupFightViewContainer:getHelpId()
	return HelpEnum.HelpId.TowerDeep
end

function TowerDeepHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function TowerDeepHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	return true
end

return TowerDeepHeroGroupFightViewContainer
