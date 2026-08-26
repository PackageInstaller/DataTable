-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupFightViewContainer.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupFightViewContainer", package.seeall)

local V3a9_BossRush_HeroGroupFightViewContainer = class("V3a9_BossRush_HeroGroupFightViewContainer", BaseViewContainer)

function V3a9_BossRush_HeroGroupFightViewContainer:buildViews()
	local views = {}

	self.groupView = V3a9_BossRush_HeroGroupFightView.New()
	self.groupPresetView = V3a9_BossRush_HeroGroupPresetFightView.New()

	table.insert(views, self.groupView)

	self.groupListView = V3a9_BossRush_HeroGroupListView.New()

	table.insert(views, self.groupListView)
	table.insert(views, self.groupPresetView)
	table.insert(views, V3a9_BossRush_HeroGroupFightViewLevel.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a9_BossRush_HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self._overClose, nil, nil, self)

		return {
			self._navigateButtonsView
		}
	end
end

function V3a9_BossRush_HeroGroupFightViewContainer:_overClose()
	self.groupView:PlayCloseAnim(self._closeCallback, self)
end

function V3a9_BossRush_HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if DungeonJumpGameController.instance:checkIsJumpGameBattle() then
		DungeonJumpGameController.instance:returnToJumpGameView()

		return
	end

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function V3a9_BossRush_HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function V3a9_BossRush_HeroGroupFightViewContainer:getHeroGroupFightView()
	return self.groupView
end

return V3a9_BossRush_HeroGroupFightViewContainer
