-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonHeroGroupViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonHeroGroupViewContainer", package.seeall)

local AtomicDungeonHeroGroupViewContainer = class("AtomicDungeonHeroGroupViewContainer", HeroGroupFightViewContainer)

function AtomicDungeonHeroGroupViewContainer:addLastViews(views)
	return
end

function AtomicDungeonHeroGroupViewContainer:defineFightView()
	self._heroGroupFightView = AtomicDungeonHeroGroupView.New()
	self._heroGroupFightListView = HeroGroupListView.New()
end

function AtomicDungeonHeroGroupViewContainer:getFightRuleView()
	return AtomicHeroGroupFightViewRule.New()
end

function AtomicDungeonHeroGroupViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			helpId ~= nil
		}, helpId, self._closeCallback, self._homeCallback, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local currencyType = CurrencyEnum.CurrencyType

		return {
			CurrencyView.New({
				currencyType.Power
			})
		}
	end
end

function AtomicDungeonHeroGroupViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function AtomicDungeonHeroGroupViewContainer:_homeCallback()
	AtomicDungeonStatHelper.instance:sendDungeonResultInfo("主动返回")
	AtomicDungeonModel.instance:cleanLastElementFightParam()
	AtomicDungeonModel.instance:cleanLastPolygonFightParam()
end

function AtomicDungeonHeroGroupViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	return true
end

return AtomicDungeonHeroGroupViewContainer
