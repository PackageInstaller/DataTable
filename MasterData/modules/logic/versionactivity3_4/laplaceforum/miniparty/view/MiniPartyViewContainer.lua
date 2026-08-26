-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyViewContainer", package.seeall)

local MiniPartyViewContainer = class("MiniPartyViewContainer", BaseViewContainer)

function MiniPartyViewContainer:buildViews()
	local views = {}

	table.insert(views, MiniPartyView.New())
	table.insert(views, MiniPartyTaskView.New())
	table.insert(views, MiniPartyGroupView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MiniPartyViewContainer:buildTabViews(tabContainerId)
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

function MiniPartyViewContainer:_onHelpClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.LaplaceMiniPartyTipTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.LaplaceMiniPartyTipDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

return MiniPartyViewContainer
