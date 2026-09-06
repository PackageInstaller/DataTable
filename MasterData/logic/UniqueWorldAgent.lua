-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/agent/UniqueWorldAgent.lua

module("logic.extensions.uniqueworld.agent.UniqueWorldAgent", package.seeall)

local UniqueWorldAgent = class("UniqueWorldAgent", BaseAgent)

function UniqueWorldAgent:sendPM_UniqueWorldGetInfoReq(activityId)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldGetInfoRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldGetInfoRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldNewGameReq(activityId)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldNewGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldNewGameRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldNewGameRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldMoveReq(activityId, targetGridId)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldMoveReq()

	req.activityId = activityId
	req.targetGridId = targetGridId

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldMoveRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldMoveRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldDoEventReq(activityId, targetGridId, param)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldDoEventReq()

	req.activityId = activityId
	req.targetGridId = targetGridId
	req.param = param

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldDoEventRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldDoEventRes(msg)
	end
end

function UniqueWorldAgent:handlePM_UniqueWorldMapChangeRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldMapChangeRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldUseItemReq(activityId, itemId, param)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldUseItemReq()

	req.activityId = activityId
	req.itemId = itemId
	req.param = param

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldUseItemRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldUseItemRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldGiveUpReq(activityId)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldGiveUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldGiveUpRes(status, msg)
	if status == 0 then
		UniqueWorldController.instance:handlePM_UniqueWorldGiveUpRes(msg)
	end
end

function UniqueWorldAgent:sendPM_UniqueWorldFightReq(activityId, form, gridId)
	local req = UniqueWorldExtension_pb.PM_UniqueWorldFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.gridId = gridId

	self:sendMsg(req)
end

function UniqueWorldAgent:handlePM_UniqueWorldFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

UniqueWorldAgent.instance = UniqueWorldAgent.New()

return UniqueWorldAgent
