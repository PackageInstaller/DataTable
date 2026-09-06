-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/controller/IceQibuGameController.lua

module("logic.extensions.iceqibugame.controller.IceQibuGameController", package.seeall)

local IceQibuGameController = class("IceQibuGameController", BaseController)

function IceQibuGameController:onInit()
	return
end

function IceQibuGameController:onReset()
	return
end

function IceQibuGameController:sendPM_IceQibuGameInfoReq(activityId)
	IceQibuGameAgent.instance:sendPM_IceQibuGameInfoReq(activityId)
end

function IceQibuGameController:handlePM_IceQibuGameInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IceQibuGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IceQibuGameInfoRes)
end

function IceQibuGameController:sendPM_IceQibuGameStartGameReq(activityId)
	local mo = self:getSubMo(activityId)
	local clientKey = MmUtil.createClientKey()

	mo:setClientKey(clientKey)
	IceQibuGameAgent.instance:sendPM_IceQibuGameStartGameReq(activityId, clientKey)
end

function IceQibuGameController:handlePM_IceQibuGameStartGameRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_IceQibuGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IceQibuGameStartGameRes, status, msg)
end

function IceQibuGameController:sendPM_IceQibuGameEndGameReq(activityId, costTime, stageId, isPassStage)
	local mo = self:getSubMo(activityId)
	local encryptedKey = mo:getEncryptedKey(costTime)

	IceQibuGameAgent.instance:sendPM_IceQibuGameEndGameReq(activityId, costTime, encryptedKey, stageId, isPassStage)
end

function IceQibuGameController:handlePM_IceQibuGameEndGameRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IceQibuGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IceQibuGameEndGameRes, msg)
end

function IceQibuGameController:sendPM_IceQibuGameSweepReq(activityId, sweepTimes)
	IceQibuGameAgent.instance:sendPM_IceQibuGameSweepReq(activityId, sweepTimes)
end

function IceQibuGameController:handlePM_IceQibuGameSweepRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IceQibuGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IceQibuGameSweepRes)
end

function IceQibuGameController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.IceQibuGame)
end

function IceQibuGameController:getSubMo(activityId)
	return IceQibuGameModel.instance:getSubMo(activityId)
end

function IceQibuGameController:startGame(activityId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_IceQibuGameStartGameRes, self._handlePM_IceQibuGameStartGameRes, self)
	IceQibuGameController.instance:sendPM_IceQibuGameStartGameReq(activityId)
end

function IceQibuGameController:_handlePM_IceQibuGameStartGameRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_IceQibuGameStartGameRes, self._handlePM_IceQibuGameStartGameRes, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local stageData = IceQibuGameConfig.instance:getStageData(activityId, stageId)
	local mapId = stageData.mapId
	local gameParam = IceQibuGameParam.New()

	gameParam:setMapId(mapId)
	gameParam:setGameEndCallBack(function(result, view)
		if result == MmUtil.GameResult_GameOverOfSuccess then
			local costTime = view:getCostTime()

			UIStateManager.instance:push(ViewName.IceQiBuGameResultView, activityId, costTime, stageId, true)
		elseif result == MmUtil.GameResult_GameOverOfFail then
			local costTime = view:getCostTime()

			UIStateManager.instance:push(ViewName.IceQiBuGameResultView, activityId, costTime, stageId, false)
		elseif result == MmUtil.GameResult_GameOverOfDropOut then
			local costTime = view:getCostTime()
			local tipsContent = "中途退出不消耗游戏次数，是否确认？"

			local function okFunc()
				IceQibuGameController.instance:sendPM_IceQibuGameEndGameReq(activityId, costTime, stageId, false)
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverFailAndReset then
			-- block empty
		end
	end)
	self:_enterIceQibuGame(gameParam)
end

function IceQibuGameController:startTestGame(mapId)
	local gameParam = IceQibuGameParam.New()

	gameParam:setMapId(mapId)
	gameParam:setGameEndCallBack(function(result, view)
		if result == MmUtil.GameResult_GameOverOfSuccess then
			local costTime = view:getCostTime()
			local tipsContent = string.format("胜利\n用时%s秒", costTime)

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverOfFail then
			local costTime = view:getCostTime()
			local tipsContent = string.format("胜利\n用时%s秒", costTime)

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverOfDropOut then
			local costTime = view:getCostTime()
			local tipsContent = "中途退出不消耗游戏次数，是否确认？"

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverFailAndReset then
			-- block empty
		end
	end)
	self:_enterIceQibuGame(gameParam)
end

function IceQibuGameController:_enterIceQibuGame(gameParam)
	UIStateManager.instance:push(ViewName.IceQiBuGameSceneView, gameParam)
end

IceQibuGameController.instance = IceQibuGameController.New()

return IceQibuGameController
