-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/controller/JigsawcollectController.lua

module("logic.extensions.jigsawcollect.controller.JigsawcollectController", package.seeall)

local JigsawcollectController = class("JigsawcollectController", BaseController)

JigsawcollectController.PM_GetCurJigsawInfoRes = "JigsawcollectController.PM_GetCurJigsawInfoRes"
JigsawcollectController.PM_GainJigsawTaskPrizeRes = "JigsawcollectController.PM_GainJigsawTaskPrizeRes"
JigsawcollectController.PM_GainJigsawCollectPrizeRes = "JigsawcollectController.PM_GainJigsawCollectPrizeRes"
JigsawcollectController.PM_UnlockJigsawPieceRes = "JigsawcollectController.PM_UnlockJigsawPieceRes"
JigsawcollectController.PlayCloseColorEggViewEffect = "JigsawcollectController.PlayCloseColorEggViewEffect"
JigsawcollectController.PlayGetLastChipEffect = "JigsawcollectController.PlayGetLastChipEffect"

function JigsawcollectController:ctor()
	return
end

function JigsawcollectController:onInit()
	GlobalDispatcher:addListener(JigsawAgent.PM_GetCurJigsawInfoRes, self._PM_GetCurJigsawInfoRes, self)
	GlobalDispatcher:addListener(JigsawAgent.PM_GainJigsawTaskPrizeRes, self._PM_GainJigsawTaskPrizeRes, self)
	GlobalDispatcher:addListener(JigsawAgent.PM_GainJigsawCollectPrizeRes, self._PM_GainJigsawCollectPrizeRes, self)
	GlobalDispatcher:addListener(JigsawAgent.PM_UnlockJigsawPieceRes, self._PM_UnlockJigsawPieceRes, self)
	self:onReset()
end

function JigsawcollectController:onReset()
	return
end

function JigsawcollectController:openView()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.JigsawCollect)

	if cfg then
		UIStateManager.instance:push(ViewName.JigsawcollectmainView, cfg.activityId)
	else
		FloatWordMgr.instance:show("不在活动开放时间内")
	end
end

function JigsawcollectController:_PM_GetCurJigsawInfoRes(status, msg)
	if status == 0 then
		JigsawcollectModel.instance:setActInfo(msg)
	end

	GlobalDispatcher:dispatch(JigsawcollectController.PM_GetCurJigsawInfoRes, status, msg)
end

function JigsawcollectController:_PM_GainJigsawTaskPrizeRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("奖励领取成功")
		JigsawcollectModel.instance:getTaskPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(JigsawcollectController.PM_GainJigsawTaskPrizeRes, status, msg)
end

function JigsawcollectController:_PM_GainJigsawCollectPrizeRes(status, msg)
	if status == 0 then
		JigsawcollectModel.instance:gainJigsawCollectPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(JigsawcollectController.PM_GainJigsawCollectPrizeRes, status, msg)
end

function JigsawcollectController:_PM_UnlockJigsawPieceRes(status, msg)
	if status == 0 then
		JigsawcollectModel.instance:unlockJigsawPieceRes(msg)
	end

	GlobalDispatcher:dispatch(JigsawcollectController.PM_UnlockJigsawPieceRes, status, msg)
end

JigsawcollectController.instance = JigsawcollectController.New()

return JigsawcollectController
