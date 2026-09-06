-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/agent/YuanXiaoKingsExchangeAgent.lua

module("logic.extensions.collecttangyuan.agent.YuanXiaoKingsExchangeAgent", package.seeall)

local YuanXiaoKingsExchangeAgent = class("YuanXiaoKingsExchangeAgent", BaseAgent)

YuanXiaoKingsExchangeAgent.taskId = nil

function YuanXiaoKingsExchangeAgent:sendPM_KingsExchangeGetInfoReq(activityId)
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CollectTangyuan)

	if cfg == nil or cfg.activityId == nil then
		return
	end

	local req = YuanXiaoKingsExchangeExtension_pb.PM_KingsExchangeGetInfoReq()

	req.activityId = cfg.activityId

	self:sendMsg(req)
end

function YuanXiaoKingsExchangeAgent:handlePM_KingsExchangeGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataCollectTangyuanInfo, msg)
	end
end

function YuanXiaoKingsExchangeAgent:sendPM_KingsExchangeGetPrizeReq(activityId, groupId, prizeId)
	local req = YuanXiaoKingsExchangeExtension_pb.PM_KingsExchangeGetPrizeReq()

	req.activityId = activityId
	req.groupId = groupId

	for i = 1, #prizeId do
		req.prizeId:append(prizeId[i])
	end

	self:sendMsg(req)
end

function YuanXiaoKingsExchangeAgent:handlePM_KingsExchangeGetPrizeRes(status, msg)
	if status == 0 then
		self:sendPM_KingsExchangeGetInfoReq()
	end
end

function YuanXiaoKingsExchangeAgent:sendPM_KingsExchangeSelectListReq(activityId, groupId, prizeId)
	local req = YuanXiaoKingsExchangeExtension_pb.PM_KingsExchangeSelectListReq()

	req.activityId = activityId
	req.groupId = groupId

	for i = 1, #prizeId do
		req.prizeId:append(prizeId[i])
	end

	self:sendMsg(req)
end

function YuanXiaoKingsExchangeAgent:handlePM_KingsExchangeSelectListRes(status, msg)
	if status == 0 then
		self:sendPM_KingsExchangeGetInfoReq()
	end
end

function YuanXiaoKingsExchangeAgent:sendPM_KingsExchangeTaskGainReq(activityId, taskId)
	local req = YuanXiaoKingsExchangeExtension_pb.PM_KingsExchangeTaskGainReq()

	req.activityId = activityId
	req.taskId = taskId
	YuanXiaoKingsExchangeAgent.taskId = taskId

	self:sendMsg(req)
end

function YuanXiaoKingsExchangeAgent:handlePM_KingsExchangeTaskGainRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataCollectTangyuanTask, YuanXiaoKingsExchangeAgent.taskId)

		YuanXiaoKingsExchangeAgent.taskId = nil
	end
end

YuanXiaoKingsExchangeAgent.instance = YuanXiaoKingsExchangeAgent.New()

return YuanXiaoKingsExchangeAgent
