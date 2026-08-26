-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_MainSwitchModeViewContainer.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_MainSwitchModeViewContainer", package.seeall)

local V3a9_BossRush_MainSwitchModeViewContainer = class("V3a9_BossRush_MainSwitchModeViewContainer", BaseViewContainer)

function V3a9_BossRush_MainSwitchModeViewContainer:buildViews()
	local views = {}

	self._modeView = V3a9_BossRush_MainSwitchModeView.New()

	table.insert(views, self._modeView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "panel"))

	return views
end

function V3a9_BossRush_MainSwitchModeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.BossRushViewHelp)

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self._tabMainViews = {
			V3a9_BossRush_NormalMainView.New(),
			V3a9_BossRush_ActMainView.New()
		}

		return self._tabMainViews
	end
end

function V3a9_BossRush_MainSwitchModeViewContainer:onContainerInit()
	if self.viewParam then
		if not self.viewParam.enterMode then
			local mode = V3a9_BossRushModel.instance:getMode()
			local helpId = V3a9BossRushEnum.ModeParam[mode].HelpId

			self.navigateView:setHelpId(helpId)
		end
	end
end

function V3a9_BossRush_MainSwitchModeViewContainer:_overrideClose()
	self.playAnimator(self, "close", self._curTab, self.closeThis, self)
end

function V3a9_BossRush_MainSwitchModeViewContainer:playAnimator(animName, tab, cb, cbobj)
	local view = tab and self._tabMainViews[tab]

	if view then
		view:playAnimator(animName, nil, self)
	end

	self._modeView:playAnimator(animName, cb, cbobj)
end

function V3a9_BossRush_MainSwitchModeViewContainer:cutTab(tab)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tab)

	self.viewParam.defaultTabId = tab
	self._curTab = tab

	local helpId = V3a9BossRushEnum.ModeParam[tab].HelpId

	self.navigateView:setHelpId(helpId)
end

return V3a9_BossRush_MainSwitchModeViewContainer
