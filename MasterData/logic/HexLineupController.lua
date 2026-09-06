-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/controller/HexLineupController.lua

module("logic.extensions.hexlineup.controller.HexLineupController", package.seeall)

local HexLineupController = class("HexLineupController", BaseController)

function HexLineupController:onInit()
	return
end

function HexLineupController:onReset()
	return
end

function HexLineupController:sendPM_HexLineupGetInfoReq(activityId)
	HexLineupAgent.instance:sendPM_HexLineupGetInfoReq(activityId)
end

function HexLineupController:handlePM_HexLineupGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_HexLineupGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupGetInfoRes)
end

function HexLineupController:sendPM_HexLineupStartGameReq(activityId, modeId)
	local subMo = self:getSubMo(activityId)
	local clientKey = MmUtil.createClientKey()

	subMo:setClientKey(clientKey)
	HexLineupAgent.instance:sendPM_HexLineupStartGameReq(activityId, modeId, clientKey)
end

function HexLineupController:handlePM_HexLineupStartGameRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_HexLineupStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupStartGameRes, status, msg)
end

function HexLineupController:sendPM_HexLineupEndGameReq(activityId, modeId, score)
	local subMo = self:getSubMo(activityId)
	local encryptedKey = subMo:getEncryptedKey(modeId, score)

	HexLineupAgent.instance:sendPM_HexLineupEndGameReq(activityId, modeId, score, encryptedKey)
end

function HexLineupController:handlePM_HexLineupEndGameRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_HexLineupEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupEndGameRes)
end

function HexLineupController:sendPM_HexLineupGainPrizeReq(activityId, prizeIds)
	HexLineupAgent.instance:sendPM_HexLineupGainPrizeReq(activityId, prizeIds)
end

function HexLineupController:handlePM_HexLineupGainPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_HexLineupGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupGainPrizeRes)
end

function HexLineupController:sendPM_HexLineupSweepReq(activityId, sweepTimes)
	HexLineupAgent.instance:sendPM_HexLineupSweepReq(activityId, sweepTimes)
end

function HexLineupController:handlePM_HexLineupSweepRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_HexLineupSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupSweepRes)
end

function HexLineupController:sendPM_HexLineupRankViewReq(activityId)
	HexLineupAgent.instance:sendPM_HexLineupRankViewReq(activityId)
end

function HexLineupController:handlePM_HexLineupRankViewRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_HexLineupRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HexLineupRankViewRes, msg)
end

function HexLineupController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.HexLineup)
end

function HexLineupController:getSubMo(activityId)
	return HexLineupModel.instance:getSubMo(activityId)
end

function HexLineupController:startGame(activityId, modeId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_HexLineupStartGameRes, self._handleStartGameRes, self)
	HexLineupController.instance:sendPM_HexLineupStartGameReq(activityId, modeId)
end

function HexLineupController:_handleStartGameRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_HexLineupStartGameRes, self._handleStartGameRes, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId
	local modeId = msg.modeId
	local actData = HexLineupConfig.instance:getActivityData(activityId)
	local gamePlanId = checknumber(actData.gamePlanIdArray[modeId])
	local gameData = HexLineupConfig.instance:getGameData(gamePlanId)

	if gameData == nil then
		printError(string.format("错误，六角消消乐尝试进入未配置gameData的游戏方案( activityId:%s, modeId:%s, gamePlanId:%s )", activityId, modeId, gamePlanId))
	end

	local gameParam = HexLineupParam.New()

	gameParam:setModeId(modeId)
	gameParam:setGamePlanId(gamePlanId)

	if modeId == HexLineupEnum.ModeId_Limit then
		gameParam:setGameEndCallBack(function(result, view)
			local subMo = self:getSubMo(activityId)
			local score = view:getScore()

			if result == MmUtil.GameResult_GameOverOfSuccess or result == MmUtil.GameResult_GameOverOfFail then
				local leftTimesAfterSave = Mathf.Max(0, subMo:getLeftDailyTimes() - 1)
				local tipsContent = string.format("本次积分：%s\n是否保存本次游戏结果？\n保存后今日游戏次数-1，当前剩余次数%s次", score, leftTimesAfterSave)

				local function okFunc()
					HexLineupController.instance:sendPM_HexLineupEndGameReq(activityId, modeId, score)
					GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
				end

				local function cencelFunc()
					HexLineupController.instance:sendPM_HexLineupEndGameReq(activityId, modeId, 0)
					GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
			elseif result == MmUtil.GameResult_GameOverOfDropOut then
				local tipsContent = string.format("当前积分：%s\n是否退出？\n退出后不消耗游戏次数，不保存当前状态", score)

				local function okFunc()
					HexLineupController.instance:sendPM_HexLineupEndGameReq(activityId, modeId, 0)
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
	elseif modeId == HexLineupEnum.ModeId_Endless then
		gameParam:setGameEndCallBack(function(result, view)
			local subMo = self:getSubMo(activityId)
			local score = view:getScore()

			if result == MmUtil.GameResult_GameOverOfSuccess or result == MmUtil.GameResult_GameOverOfFail then
				local tipsContent = string.format("本次积分：%s", score)

				local function okFunc()
					HexLineupController.instance:sendPM_HexLineupEndGameReq(activityId, modeId, score)
					GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
				end

				TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
			elseif result == MmUtil.GameResult_GameOverOfDropOut then
				local tipsContent = string.format("当前积分：%s\n是否退出？\n退出后直接以当前积分作为最终成绩", score)

				local function okFunc()
					HexLineupController.instance:sendPM_HexLineupEndGameReq(activityId, modeId, score)
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
	end

	self:_enterHexLineupGame(gameParam)
end

function HexLineupController:_enterHexLineupGame(gameParam)
	UIStateManager.instance:push(ViewName.HexLineupSceneView, gameParam)
end

function HexLineupController:startTestGame(modeId, gamePlanId)
	local gameData = HexLineupConfig.instance:getGameData(gamePlanId)

	if gameData == nil then
		printError(string.format("错误，六角消消乐尝试进入未配置gameData的游戏方案( modeId:%s, gamePlanId:%s )", modeId, gamePlanId))

		return
	end

	local gameParam = HexLineupParam.New()

	gameParam:setModeId(modeId)
	gameParam:setGamePlanId(gamePlanId)
	gameParam:setGameEndCallBack(function(result, view)
		local score = view:getScore()

		if result == MmUtil.GameResult_GameOverOfSuccess or result == MmUtil.GameResult_GameOverOfFail then
			local tipsContent = string.format("游戏结束，本次获得%s积分", score)

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverOfDropOut then
			local tipsContent = "中途退出不消耗游戏次数，无法获得积分奖励，是否确认离开？"

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
	self:_enterHexLineupGame(gameParam)
end

HexLineupController.instance = HexLineupController.New()

return HexLineupController
