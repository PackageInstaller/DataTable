-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchViewContainer.lua

module("modules.logic.bgmswitch.view.BGMSwitchViewContainer", package.seeall)

local BGMSwitchViewContainer = class("BGMSwitchViewContainer", BaseViewContainer)

function BGMSwitchViewContainer:buildViews()
	return {
		BGMSwitchMechineView.New(),
		BGMSwitchMusicView.New(),
		BGMSwitchEggView.New(),
		TabViewGroup.New(1, "#go_btns"),
		BGMSwitchView.New()
	}
end

function BGMSwitchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigationView:setHelpId(HelpEnum.HelpId.BgmView)

		return {
			self.navigationView
		}
	end
end

return BGMSwitchViewContainer
