-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/agent/DressSellAgent.lua

module("logic.extensions.dressactivityshop.agent.DressSellAgent", package.seeall)

local DressSellAgent = class("DressSellAgent", BaseAgent)

function DressSellAgent:sendPM_DressSellGetInfoReq(activityId)
	local req = DressSellExtension_pb.PM_DressSellGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DressSellAgent:handlePM_DressSellGetInfoRes(status, msg)
	if status == 0 then
		DressSellController.instance:handleGetInfo(msg)
	end
end

function DressSellAgent:sendPM_DressSellBuyReq(activityId, id)
	local req = DressSellExtension_pb.PM_DressSellBuyReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function DressSellAgent:handlePM_DressSellBuyRes(status, msg)
	if status == 0 then
		DressSellController.instance:handleBuyGoods(msg)
	end
end

function DressSellAgent:handlePM_DressSellNotifySucRes(status, msg)
	if status == 0 then
		DressSellController.instance:handleBuySuc(msg)
	end
end

DressSellAgent.instance = DressSellAgent.New()

return DressSellAgent
