-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupFightViewContainer.lua

module("modules.logic.abyss.view.AbyssHeroGroupFightViewContainer", package.seeall)

local AbyssHeroGroupFightViewContainer = class("AbyssHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function AbyssHeroGroupFightViewContainer:addLastViews(views)
	table.insert(views, AbyssHeroGroupLockView.New())
end

function AbyssHeroGroupFightViewContainer:getFightLevelView()
	return AbyssHeroGroupFightViewLevel.New()
end

function AbyssHeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = AbyssHeroGroupFightView.New()
	self._heroGroupFightListView = AbyssHeroGroupListView.New()
end

function AbyssHeroGroupFightViewContainer:getFightRuleView()
	return AbyssHeroGroupFightViewRule.New()
end

function AbyssHeroGroupFightViewContainer:getPresetFightView()
	return AbyssHeroGroupPresetView.New()
end

function AbyssHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	self._manualClose = true

	MainController.instance:enterMainScene(true, false)
end

function AbyssHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	return true
end

function AbyssHeroGroupFightViewContainer:onContainerCloseFinish()
	if self._manualClose then
		self:handleVersionActivityCloseCall()
	end
end

function AbyssHeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return AbyssHeroGroupFightViewContainer
