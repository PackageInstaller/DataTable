-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameViewContainer.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameViewContainer", package.seeall)

local WuErLiXiGameViewContainer = class("WuErLiXiGameViewContainer", BaseViewContainer)

function WuErLiXiGameViewContainer:buildViews()
	return {
		WuErLiXiGameView.New(),
		WuErLiXiGameMapView.New(),
		WuErLiXiGameOperView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function WuErLiXiGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function WuErLiXiGameViewContainer:defaultOverrideCloseClick()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.WuErLiXiMapEscapeConfirm, MsgBoxEnum.BoxType.Yes_No, self._onCloseGameView, nil, nil, self)
end

function WuErLiXiGameViewContainer:_onCloseGameView()
	self._mapId = WuErLiXiConfig.instance:getEpisodeCo(VersionActivity2_4Enum.ActivityId.WuErLiXi, self.viewParam.episodeId).mapId

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(self._mapId),
		[StatEnum.EventProperties.OperationType] = "Escape",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	self:closeThis()
end

return WuErLiXiGameViewContainer
