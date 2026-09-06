-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/controller/FruitNinjaController.lua

module("logic.extensions.fruitninja.controller.FruitNinjaController", package.seeall)

local FruitNinjaController = class("FruitNinjaController", BaseController)

function FruitNinjaController:onInit()
	return
end

function FruitNinjaController:onReset()
	GlobalDispatcher:addListener("gotostartfruitninjagame", self.gotoStartFruitNinjaGame, self)
end

function FruitNinjaController:sendPM_FruitNinjaGetInfoReq(activityId)
	FruitNinjaAgent.instance:sendPM_FruitNinjaGetInfoReq(activityId)
end

function FruitNinjaController:handlePM_FruitNinjaGetInfoRes(msg)
	local mo = self:getFruitNinjaMo(msg.activityId)

	mo:handlePM_FruitNinjaGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FruitNinjaGetInfoRes)
end

function FruitNinjaController:sendPM_FruitNinjaStartGameReq(activityId, mode)
	local clientKey = MmUtil.createClientKey()
	local mo = self:getFruitNinjaMo(activityId)

	mo:setClientKey(clientKey)
	FruitNinjaAgent.instance:sendPM_FruitNinjaStartGameReq(activityId, mode, clientKey)
end

function FruitNinjaController:handlePM_FruitNinjaStartGameRes(status, msg)
	if status == 0 then
		local mo = self:getFruitNinjaMo(msg.activityId)

		mo:handlePM_FruitNinjaStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FruitNinjaStartGameRes, status, msg)
end

function FruitNinjaController:sendPM_FruitNinjaEndGameReq(activityId, mode, score)
	local mo = self:getFruitNinjaMo(activityId)
	local encryptedKey = mo:getEncryptedKey(mode, score)

	FruitNinjaAgent.instance:sendPM_FruitNinjaEndGameReq(activityId, mode, score, encryptedKey)
end

function FruitNinjaController:handlePM_FruitNinjaEndGameRes(msg)
	local mo = self:getFruitNinjaMo(msg.activityId)

	mo:handlePM_FruitNinjaEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FruitNinjaEndGameRes)
end

function FruitNinjaController:sendPM_FruitNinjaGainPrizeReq(activityId, prizeId)
	FruitNinjaAgent.instance:sendPM_FruitNinjaGainPrizeReq(activityId, prizeId)
end

function FruitNinjaController:handlePM_FruitNinjaGainPrizeRes(msg)
	local mo = self:getFruitNinjaMo(msg.activityId)

	mo:handlePM_FruitNinjaGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FruitNinjaGainPrizeRes)
end

function FruitNinjaController:sendPM_FruitNinjaViewRankReq(activityId)
	FruitNinjaAgent.instance:sendPM_FruitNinjaViewRankReq(activityId)
end

function FruitNinjaController:handlePM_FruitNinjaViewRankRes(msg)
	local mo = self:getFruitNinjaMo(msg.activityId)

	mo:handlePM_FruitNinjaViewRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FruitNinjaViewRankRes, msg)
end

function FruitNinjaController:getFruitNinjaMo(activityId)
	return FruitNinjaModel.instance:getFruitNinjaMo(activityId)
end

function FruitNinjaController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function FruitNinjaController:getActivityType()
	return GameEnum.ActivityType.FruitNinja
end

function FruitNinjaController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function FruitNinjaController:gotoStartFruitNinjaGame(params)
	local activityId = checknumber(params[1])
	local mode = checknumber(params[2])

	self:startFruitNinjaGame(activityId, mode)
end

function FruitNinjaController:startFruitNinjaGame(activityId, mode)
	local result = self:getTryStartFruitNinjaResultAndTips(true, activityId, mode)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_FruitNinjaStartGameRes, self._handlePM_FruitNinjaStartGameRes, self)
	FruitNinjaController.instance:sendPM_FruitNinjaStartGameReq(activityId, mode)
end

function FruitNinjaController:_handlePM_FruitNinjaStartGameRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_FruitNinjaStartGameRes, self._handlePM_FruitNinjaStartGameRes, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId
	local mode = msg.mode
	local gamePlanId = 0
	local data = FruitNinjaConfig.instance:getActData(activityId)

	if mode == FruitNinjaEnum.GameMode_Nor then
		gamePlanId = data.norGamePlanId
	elseif mode == FruitNinjaEnum.GameMode_Ext then
		gamePlanId = data.exGamePlanId
	end

	local gameParam = FruitNinjaGameParam.New()

	gameParam:setGamePlanId(gamePlanId)
	gameParam:setMaxTotalScoreLimit(data.oneGameMaxScore)

	if activityId <= 0 then
		local planData = FruitNinjaConfig.instance:getGamePlanData(gamePlanId)

		if planData then
			if not planData.defaultCriticalRate then
				local rate = 0

				gameParam:setDefaultCriticalRate(rate)
			end
		end
	else
		local mo = self:getFruitNinjaMo(activityId)
		local criticalData = FruitNinjaConfig.instance:getCriticalDataByScore(activityId, mo:getHistoryMaxScore(FruitNinjaEnum.GameMode_Ext))

		if criticalData then
			if not criticalData.rate then
				local rate = 0

				gameParam:setDefaultCriticalRate(rate)
			end
		end
	end

	gameParam:setGameEndCallBack(function(result, view)
		if result == MmUtil.GameResult_GameOverOfSuccess or result == MmUtil.GameResult_GameOverOfFail then
			local score = view:getScore()

			FruitNinjaController.instance:sendPM_FruitNinjaEndGameReq(activityId, mode, score)

			local tipsContent = string.format("恭喜您，本次获得%s分", score)

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
			end

			TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
		elseif result == MmUtil.GameResult_GameOverOfDropOut then
			local mo = self:getFruitNinjaMo(activityId)
			local maxScore = mo:getHistoryMaxScore(mode)
			local score = view:getScore()

			if mode == FruitNinjaEnum.GameMode_Nor then
				local tipsContent = string.format("当前分数：<color=#20b376>%s</color>\n历史最高分：<color=#20b376>%s</color>\n\n是否确认退出游戏？\n<color=#20b376>退出不消耗次数，无法获得积分。</color>", score, maxScore)

				local function okFunc()
					FruitNinjaController.instance:sendPM_FruitNinjaEndGameReq(activityId, mode, 0)
					GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
				end

				local function cencelFunc()
					GlobalDispatcher:dispatch(GlobalNotify.GameCancelCloseView)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
			else
				local tipsContent = string.format("当前分数：<color=#20b376>%s</color>\n历史最高分：<color=#20b376>%s</color>\n\n是否确认退出游戏？\n<color=#20b376>退出将进行游戏结算。</color>", score, maxScore)

				local function okFunc()
					FruitNinjaController.instance:sendPM_FruitNinjaEndGameReq(activityId, mode, score)
					GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
				end

				local function cencelFunc()
					GlobalDispatcher:dispatch(GlobalNotify.GameCancelCloseView)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
			end
		elseif result == MmUtil.GameResult_GameOverFailAndReset then
			-- block empty
		else
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end
	end)
	self:enterFruitNinjaGame(gameParam)
end

function FruitNinjaController:getTryStartFruitNinjaResultAndTips(isPopTips, activityId, mode)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	local mo = self:getFruitNinjaMo(activityId)

	if mode == FruitNinjaEnum.GameMode_Nor then
		local left = mo:getLeftNormalGameTimes()

		if left <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "剩余游戏次数不足"
		end
	elseif mode == FruitNinjaEnum.GameMode_Ext then
		-- block empty
	else
		result = GameEnum.ResultCode.Error
		tips = "非法模式"
	end

	if isPopTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function FruitNinjaController:enterFruitNinjaGame(gameParam)
	UIStateManager.instance:push(ViewName.FruitNinjaSceneView, gameParam)
end

FruitNinjaController.instance = FruitNinjaController.New()

return FruitNinjaController
