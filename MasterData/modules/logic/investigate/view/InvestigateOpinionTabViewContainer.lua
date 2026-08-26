-- chunkname: @modules/logic/investigate/view/InvestigateOpinionTabViewContainer.lua

module("modules.logic.investigate.view.InvestigateOpinionTabViewContainer", package.seeall)

local InvestigateOpinionTabViewContainer = class("InvestigateOpinionTabViewContainer", BaseViewContainer)

function InvestigateOpinionTabViewContainer:buildViews()
	local views = {}

	table.insert(views, InvestigateOpinionTabView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	self._tabViewGroupFit = TabViewGroupFit.New(2, "root/#go_container")

	self._tabViewGroupFit:keepCloseVisible(true)
	self._tabViewGroupFit:setTabCloseFinishCallback(self._onTabCloseFinish, self)
	self._tabViewGroupFit:setTabOpenFinishCallback(self._onTabOpenFinish, self)
	table.insert(views, self._tabViewGroupFit)

	return views
end

function InvestigateOpinionTabViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end

	if tabContainerId == 2 then
		self._commonView = InvestigateOpinionCommonView.New()
		self._commonExtendView = InvestigateOpinionCommonView.New()

		self._commonExtendView:setInExtendView(true)

		self._opinionView = InvestigateOpinionView.New()
		self._opinionExtendView = InvestigateOpinionExtendView.New()

		return {
			MultiView.New({
				self._commonView,
				self._opinionView
			}),
			MultiView.New({
				self._commonExtendView,
				self._opinionExtendView
			})
		}
	end
end

function InvestigateOpinionTabViewContainer:getCurTabId()
	return self._tabViewGroupFit:getCurTabId()
end

function InvestigateOpinionTabViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function InvestigateOpinionTabViewContainer:_onTabCloseFinish(tabId, tabView)
	self._closeTabId = tabId

	self._tabViewGroupFit:setTabAlpha(tabId, 1)
end

function InvestigateOpinionTabViewContainer:_onTabOpenFinish(tabId, tabView, isFirstOpen)
	self._openTabId = tabId

	if self._closeTabId == self._openTabId then
		return
	end

	if tabId == 1 then
		gohelper.setAsFirstSibling(tabView.viewGO)

		if self._closeTabId then
			self._opinionExtendView:playAnim("gone", self._onAnimDone, self)
		end
	else
		gohelper.setAsLastSibling(tabView.viewGO)
		self._opinionExtendView:playAnim("into", self._onAnimDone, self)
	end
end

function InvestigateOpinionTabViewContainer:_onAnimDone()
	if self._openTabId == 1 then
		self._tabViewGroupFit:setTabAlpha(2, 0)
	else
		self._tabViewGroupFit:setTabAlpha(1, 0)
	end
end

return InvestigateOpinionTabViewContainer
