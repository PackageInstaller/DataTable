-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/data/IceQibuGameParam.lua

module("logic.extensions.iceqibugame.data.IceQibuGameParam", package.seeall)

local IceQibuGameParam = class("IceQibuGameParam")

function IceQibuGameParam:ctor()
	self:onReset()
end

function IceQibuGameParam:onReset()
	self._mapId = 1
	self._gameEndCallBack = nil
end

function IceQibuGameParam:getMapId()
	return self._mapId
end

function IceQibuGameParam:setMapId(value)
	self._mapId = value
end

function IceQibuGameParam:doGameEndCallBack(result, params)
	if self._gameEndCallBack then
		return GameUtil.callBack(self._gameEndCallBack, result, params)
	else
		return self:_defaultGameEndCallBack(result, params)
	end
end

function IceQibuGameParam:setGameEndCallBack(callBack)
	self._gameEndCallBack = callBack
end

function IceQibuGameParam:_defaultGameEndCallBack(result, params)
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

return IceQibuGameParam
