-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyViewContainer.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyViewContainer", package.seeall)

local VersionActivity1_3AstrologyViewContainer = class("VersionActivity1_3AstrologyViewContainer", BaseViewContainer)

function VersionActivity1_3AstrologyViewContainer:buildViews()
	self.astrologyView = VersionActivity1_3AstrologyView.New()

	return {
		self.astrologyView,
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_plate"),
		TabViewGroup.New(3, "#go_Right")
	}
end

function VersionActivity1_3AstrologyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity1_3Astrology)

		self._navigateButtonView:setHomeCheck(self._closeCheckFunc, self)
		self._navigateButtonView:setOverrideClose(self.overrideClose, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			VersionActivity1_3AstrologyPlateView.New()
		}
	elseif tabContainerId == 3 then
		return {
			VersionActivity1_3AstrologySelectView.New(),
			VersionActivity1_3AstrologyResultView.New()
		}
	end
end

function VersionActivity1_3AstrologyViewContainer:_closeCheckFunc()
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		return true
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function()
		self:sendUpdateProgressRequest()
	end, function()
		self._navigateButtonView:_reallyHome()
	end)

	return false
end

function VersionActivity1_3AstrologyViewContainer:overrideClose()
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		self:closeThis()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function()
		self:sendUpdateProgressRequest()
	end, function()
		self:closeThis()
	end)
end

function VersionActivity1_3AstrologyViewContainer:sendUpdateProgressRequest()
	local activityId = VersionActivity1_3Enum.ActivityId.Act310
	local progressStr = VersionActivity1_3AstrologyModel.instance:generateStarProgressStr()
	local activeStarId, planetList = VersionActivity1_3AstrologyModel.instance:generateStarProgressCost()

	self._sendPlanetList = planetList

	Activity126Rpc.instance:sendUpdateProgressRequest(activityId, progressStr, activeStarId)
end

function VersionActivity1_3AstrologyViewContainer:getSendPlanetList()
	return self._sendPlanetList
end

function VersionActivity1_3AstrologyViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 3, tabId)
end

return VersionActivity1_3AstrologyViewContainer
