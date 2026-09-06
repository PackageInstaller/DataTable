-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/data/FruitNinjaGameParam.lua

module("logic.extensions.fruitninja.data.FruitNinjaGameParam", package.seeall)

local FruitNinjaGameParam = class("FruitNinjaGameParam")

function FruitNinjaGameParam:ctor()
	self:onReset()
end

function FruitNinjaGameParam:onReset()
	self._gameMode = FruitNinjaEnum.GameMode_Nor
	self._activityId = 0
	self._gamePlanId = 1
	self._defaultCriticalRate = 0
	self._gameEndCallBack = nil
	self._maxTotalScoreLimit = -1
end

function FruitNinjaGameParam:getGamePlanId()
	return self._gamePlanId
end

function FruitNinjaGameParam:setGamePlanId(value)
	self._gamePlanId = value
end

function FruitNinjaGameParam:getDefaultCriticalRate()
	return self._defaultCriticalRate
end

function FruitNinjaGameParam:setDefaultCriticalRate(value)
	self._defaultCriticalRate = value
end

function FruitNinjaGameParam:getMaxTotalScoreLimit()
	return self._maxTotalScoreLimit
end

function FruitNinjaGameParam:setMaxTotalScoreLimit(value)
	self._maxTotalScoreLimit = value
end

function FruitNinjaGameParam:getGameMode()
	return self._gameMode
end

function FruitNinjaGameParam:setGameMode(gameMode)
	self._gameMode = gameMode
end

function FruitNinjaGameParam:doGameEndCallBack(result, gameCtrl)
	if self._gameEndCallBack then
		return GameUtil.callBack(self._gameEndCallBack, result, gameCtrl)
	else
		return self:_defaultGameEndCallBack(result, gameCtrl)
	end
end

function FruitNinjaGameParam:setGameEndCallBack(callBack)
	self._gameEndCallBack = callBack
end

function FruitNinjaGameParam:_defaultGameEndCallBack(result, gameCtrl)
	if result == MmUtil.GameResult_GameOverOfSuccess then
		local tipsContent = "游戏胜利"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
	elseif result == MmUtil.GameResult_GameOverOfFail then
		local tipsContent = "游戏失败"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
	elseif result == MmUtil.GameResult_GameOverOfDropOut then
		local tipsContent = "退出进度无法保留，是否退出？"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
		end

		local function cencelFunc()
			GlobalDispatcher:dispatch(GlobalNotify.GameCancelCloseView)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	elseif result == MmUtil.GameResult_GameOverFailAndReset then
		GlobalDispatcher:dispatch(GlobalNotify.GameResetProcess)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
	end
end

function FruitNinjaGameParam:isTestMode()
	return self._isTestMode
end

function FruitNinjaGameParam:setIsTestMode(isTestMode)
	self._isTestMode = isTestMode
end

return FruitNinjaGameParam
