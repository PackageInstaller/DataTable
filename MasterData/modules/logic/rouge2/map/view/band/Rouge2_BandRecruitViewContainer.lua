-- chunkname: @modules/logic/rouge2/map/view/band/Rouge2_BandRecruitViewContainer.lua

module("modules.logic.rouge2.map.view.band.Rouge2_BandRecruitViewContainer", package.seeall)

local Rouge2_BandRecruitViewContainer = class("Rouge2_BandRecruitViewContainer", BaseViewContainer)

function Rouge2_BandRecruitViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, Rouge2_BandRecruitView.New())

	return views
end

function Rouge2_BandRecruitViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigationView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		navigationView:setOverrideHelp(self.overrideHelpBtn, self)
		navigationView:setOverrideClose(self.overrideCloseCallback, self)

		return {
			navigationView
		}
	end
end

function Rouge2_BandRecruitViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BandRecruit)
end

function Rouge2_BandRecruitViewContainer:overrideCloseCallback()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Rouge2ExitEvent, MsgBoxEnum.BoxType.Yes_No, self.reallyLeaveView, nil, nil, self)
end

function Rouge2_BandRecruitViewContainer:reallyLeaveView()
	self._rpcCallbackId = Rouge2_Rpc.instance:sendRouge2EndBandRequest(self.closeThis, self)
end

function Rouge2_BandRecruitViewContainer:onContainerClose()
	if self._rpcCallbackId then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallbackId)

		self._rpcCallbackId = nil
	end
end

return Rouge2_BandRecruitViewContainer
