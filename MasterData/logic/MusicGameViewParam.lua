-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/data/MusicGameViewParam.lua

module("logic.extensions.musicgame.data.MusicGameViewParam", package.seeall)

local MusicGameViewParam = class("MusicGameViewParam")

function MusicGameViewParam:ctor()
	self:onReset()
end

function MusicGameViewParam:onReset()
	self._stageId = 1
	self._isTestMode = false
	self._gameEndCallBack = nil
end

function MusicGameViewParam:getStageId()
	return self._stageId
end

function MusicGameViewParam:setStageId(value)
	self._stageId = value
end

function MusicGameViewParam:isTestMode()
	return self._isTestMode
end

function MusicGameViewParam:setIsTestMode(isTestMode)
	self._isTestMode = isTestMode
end

function MusicGameViewParam:doGameEndCallBack(gameEndRes, stageId)
	if self._gameEndCallBack then
		return GameUtil.callBack(self._gameEndCallBack, gameEndRes, stageId)
	else
		return self:_defaultGameEndCallBack(gameEndRes, stageId)
	end
end

function MusicGameViewParam:setGameEndCallBack(callBack)
	self._gameEndCallBack = callBack
end

function MusicGameViewParam:_defaultGameEndCallBack(gameEndRes, stageId)
	if gameEndRes == MusicGameEnum.GameEndRes_Exit then
		local tipsContent = "是否退出游戏？"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Close)
		end

		local function cencelFunc()
			GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Continue)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	elseif gameEndRes == MusicGameEnum.GameEndRes_Finish then
		local tipsContent = "游戏完成"

		local function okFunc()
			GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Close)
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	end
end

return MusicGameViewParam
