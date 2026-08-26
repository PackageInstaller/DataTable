-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpViewContainer", package.seeall)

local Turnback3BpViewContainer = class("Turnback3BpViewContainer", BaseViewContainer)

Turnback3BpViewContainer.TabView_BonusOrTask = 1
Turnback3BpViewContainer.TabView_CurrencyView = 2

function Turnback3BpViewContainer:buildViews()
	self._toggleView = ToggleListView.New(Turnback3BpViewContainer.TabView_BonusOrTask, "root/top/toggleGroup")

	return {
		TurnbackBpTabGroup.New(Turnback3BpViewContainer.TabView_BonusOrTask, "root/middle"),
		Turnback3BpView.New(),
		self._toggleView,
		TabViewGroup.New(Turnback3BpViewContainer.TabView_CurrencyView, "root/#go_topright")
	}
end

function Turnback3BpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == Turnback3BpViewContainer.TabView_BonusOrTask then
		return {
			Turnback3BpBonusView.New(),
			Turnback3BpTaskView.New()
		}
	elseif tabContainerId == Turnback3BpViewContainer.TabView_CurrencyView then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function Turnback3BpViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function Turnback3BpViewContainer:clickToggleBtn(toggleId)
	local toggleWrap = self._toggleView._toggleDict[toggleId]

	if toggleWrap then
		toggleWrap:TriggerClick()
	end
end

return Turnback3BpViewContainer
