-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/controller/LioncultureController.lua

module("logic.extensions.lionculture.controller.LioncultureController", package.seeall)

local LioncultureController = class("LioncultureController", BaseController)

function LioncultureController:ctor()
	return
end

function LioncultureController:onInit()
	GlobalDispatcher:addListener(WakingLionGameAgent.handlePM_WakingLionGameStartGameRes, self.handlePM_WakingLionGameStartGameRes, self)
end

function LioncultureController:onReset()
	return
end

function LioncultureController:sendPM_LioncultureGetInfoReq()
	WakingLionGameAgent.instance:sendPM_WakingLionGameGetInfoReq(LioncultureModel.instance.activityId)
end

function LioncultureController:sendPM_WakingLionGameStartGameReq(gameId)
	local clientKey = math.random(ServerTime.now())

	WakingLionGameAgent.instance:sendPM_WakingLionGameStartGameReq(LioncultureModel.instance.activityId, gameId, clientKey)
end

function LioncultureController:handlePM_WakingLionGameStartGameRes(clientkey, serverkey)
	self._clientKey = clientkey
	self._serverKey = serverkey
end

function LioncultureController:sendPM_WakingLionGameEndGameReq(gameId, settleValue)
	local key = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		settleValue
	})

	WakingLionGameAgent.instance:sendPM_WakingLionGameEndGameReq(LioncultureModel.instance.activityId, gameId, "", settleValue, key)
end

function LioncultureController:sendPM_WakingLionGameGainPrizeReq(gameId)
	WakingLionGameAgent.instance:sendPM_WakingLionGameGainPrizeReq(LioncultureModel.instance.activityId, gameId)
end

function LioncultureController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function LioncultureController:getActivityType()
	return GameEnum.ActivityType.LionCulture
end

function LioncultureController:enterBattleAsCorPr(activityId, gameId)
	UIJumper.instance:pushOneStack(ViewName.LioncultureView)

	local customFmtMo = LioncultureModel.instance:getCustomFmtMoAsLionCulture()

	customFmtMo:updateCfg(activityId, gameId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

LioncultureController.instance = LioncultureController.New()

return LioncultureController
