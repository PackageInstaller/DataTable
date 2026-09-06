-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/ui/NPGViewParam.lua

module("logic.extensions.numberpuzzlegame.view.ui.NPGViewParam", package.seeall)

local NPGViewParam = class("NPGViewParam")

function NPGViewParam:ctor()
	self:onReset()
end

function NPGViewParam:onReset()
	self._activityId = 0
	self._gameMode = NPGEnum.GameMode_Ext
	self._mapId = 0
	self._isTestMode = false
	self._gameEndCallBack = nil
	self._maxTotalScoreLimit = -1
	self._startUpEnergy = 0
	self._exData = nil
end

function NPGViewParam:getActivityId()
	return self._activityId
end

function NPGViewParam:setActivityId(activityId)
	self._activityId = activityId
end

function NPGViewParam:getMaxTotalScoreLimit()
	return self._maxTotalScoreLimit
end

function NPGViewParam:setMaxTotalScoreLimit(value)
	self._maxTotalScoreLimit = value
end

function NPGViewParam:getStartUpEnergy()
	return self._startUpEnergy
end

function NPGViewParam:setStartUpEnergy(value)
	self._startUpEnergy = value
end

function NPGViewParam:getGameMode()
	return self._gameMode
end

function NPGViewParam:setGameMode(gameMode)
	self._gameMode = gameMode
end

function NPGViewParam:getMapId()
	return self._mapId
end

function NPGViewParam:setMapId(mapId)
	self._mapId = mapId
end

function NPGViewParam:doGameEndCallBack(result, gameCtrl)
	if self._gameEndCallBack then
		return GameUtil.callBack(self._gameEndCallBack, result, gameCtrl)
	else
		return self:_defaultGameEndCallBack(result, gameCtrl)
	end
end

function NPGViewParam:setGameEndCallBack(callBack)
	self._gameEndCallBack = callBack
end

function NPGViewParam:_defaultGameEndCallBack(result, gameCtrl)
	if result == NPGEnum.ResultCode_GameOverOfSuccess then
		local tipsContent = "游戏胜利"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	elseif result == NPGEnum.ResultCode_GameOverOfFail then
		local tipsContent = "游戏失败"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	elseif result == NPGEnum.ResultCode_GameOverOfDropOut then
		local tipsContent = "退出进度将得到保留，是否退出？"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end

		local function cencelFunc()
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	elseif result == NPGEnum.ResultCode_GameOverFailAndReset then
		GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
	else
		GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
	end
end

function NPGViewParam:isTestMode()
	return self._isTestMode
end

function NPGViewParam:setIsTestMode(isTestMode)
	self._isTestMode = isTestMode
end

return NPGViewParam
