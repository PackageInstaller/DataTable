-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/agent/FireWorksDisplayAgent.lua

module("logic.extensions.fireworksdisplay.agent.FireWorksDisplayAgent", package.seeall)

local pTable = {}
local wTable = {}
local FireWorksDisplayAgent = class("FireWorksDisplayAgent", BaseAgent)

function FireWorksDisplayAgent:sendPM_FireWorksDisplayGetInfoReq(activityId)
	local req = FireWorksDisplayExtension_pb.PM_FireWorksDisplayGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FireWorksDisplayAgent:handlePM_FireWorksDisplayGetInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestFireWorksInfo===back")

	if status == 0 then
		FireworkModel.instance:getInfos(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FIREWORK_GETINFO)
	end
end

function FireWorksDisplayAgent:sendPM_FireWorksDisplaySetOffReq(activityId, timeId, npcId)
	local req = FireWorksDisplayExtension_pb.PM_FireWorksDisplaySetOffReq()

	req.activityId = activityId
	req.timeId = timeId
	req.npcId = npcId

	self:sendMsg(req)
end

function FireWorksDisplayAgent:handlePM_FireWorksDisplaySetOffRes(status, msg)
	if status == 0 then
		FireworkModel.instance:updateInfos(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FIREWORK_GETINFO)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FIREWORK_FIREONE, msg)
	end
end

function FireWorksDisplayAgent:sendPM_FireWorksDisplayGainNormalPrizeReq(activityId, index)
	local req = FireWorksDisplayExtension_pb.PM_FireWorksDisplayGainNormalPrizeReq()

	req.activityId = activityId
	req.index = index

	table.insert(pTable, index)
	self:sendMsg(req)
end

function FireWorksDisplayAgent:handlePM_FireWorksDisplayGainNormalPrizeRes(status, msg)
	local index = table.remove(pTable, 1)

	if status == 0 then
		FireworkModel.instance:updateNormalPrizeids(index)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FIREWORK_GETINFO)
	end
end

function FireWorksDisplayAgent:sendPM_FireWorksDisplayGainWorldPrizeReq(activityId, index)
	local req = FireWorksDisplayExtension_pb.PM_FireWorksDisplayGainWorldPrizeReq()

	req.activityId = activityId
	req.index = index

	table.insert(wTable, index)
	self:sendMsg(req)
end

function FireWorksDisplayAgent:handlePM_FireWorksDisplayGainWorldPrizeRes(status, msg)
	local index = table.remove(wTable, 1)

	if status == 0 then
		FireworkModel.instance:updateWorldPrizeids(index)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FIREWORK_GETPRIZE)
	end
end

FireWorksDisplayAgent.instance = FireWorksDisplayAgent.New()

return FireWorksDisplayAgent
