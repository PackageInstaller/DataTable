-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupFightViewContainer.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupFightViewContainer", package.seeall)

local Rouge2_HeroGroupFightViewContainer = class("Rouge2_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function Rouge2_HeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = Rouge2_HeroGroupFightView.New()
	self._heroGroupFightListView = Rouge2_HeroGroupListView.New()
end

function Rouge2_HeroGroupFightViewContainer:getFightLevelView()
	return Rouge2_HeroGroupFightViewLevel.New()
end

function Rouge2_HeroGroupFightViewContainer:addCommonViews(views)
	Rouge2_HeroGroupFightViewContainer.super.addCommonViews(self, views)
	table.insert(views, Rouge2_HeroGroupActiveSkillView.New())
	table.insert(views, Rouge2_MapCoinView.New())
end

function Rouge2_HeroGroupFightViewContainer:buildTabViews(tabContainerId)
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

function Rouge2_HeroGroupFightViewContainer:_homeCallback()
	Rouge2_StatController.instance:statEnd(Rouge2_StatController.EndResult.Close)
end

function Rouge2_HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	self._manualClose = true

	Rouge2_MapModel.instance:setManualCloseHeroGroupView(true)
end

function Rouge2_HeroGroupFightViewContainer:onContainerCloseFinish()
	if self._manualClose then
		self:handleVersionActivityCloseCall()
		Rouge2_Controller.instance:enterRouge()
	end
end

function Rouge2_HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Rouge2_HeroGroupFightViewContainer
