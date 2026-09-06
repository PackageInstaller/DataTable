-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/controller/RedLotusDinnerPartyController.lua

module("logic.extensions.redlotusdinnerparty.controller.RedLotusDinnerPartyController", package.seeall)

local RedLotusDinnerPartyController = class("RedLotusDinnerPartyController", BaseController)

function RedLotusDinnerPartyController:ctor()
	RedLotusDinnerPartyController.super.ctor(self)
end

function RedLotusDinnerPartyController:onInit()
	GlobalDispatcher:addListener("open_redlotusgala_view", self._onOpenView, self)
	self:onReset()
end

function RedLotusDinnerPartyController:onReset()
	return
end

function RedLotusDinnerPartyController:_onOpenView()
	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
	local actCfg = RedLotusDinnerPartyConfig.instance:getActivityCfgById(activityId) or {}
	local performPlanId = actCfg.performPlanId
	local performCfgList = RedLotusDinnerPartyConfig.instance:getPerformPlanCfgList(performPlanId) or {}
	local idx = 0

	for i, v in ipairs(performCfgList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			idx = i - 1

			if v.handler == "threeMatches" then
				UIStateManager.instance:push(ViewName.RedlotussxgameprepareView)
			elseif v.handler == "oneStrokeDrawing" then
				UIStateManager.instance:push(ViewName.RedlotusonetouchprepareView)
			end

			return
		end
	end

	TipsFacade.instance:openCommonTips("当前活动不在活动时间内")
end

function RedLotusDinnerPartyController:sendGetInfo(actId, gameId)
	RedLotusGalaAgent.instance:sendPM_RedLotusGalaGetInfoReq(actId, gameId)
end

function RedLotusDinnerPartyController:onGetInfo(msg)
	RedLotusDinnerPartyModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_RedLotusGalaGetInfoRes)
end

function RedLotusDinnerPartyController:sendStartGame(actId, gameId, stageId)
	local clientKey = math.random(1, 100000000)

	RedLotusGalaAgent.instance:sendPM_RedLotusGalaStartGameReq(actId, gameId, stageId, clientKey)

	return clientKey
end

function RedLotusDinnerPartyController:onStartGame(msg)
	local clientKey = msg.clientKey
	local serverKey = msg.serverKey
	local actId = msg.actId
	local gameId = msg.gameId
	local stageId = msg.stageId

	GlobalDispatcher:dispatch(GlobalNotify.PM_RedLotusGalaStartGameRes, clientKey, serverKey, actId, gameId, stageId)
end

function RedLotusDinnerPartyController:sendEndGame(actId, gameId, isPass, score, clientKey, serverKey)
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		gameId,
		isPass
	})

	RedLotusGalaAgent.instance:sendPM_RedLotusGalaEndGameReq(actId, gameId, isPass, score, encryptedKey)
end

function RedLotusDinnerPartyController:onEndGame(msg)
	return
end

function RedLotusDinnerPartyController:sendGainPrize(actId, gameId, prizeId)
	RedLotusGalaAgent.instance:sendPM_RedLotusGalaGainPrizeReq(actId, gameId, prizeId)
end

function RedLotusDinnerPartyController:onGainPrize(msg)
	RedLotusDinnerPartyModel.instance:updateGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_RedLotusGalaGainPrizeRes)
end

function RedLotusDinnerPartyController:sendBuyTimes(actId, gameId)
	RedLotusGalaAgent.instance:sendPM_RedLotusGalaBuyTimesReq(actId, gameId)
end

function RedLotusDinnerPartyController:onBuyTimes(msg)
	RedLotusDinnerPartyModel.instance:updateBuyTimes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_RedLotusGalaBuyTimesRes)
end

RedLotusDinnerPartyController.instance = RedLotusDinnerPartyController.New()

return RedLotusDinnerPartyController
