-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/agent/DragonKingARuiShiHUDAgent.lua

module("logic.extensions.dragonkingaruishihud.agent.DragonKingARuiShiHUDAgent", package.seeall)

local DragonKingARuiShiHUDAgent = class("DragonKingARuiShiHUDAgent", BaseAgent)

function DragonKingARuiShiHUDAgent:sendDragonKingARuiShiHUDInfoReq(activityId)
	local req = DragonKingARuiShiHUDExtension_pb.DragonKingARuiShiHUDInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonKingARuiShiHUDAgent:handleDragonKingARuiShiHUDInfoRes(status, msg)
	if status == 0 then
		DragonKingARuiShiHUDController.instance:handleGetInfo(msg)
	end
end

function DragonKingARuiShiHUDAgent:sendDragonKingARuiShiHUDGainPrizeReq(activityId)
	local req = DragonKingARuiShiHUDExtension_pb.DragonKingARuiShiHUDGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonKingARuiShiHUDAgent:handleDragonKingARuiShiHUDGainPrizeRes(status, msg)
	if status == 0 then
		DragonKingARuiShiHUDController.instance:handleGainPrize(msg)
	end
end

DragonKingARuiShiHUDAgent.instance = DragonKingARuiShiHUDAgent.New()

return DragonKingARuiShiHUDAgent
