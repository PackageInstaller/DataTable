-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/agent/TimeWheelAgent.lua

module("logic.extensions.timewheel.agent.TimeWheelAgent", package.seeall)

local TimeWheelAgent = class("TimeWheelAgent", BaseAgent)

TimeWheelAgent.PM_TimeWheelDecomposeRes = "TimeWheelAgent_PM_TimeWheelDecomposeRes"
TimeWheelAgent.PM_TimeWheelResetRes = "TimeWheelAgent_PM_TimeWheelResetRes"
TimeWheelAgent.PM_TimeWheelRevertRes = "TimeWheelAgent_PM_TimeWheelRevertRes"
TimeWheelAgent.PM_TimeWheelGetDecomposeWhenLotteryRes = "TimeWheelAgent_PM_TimeWheelGetDecomposeWhenLotteryRes"
TimeWheelAgent.PM_TimeWheelSetDecomposeWhenLotteryRes = "TimeWheelAgent_PM_TimeWheelSetDecomposeWhenLotteryRes"
TimeWheelAgent.PM_TimeWheelGetResetStrengthenInfoRes = "TimeWheelAgent_PM_TimeWheelGetResetStrengthenInfoRes"
TimeWheelAgent.PM_DecomposeOverFlowPetRes = "TimeWheelAgent_PM_DecomposeOverFlowPetRes"
TimeWheelAgent.PM_DecomposeOverFlowItemRes = "TimeWheelAgent_PM_DecomposeOverFlowItemRes"
TimeWheelAgent.PM_DecomposeOverFlowPetBatchRes = "TimeWheelAgent_PM_DecomposeOverFlowPetBatchRes"

function TimeWheelAgent:ctor()
	return
end

function TimeWheelAgent:setExtId(extId)
	TimeWheelAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimeWheelAgent:sendPM_TimeWheelDecomposeReq(petIds_i32_Ary, handler, handlerObj, errHandler)
	local req = TimeWheelExtension_pb.PM_TimeWheelDecomposeReq()

	for i, v1 in ipairs(petIds_i32_Ary) do
		req.petIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeWheelAgent.PM_TimeWheelDecomposeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelDecomposeRes(status, msg)
	self:dispatch(TimeWheelAgent.PM_TimeWheelDecomposeRes, status, msg)
end

function TimeWheelAgent:sendPM_TimeWheelResetReq(petId, handler, handlerObj, errHandler)
	local req = TimeWheelExtension_pb.PM_TimeWheelResetReq()

	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeWheelAgent.PM_TimeWheelResetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelResetRes(status, msg)
	self:dispatch(TimeWheelAgent.PM_TimeWheelResetRes, status, msg)
end

function TimeWheelAgent:sendPM_TimeWheelRevertReq(petId, handler, handlerObj, errHandler)
	local req = TimeWheelExtension_pb.PM_TimeWheelRevertReq()

	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeWheelAgent.PM_TimeWheelRevertRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelRevertRes(status, msg)
	self:dispatch(TimeWheelAgent.PM_TimeWheelRevertRes, status, msg)
end

function TimeWheelAgent:sendPM_TimeWheelGetDecomposeWhenLotteryReq()
	local req = TimeWheelExtension_pb.PM_TimeWheelGetDecomposeWhenLotteryReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelGetDecomposeWhenLotteryRes(status, msg)
	if status == 0 then
		TimeWheelController.instance:handlePM_TimeWheelGetDecomposeWhenLotteryRes(msg)
	end
end

function TimeWheelAgent:sendPM_TimeWheelSetDecomposeWhenLotteryReq(rare, isDecompose)
	local req = TimeWheelExtension_pb.PM_TimeWheelSetDecomposeWhenLotteryReq()
	local info = TimeWheelExtension_pb.PM_TimeWheelDecomposeSwitch()

	info.rare = rare
	info.isDecompose = isDecompose

	req.switch:ParseFromString(info:SerializeToString())

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelSetDecomposeWhenLotteryRes(status, msg)
	if status == 0 then
		TimeWheelController.instance:handlePM_TimeWheelSetDecomposeWhenLotteryRes(msg)
	end
end

function TimeWheelAgent:sendPM_TimeWheelGetResetStrengthenInfoReq(handler, handlerObj, errHandler)
	local req = TimeWheelExtension_pb.PM_TimeWheelGetResetStrengthenInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeWheelAgent.PM_TimeWheelGetResetStrengthenInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeWheelAgent:handlePM_TimeWheelGetResetStrengthenInfoRes(status, msg)
	self:dispatch(TimeWheelAgent.PM_TimeWheelGetResetStrengthenInfoRes, status, msg)
end

function TimeWheelAgent:sendPM_DecomposeOverFlowPetBatchReq(petId, items)
	local req = TimeWheelExtension_pb.PM_DecomposeOverFlowPetBatchReq()

	if petId ~= nil then
		for i, v in ipairs(petId) do
			req.petId:append(v)
		end
	end

	if items ~= nil then
		for i, v in ipairs(items) do
			local item = req.items:add()

			item.itemId = v.itemId
			item.num = v.num
		end
	end

	self:sendMsg(req)
end

function TimeWheelAgent:handlePM_DecomposeOverFlowPetBatchRes(status, msg)
	self:dispatch(TimeWheelAgent.PM_DecomposeOverFlowPetBatchRes, status, msg)
end

TimeWheelAgent.instance = TimeWheelAgent.New()

return TimeWheelAgent
