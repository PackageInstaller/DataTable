-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threematchesgame/agent/ThreeMatchesGameAgent.lua

module("logic.extensions.threematchesgame.agent.ThreeMatchesGameAgent", package.seeall)

local ThreeMatchesGameAgent = class("ThreeMatchesGameAgent", BaseAgent)

ThreeMatchesGameAgent.InfoRes = "ThreeMatchesGameAgent.InfoRes"

function ThreeMatchesGameAgent:sendPM_ThreeMatchesGameInfoReq(activityId)
	local req = ThreeMatchesGameExtension_pb.PM_ThreeMatchesGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeMatchesGameAgent:handlePM_ThreeMatchesGameInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(ThreeMatchesGameAgent.PM_ThreeMatchesGameInfoRes, msg)
	end
end

ThreeMatchesGameAgent.instance = ThreeMatchesGameAgent.New()

return ThreeMatchesGameAgent
