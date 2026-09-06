-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/agent/DragonPoolAgent.lua

module("logic.extensions.dragonpool.agent.DragonPoolAgent", package.seeall)

local DragonPoolAgent = class("DragonPoolAgent", BaseAgent)

DragonPoolAgent.DragonPoolGetInfoRes = "DragonPoolAgent.DragonPoolGetInfoRes"
DragonPoolAgent.DragonPoolTouchRes = "DragonPoolAgent.DragonPoolTouchRes"
DragonPoolAgent.DragonPoolChatRes = "DragonPoolAgent.DragonPoolChatRes"
DragonPoolAgent.DragonPoolWeedRes = "DragonPoolAgent.DragonPoolWeedRes"
DragonPoolAgent.DragonPoolGainPrizeRes = "DragonPoolAgent.DragonPoolGainPrizeRes"
DragonPoolAgent.DragonPoolNextEggRes = "DragonPoolAgent.DragonPoolNextEggRes"

function DragonPoolAgent:sendPM_DragonPoolGetInfoReq(actId)
	local req = DragonPoolExtension_pb.PM_DragonPoolGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolGetInfoRes(status, msg)
	if status == 0 then
		DragonpoolModel.instance:setInfo(msg)
		DragonpoolController.instance:checkRedPoint()
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolGetInfoRes)
	end
end

function DragonPoolAgent:sendPM_DragonPoolTouchReq(actId)
	local req = DragonPoolExtension_pb.PM_DragonPoolTouchReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolTouchRes(status, msg)
	if status == 0 then
		DragonpoolModel.instance:onTouchRes(msg)
		DragonpoolController.instance:addMood(msg.actId, DragonpoolController.MoodType.Touch)
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolTouchRes)
	end
end

function DragonPoolAgent:sendPM_DragonPoolChatReq(actId)
	local req = DragonPoolExtension_pb.PM_DragonPoolChatReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolChatRes(status, msg)
	if status == 0 then
		DragonpoolModel.instance:onChatRes(msg)
		DragonpoolController.instance:addMood(msg.actId, DragonpoolController.MoodType.Chat)
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolChatRes)
	end
end

function DragonPoolAgent:sendPM_DragonPoolWeedReq(actId, grassId)
	local req = DragonPoolExtension_pb.PM_DragonPoolWeedReq()

	req.actId = actId
	req.grassId = grassId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolWeedRes(status, msg)
	if status == 0 then
		DragonpoolModel.instance:onDragonPoolWeed(msg)
		DragonpoolController.instance:addMood(msg.actId, DragonpoolController.MoodType.Weed)
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolWeedRes)
	end
end

function DragonPoolAgent:sendPM_DragonPoolGainPrizeReq(actId, prizeId)
	local req = DragonPoolExtension_pb.PM_DragonPoolGainPrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolGainPrizeRes(status, msg)
	if status == 0 then
		DragonpoolController.instance:onGainPrize(msg.prizeId)
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolGainPrizeRes)
	end
end

function DragonPoolAgent:sendPM_DragonPoolNextEggReq(actId)
	local req = DragonPoolExtension_pb.PM_DragonPoolNextEggReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonPoolAgent:handlePM_DragonPoolNextEggRes(status, msg)
	if status == 0 then
		DragonpoolModel.instance:onDragonPoolNextEgg(msg)
		GlobalDispatcher:dispatch(DragonPoolAgent.DragonPoolNextEggRes)
	end
end

DragonPoolAgent.instance = DragonPoolAgent.New()

return DragonPoolAgent
