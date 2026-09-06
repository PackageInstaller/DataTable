-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/agent/TimeGateAgent.lua

module("logic.extensions.timegate.agent.TimeGateAgent", package.seeall)

local TimeGateAgent = class("TimeGateAgent", BaseAgent)

function TimeGateAgent:onInit()
	self:onReset()
end

function TimeGateAgent:onReset()
	self._selectOpenReqQueue = {}
end

function TimeGateAgent:sendPM_TimeGateInfoReq()
	local req = TimeGateExtension_pb.PM_TimeGateInfoReq()

	self:sendMsg(req)
end

function TimeGateAgent:handlePM_TimeGateInfoRes(status, msg)
	if status == 0 then
		TimeGateModel.instance:onTimeGateInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TimeGateInfoRes)
	end
end

function TimeGateAgent:sendPM_TimeGateSelectOpenReq(type, raceId)
	local req = TimeGateExtension_pb.TimeGateSelectOpenItem()

	req.type = type
	req.raceId = raceId

	self:sendMultiPM_TimeGateSelectOpenReq({
		req
	})
end

function TimeGateAgent:sendMultiPM_TimeGateSelectOpenReq(items_pb_Ary)
	local req = TimeGateExtension_pb.PM_TimeGateSelectOpenReq()
	local pendingItems = {}

	if items_pb_Ary ~= nil then
		for i, v1 in ipairs(items_pb_Ary) do
			local items = req.items:add()

			items:ParseFromString(v1:SerializeToString())
			table.insert(pendingItems, {
				type = checknumber(v1.type),
				raceId = checknumber(v1.raceId)
			})
		end
	end

	self._selectOpenReqQueue = self._selectOpenReqQueue or {}

	table.insert(self._selectOpenReqQueue, pendingItems)
	self:sendMsg(req)
end

function TimeGateAgent:handlePM_TimeGateSelectOpenRes(status, msg)
	local pendingItems = table.remove(self._selectOpenReqQueue or {}, 1)

	if (status == nil or status == 0) and pendingItems then
		TimeGateModel.instance:onTimeGateSelectOpenBatchRes(pendingItems)
	elseif status == nil or status == 0 then
		printWarn("[TimeGateAgent] PM_TimeGateSelectOpenRes missing pending request items")
	end

	GlobalDispatcher:dispatch(GlobalNotify.TimeGateSelectOpenRes, status, msg)
end

TimeGateAgent.instance = TimeGateAgent.New()

return TimeGateAgent
