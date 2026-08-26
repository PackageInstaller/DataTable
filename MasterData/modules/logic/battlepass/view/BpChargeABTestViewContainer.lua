-- chunkname: @modules/logic/battlepass/view/BpChargeABTestViewContainer.lua

module("modules.logic.battlepass.view.BpChargeABTestViewContainer", package.seeall)

local BpChargeABTestViewContainer = class("BpChargeABTestViewContainer", BaseViewContainer)

function BpChargeABTestViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, BpChargeABTestView.New())

	return views
end

function BpChargeABTestViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

function BpChargeABTestViewContainer:playOpenTransition()
	local anim = "open"

	if self.viewParam and self.viewParam.first then
		anim = "first"

		AudioMgr.instance:trigger(AudioEnum3_4.BP.FaceView_play_ui_bulaochun_yunying_bp)
	end

	BpChargeABTestViewContainer.super.playOpenTransition(self, {
		duration = 3,
		anim = anim
	})
end

return BpChargeABTestViewContainer
