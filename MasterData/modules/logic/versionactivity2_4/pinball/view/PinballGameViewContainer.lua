-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballGameViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballGameViewContainer", package.seeall)

local PinballGameViewContainer = class("PinballGameViewContainer", BaseViewContainer)

function PinballGameViewContainer:buildViews()
	return {
		PinballGameSceneView.New(),
		PinballGameView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function PinballGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PinballGameHelp)

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function PinballGameViewContainer:defaultOverrideCloseClick()
	if PinballHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballAbort, MsgBoxEnum.BoxType.Yes_No, self.sendEndGameReq, nil, nil, self)
end

function PinballGameViewContainer:sendEndGameReq()
	if PinballModel.instance.oper == PinballEnum.OperType.Episode then
		self:closeThis()

		return
	end

	PinballEntityMgr.instance:pauseTick()
	Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
end

return PinballGameViewContainer
