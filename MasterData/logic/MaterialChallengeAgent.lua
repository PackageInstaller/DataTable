-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/agent/MaterialChallengeAgent.lua

module("logic.extensions.materialchallenge.agent.MaterialChallengeAgent", package.seeall)

local MaterialChallengeAgent = class("MaterialChallengeAgent", BaseAgent)

MaterialChallengeAgent.MCLG_InfoRes = "MaterialChallengeAgent_MCLG_InfoRes"
MaterialChallengeAgent.MCLG_ChallengeRes = "MaterialChallengeAgent_MCLG_ChallengeRes"
MaterialChallengeAgent.MCLG_DailyTaskRewardRes = "MaterialChallengeAgent_MCLG_DailyTaskRewardRes"
MaterialChallengeAgent.MCLG_OneKeyDailyTaskRewardRes = "MaterialChallengeAgent_MCLG_OneKeyDailyTaskRewardRes"
MaterialChallengeAgent.MCLG_SweepsByTimesRes = "MaterialChallengeAgent_MCLG_SweepsByTimesRes"
MaterialChallengeAgent.MCLG_SimpleProgressInfoRes = "MaterialChallengeAgent_MCLG_SimpleProgressInfoRes"
MaterialChallengeAgent.MCLG_ChallengeBalanceRes = "MaterialChallengeAgent_MCLG_ChallengeBalanceRes"
MaterialChallengeAgent.MCLG_BuyChallengeTimesRes = "MaterialChallengeAgent_MCLG_BuyChallengeTimesRes"
MaterialChallengeAgent.MCLG_NotifyAfterChallengeRes = "MaterialChallengeAgent_MCLG_NotifyAfterChallengeRes"
MaterialChallengeAgent.MCLG_GetRewardMultiplyTimesRes = "MaterialChallengeAgent_MCLG_GetRewardMultiplyTimesRes"

function MaterialChallengeAgent:ctor()
	return
end

function MaterialChallengeAgent:setExtId(extId)
	MaterialChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MaterialChallengeAgent:sendMCLG_InfoReq(typeId, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_InfoReq()

	req.typeId = typeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_InfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_InfoRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_InfoRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_ChallengeReq(typeId, stageId, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_ChallengeReq()

	req.typeId = typeId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_ChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_ChallengeRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_ChallengeRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_DailyTaskRewardReq(typeId, index, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_DailyTaskRewardReq()

	req.typeId = typeId
	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_DailyTaskRewardRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_DailyTaskRewardRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_DailyTaskRewardRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_OneKeyDailyTaskRewardReq(typeId, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_OneKeyDailyTaskRewardReq()

	req.typeId = typeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_OneKeyDailyTaskRewardRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_OneKeyDailyTaskRewardRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_OneKeyDailyTaskRewardRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_SweepsByTimesReq(typeId, stageId, times, useTicket, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_SweepsByTimesReq()

	req.typeId = typeId
	req.stageId = stageId
	req.times = times
	req.useTicket = useTicket

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_SweepsByTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_SweepsByTimesRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_SweepsByTimesRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_SimpleProgressInfoReq(handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_SimpleProgressInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_SimpleProgressInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_SimpleProgressInfoRes(status, msg)
	forcePrint("MaterialChallengeAgent.handleMCLG_SimpleProgressInfoRes===", status)
	self:dispatch(MaterialChallengeAgent.MCLG_SimpleProgressInfoRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_ChallengeBalanceReq(balance, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_ChallengeBalanceReq()

	req.balance = balance

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_ChallengeBalanceRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_ChallengeBalanceRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_ChallengeBalanceRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_BuyChallengeTimesReq(typeId, handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_BuyChallengeTimesReq()

	req.typeId = typeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_BuyChallengeTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_BuyChallengeTimesRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_BuyChallengeTimesRes, status, msg)
end

function MaterialChallengeAgent:handleMCLG_NotifyAfterChallengeRes(status, msg)
	self:dispatch(MaterialChallengeAgent.MCLG_NotifyAfterChallengeRes, status, msg)
end

function MaterialChallengeAgent:sendMCLG_GetRewardMultiplyTimesReq(handler, handlerObj, errHandler)
	local req = MaterialChallengeExtension_pb.MCLG_GetRewardMultiplyTimesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialChallengeAgent.MCLG_GetRewardMultiplyTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialChallengeAgent:handleMCLG_GetRewardMultiplyTimesRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadMaterialChallenge===back")
	self:dispatch(MaterialChallengeAgent.MCLG_GetRewardMultiplyTimesRes, status, msg)
end

function MaterialChallengeAgent:handleMCLG_NotifyBaseMultiplyTimesChangeRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onNotifyBaseMultiplyTimesChangeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_NotifyBaseMultiplyTimesChangeRes)
	end
end

MaterialChallengeAgent.instance = MaterialChallengeAgent.New()

return MaterialChallengeAgent
