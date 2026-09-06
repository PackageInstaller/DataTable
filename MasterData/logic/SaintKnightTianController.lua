-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/controller/SaintKnightTianController.lua

module("logic.extensions.saintknighttian.controller.SaintKnightTianController", package.seeall)

local SaintKnightTianController = class("SaintKnightTianController", BaseController)

function SaintKnightTianController:onReset()
	self._clientKey = 0
	self._serverKey = 0
end

function SaintKnightTianController:onInit()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
end

function SaintKnightTianController:onRedPointChange()
	local redId = RedPointModel.ID_SAINTKNIGHT_TIAN_OPEN

	RedPointController.instance:setRedPointInfo(redId, false)

	if TLChallengeController.instance:isInOpenTime(SaintKnightTianModel.instance:getCurChallengeId()) and (SaintKnightTianModel.instance:getDailyOpen(ViewName.SaintKnightTianGuideView) or SaintKnightTianModel.instance:getDailyOpen(ViewName.SaintKnightTianChallengeView)) then
		RedPointController.instance:setRedPointInfo(redId, true)
	end
end

function SaintKnightTianController:getInfo(activityId)
	SaintKnightTianAgent.instance:sendPM_SaintKnightTianGetInfoReq(activityId)
end

function SaintKnightTianController:startStageBattle(activityId, stageId, fmo)
	local simpleForm = fmo:createFormPb()

	SaintKnightTianAgent.instance:sendPM_SaintKnightTianPlayStageReq(activityId, stageId, simpleForm)
end

function SaintKnightTianController:getPrize(activityId, prizeId)
	SaintKnightTianAgent.instance:sendPM_SaintKnightTianGetPrizeReq(activityId, prizeId)
end

function SaintKnightTianController:getGamePrize(activityId, prizeId)
	SaintKnightTianAgent.instance:sendPM_SaintKnightTianGetGamePrizeReq(activityId, prizeId)
end

function SaintKnightTianController:startGame()
	local clientKey = math.random(ServerTime.now())

	self._clientKey = clientKey

	SaintKnightTianAgent.instance:sendPM_SaintKnightTianStartGameReq(clientKey)
end

function SaintKnightTianController:settleGame(shovelNums)
	local key = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		shovelNums
	})

	SaintKnightTianAgent.instance:sendPM_SaintKnightTianEndGameReq(shovelNums, key)
end

function SaintKnightTianController:handleGetInfo(msg)
	SaintKnightTianModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTianUpdateInfo)
end

function SaintKnightTianController:handleGetPrize(msg)
	SaintKnightTianModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTianUpdateInfo)
end

function SaintKnightTianController:handleGetGamePrize(msg)
	SaintKnightTianModel.instance:onGetGamePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTianUpdateInfo)
end

function SaintKnightTianController:handleStartGame(msg)
	SaintKnightTianModel.instance:onStartGame(msg)

	self._serverKey = msg.serverKey

	GlobalDispatcher:dispatch(GlobalNotify.SKTianStartGame)
end

function SaintKnightTianController:handleSettleGame(msg)
	SaintKnightTianModel.instance:onSettleGame(msg)
	UIStateManager.instance:popByName(ViewName.SKTgameView)
	GlobalDispatcher:dispatch(GlobalNotify.SKTianUpdateInfo)
end

SaintKnightTianController.instance = SaintKnightTianController.New()

return SaintKnightTianController
