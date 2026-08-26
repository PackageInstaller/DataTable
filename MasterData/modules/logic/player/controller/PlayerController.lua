-- chunkname: @modules/logic/player/controller/PlayerController.lua

module("modules.logic.player.controller.PlayerController", package.seeall)

local PlayerController = class("PlayerController", BaseController)

function PlayerController:enterSelectScene()
	ViewMgr.instance:openView(ViewName.PlayerView)
end

function PlayerController:openPlayerView(playerInfo, playerSelf, heroCover, hideHomeBtn)
	local param = {}

	param.playerInfo = playerInfo
	param.playerSelf = playerSelf
	param.heroCover = heroCover
	param.hideHomeBtn = hideHomeBtn

	ViewMgr.instance:openView(ViewName.PlayerView, param)
end

function PlayerController:openSelfPlayerView()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self:openPlayerView(playerInfo, true)
end

function PlayerController:onInit()
	return
end

function PlayerController:onInitFinish()
	return
end

function PlayerController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._OnDailyRefresh, self)
end

function PlayerController:_OnDailyRefresh()
	PlayerModel.instance:checkCanRenameReset()
	PlayerRpc.instance:sendMarkMainThumbnailRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest(self._onDailyRefreshGetPlayerInfo, self)
	logNormal("每日五点刷新， 发送获取player信息的请求， PlayerRpc")
end

function PlayerController:updateAssistRewardCount()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	PlayerRpc.instance:sendGetAssistBonusRequest()
end

function PlayerController:getAssistReward()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	local isHasAssistReward = PlayerModel.instance:isHasAssistReward()

	if not isHasAssistReward then
		GameFacade.showToast(ToastEnum.NoRewardCanGet)

		return
	end

	PlayerRpc.instance:sendReceiveAssistBonusRequest()
end

function PlayerController:reInit()
	return
end

function PlayerController:_onDailyRefreshGetPlayerInfo()
	self:dispatchEvent(PlayerEvent.OnDailyRefresh)
end

PlayerController.instance = PlayerController.New()

return PlayerController
