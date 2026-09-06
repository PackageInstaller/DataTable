-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/agent/MoYanPreheatAgent.lua

module("logic.extensions.catchprops.agent.MoYanPreheatAgent", package.seeall)

local MoYanPreheatAgent = class("MoYanPreheatAgent", BaseAgent)

function MoYanPreheatAgent:sendPM_MoYanPreheatGetInfoReq(activityId)
	local req = MoYanPreheatExtension_pb.PM_MoYanPreheatGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MoYanPreheatAgent:handlePM_MoYanPreheatGetInfoRes(status, msg)
	if status == 0 then
		CatchPropsController.instance:onMoYanPreheatGetInfo(msg)
	end
end

function MoYanPreheatAgent:sendPM_MoYanPreheatUnlockReq(activityId, zoneId)
	local req = MoYanPreheatExtension_pb.PM_MoYanPreheatUnlockReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function MoYanPreheatAgent:handlePM_MoYanPreheatUnlockRes(status, msg)
	if status == 0 then
		CatchPropsController.instance:onMoYanPreheatUnlock(msg)
	end
end

function MoYanPreheatAgent:sendPM_MoYanPreheatStartGameReq(activityId, clientKey)
	local req = MoYanPreheatExtension_pb.PM_MoYanPreheatStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function MoYanPreheatAgent:handlePM_MoYanPreheatStartGameRes(status, msg)
	if status == 0 then
		CatchPropsController.instance:onMoYanPreheatStartGame(msg)
	end
end

function MoYanPreheatAgent:sendPM_MoYanPreheatEndGameReq(fragransNum, encryptedKey)
	local req = MoYanPreheatExtension_pb.PM_MoYanPreheatEndGameReq()

	req.fragransNum = fragransNum
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function MoYanPreheatAgent:handlePM_MoYanPreheatEndGameRes(status, msg)
	if status == 0 then
		CatchPropsController.instance:onMoYanPreheatEndGame(msg)
	end
end

function MoYanPreheatAgent:sendPM_MoYanPreheatBuyTimesReq(activityId)
	local req = MoYanPreheatExtension_pb.PM_MoYanPreheatBuyTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MoYanPreheatAgent:handlePM_MoYanPreheatBuyTimesRes(status, msg)
	if status == 0 then
		CatchPropsController.instance:onMoYanPreheatBuyTimes(msg)
	end
end

MoYanPreheatAgent.instance = MoYanPreheatAgent.New()

return MoYanPreheatAgent
