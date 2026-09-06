-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/controller/IdiomChainController.lua

module("logic.extensions.idiomchain.controller.IdiomChainController", package.seeall)

local IdiomChainController = class("IdiomChainController", BaseController)

function IdiomChainController:onInit()
	return
end

function IdiomChainController:onReset()
	return
end

function IdiomChainController:sendPM_IdiomChainInfoReq(activityId)
	IdiomChainAgent.instance:sendPM_IdiomChainInfoReq(activityId)
end

function IdiomChainController:handlePM_IdiomChainInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IdiomChainInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IdiomChainInfoRes)
end

function IdiomChainController:sendPM_IdiomChainGameStartReq(activityId, difficultId)
	local subMo = self:getSubMo(activityId)
	local clientKey = MmUtil.createClientKey()

	subMo:setClientKey(clientKey)
	IdiomChainAgent.instance:sendPM_IdiomChainGameStartReq(activityId, difficultId, clientKey)
end

function IdiomChainController:handlePM_IdiomChainGameStartRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_IdiomChainGameStartRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IdiomChainGameStartRes, status, msg)
end

function IdiomChainController:sendPM_IdiomChainGameEndReq(activityId, difficultId, isPass, gameTime)
	local subMo = self:getSubMo(activityId)
	local encryptedKey = subMo:getEncryptedKey(isPass, gameTime)

	IdiomChainAgent.instance:sendPM_IdiomChainGameEndReq(activityId, difficultId, isPass, gameTime, encryptedKey)
end

function IdiomChainController:handlePM_IdiomChainGameEndRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IdiomChainGameEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IdiomChainGameEndRes)
end

function IdiomChainController:sendPM_IdiomChainGainPrizeReq(activityId, prizeId)
	IdiomChainAgent.instance:sendPM_IdiomChainGainPrizeReq(activityId, prizeId)
end

function IdiomChainController:handlePM_IdiomChainGainPrizeRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_IdiomChainGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_IdiomChainGainPrizeRes)
end

function IdiomChainController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.IdiomChain)
end

function IdiomChainController:getSubMo(activityId)
	return IdiomChainModel.instance:getSubMo(activityId)
end

function IdiomChainController:startGame(activityId, difficultId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_IdiomChainGameStartRes, self._handleStartGameRes, self)
	IdiomChainController.instance:sendPM_IdiomChainGameStartReq(activityId, difficultId)
end

function IdiomChainController:_handleStartGameRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_IdiomChainGameStartRes, self._handleStartGameRes, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId
	local difficultId = msg.difficultId
	local difficultData = IdiomChainConfig.instance:getDifficultData(activityId, difficultId)
	local gamePlanId = difficultData.gamePlanId
	local gameParam = IdiomChainParam.New()

	gameParam:setGamePlanId(gamePlanId)
	gameParam:setGameEndCallBack(function(result, view)
		local gameTime = view:getGameTime()

		if result == MmUtil.GameResult_GameOverOfSuccess or result == MmUtil.GameResult_GameOverOfFail then
			UIStateManager.instance:push(ViewName.IdiomChainResultView, activityId, difficultId, gameTime)
			IdiomChainController.instance:sendPM_IdiomChainGameEndReq(activityId, difficultId, true, gameTime)
		elseif result == MmUtil.GameResult_GameOverOfDropOut then
			local tipsContent = "中途退出不消耗游戏次数，无法获得积分奖励，是否确认离开？"

			local function okFunc()
				IdiomChainController.instance:sendPM_IdiomChainGameEndReq(activityId, difficultId, false, 0)
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
	self:_enterIdiomChainGame(gameParam)
end

function IdiomChainController:_enterIdiomChainGame(gameParam)
	UIStateManager.instance:push(ViewName.IdiomChainMainView, gameParam)
end

IdiomChainController.instance = IdiomChainController.New()

return IdiomChainController
