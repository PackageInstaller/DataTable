-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpViewContainer", package.seeall)

local Anniversary3ActBpViewContainer = class("Anniversary3ActBpViewContainer", BaseViewContainer)

function Anniversary3ActBpViewContainer:buildViews()
	Anniversary3ActBpModel.instance.isViewLoading = true

	return {
		TabViewGroup.New(1, "#go_btns"),
		Anniversary3ActBpBonusView.New(),
		Anniversary3ActBpTaskView.New(),
		Anniversary3ActBpView.New()
	}
end

function Anniversary3ActBpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setOverrideHelp(self._onHelpClick, self)

		return {
			self._navigateButtonView
		}
	end
end

function Anniversary3ActBpViewContainer:_onHelpClick()
	local desc = luaLang("p_v3a7_anniversary3_activitybp_rule_text")
	local title = luaLang("p_v3a7_anniversary3_activitybp_rule_titile")

	HelpController.instance:openStoreTipView(desc, title)
end

return Anniversary3ActBpViewContainer
