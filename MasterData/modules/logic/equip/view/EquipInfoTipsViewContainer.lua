-- chunkname: @modules/logic/equip/view/EquipInfoTipsViewContainer.lua

module("modules.logic.equip.view.EquipInfoTipsViewContainer", package.seeall)

local EquipInfoTipsViewContainer = class("EquipInfoTipsViewContainer", BaseViewContainer)

function EquipInfoTipsViewContainer:buildViews()
	self.tipView = EquipInfoTipsView.New()

	return {
		self.tipView
	}
end

function EquipInfoTipsViewContainer:buildTabViews(tabContainerId)
	return
end

function EquipInfoTipsViewContainer:playCloseTransition()
	self:startViewCloseBlock()
	self.tipView:playAllPanelCloseAnim(self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
end

return EquipInfoTipsViewContainer
