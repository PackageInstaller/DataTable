-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomMainViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomMainViewContainer", package.seeall)

local CandyRoomMainViewContainer = class("CandyRoomMainViewContainer", BaseViewContainer)

function CandyRoomMainViewContainer:buildViews()
	local views = {}

	table.insert(views, CandyRoomMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CandyRoomMainViewContainer:buildTabViews(tabContainerId)
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

function CandyRoomMainViewContainer:_onHelpClick()
	local desc = CommonConfig.instance:getConstStr(ConstEnum.ConstEnum.V4a0_CandyRoomTipDesc)

	HelpController.instance:openStoreTipView(desc)
end

return CandyRoomMainViewContainer
