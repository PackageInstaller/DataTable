-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseGlobalTaskViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseGlobalTaskViewContainer", package.seeall)

local CruiseGlobalTaskViewContainer = class("CruiseGlobalTaskViewContainer", BaseViewContainer)

function CruiseGlobalTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseGlobalTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function CruiseGlobalTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonsView:setOverrideHelp(self._onHelpClick, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local currencyId = string.splitToNumber(Activity215Config.instance:getConstCO(1).value, "#")[2]

		self.currencyView = CurrencyView.New({
			currencyId
		})
		self.currencyView.foreHideBtn = true

		return {
			self.currencyView
		}
	end
end

function CruiseGlobalTaskViewContainer:_onHelpClick()
	local desc = CommonConfig.instance:getConstStr(ConstEnum.CruiseGlobalTaskDesc)

	HelpController.instance:openStoreTipView(desc)
end

return CruiseGlobalTaskViewContainer
