-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/agent/TutorActvityAgent.lua

module("logic.extensions.bonus.agent.TutorActvityAgent", package.seeall)

local TutorActvityAgent = class("TutorActvityAgent", BaseAgent)

function TutorActvityAgent:sendPM_TutorActivityFormInfoReq()
	local req = TutorActvityExtension_pb.PM_TutorActivityFormInfoReq()

	self:sendMsg(req)
end

function TutorActvityAgent:handlePM_TutorActivityFormInfoRes(status, msg)
	if status == 0 then
		local state = msg.state

		GlobalDispatcher:dispatch(GlobalNotify.UpdataTutorActivityInfo, state)
	end
end

function TutorActvityAgent:sendPM_TutorActivityGainFormPrizeReq()
	local req = TutorActvityExtension_pb.PM_TutorActivityGainFormPrizeReq()

	self:sendMsg(req)
end

function TutorActvityAgent:handlePM_TutorActivityGainFormPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataTutorActivityInfo, 2)
	end
end

TutorActvityAgent.instance = TutorActvityAgent.New()

return TutorActvityAgent
