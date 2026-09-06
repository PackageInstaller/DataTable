-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/agent/TreasureBasinAgent.lua

module("logic.extensions.treasurebasin.agent.TreasureBasinAgent", package.seeall)

local TreasureBasinAgent = class("TreasureBasinAgent", BaseAgent)

function TreasureBasinAgent:sendPM_TreasureBasinGetInfoReq(activityId)
	local req = TreasureBasinExtension_pb.PM_TreasureBasinGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TreasureBasinAgent:handlePM_TreasureBasinGetInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadHeartMoneyCatInfo===back")

	if status == 0 then
		HeartMoneyCatController.instance:handlePM_TreasureBasinGetInfoRes(msg)
	end
end

function TreasureBasinAgent:sendPM_TreasureBasinMakeMoneyReq(activityId)
	local req = TreasureBasinExtension_pb.PM_TreasureBasinMakeMoneyReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TreasureBasinAgent:handlePM_TreasureBasinMakeMoneyRes(status, msg)
	if status == 0 then
		HeartMoneyCatController.instance:handlePM_TreasureBasinMakeMoneyRes(msg)
	end
end

TreasureBasinAgent.instance = TreasureBasinAgent.New()

return TreasureBasinAgent
