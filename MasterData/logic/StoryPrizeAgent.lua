-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storyprize/agent/StoryPrizeAgent.lua

module("logic.extensions.storyprize.agent.StoryPrizeAgent", package.seeall)

local StoryPrizeAgent = class("StoryPrizeAgent", BaseAgent)

function StoryPrizeAgent:sendPM_StoryPrizeInfoReq(storyId)
	local req = StoryPrizeExtension_pb.PM_StoryPrizeInfoReq()

	req.storyId = storyId

	self:sendMsg(req)
end

function StoryPrizeAgent:handlePM_StoryPrizeInfoRes(status, msg)
	if status == 0 then
		StoryPrizeController.instance:handlePM_StoryPrizeInfoRes(msg)
	end
end

function StoryPrizeAgent:sendPM_StoryPrizeGainPrizeReq(storyId)
	local req = StoryPrizeExtension_pb.PM_StoryPrizeGainPrizeReq()

	req.storyId = storyId

	self:sendMsg(req)
end

function StoryPrizeAgent:handlePM_StoryPrizeGainPrizeRes(status, msg)
	if status == 0 then
		StoryPrizeController.instance:handlePM_StoryPrizeGainPrizeRes(msg)
	end
end

function StoryPrizeAgent:sendPM_StoryPrizeTotalInfoReq()
	local req = StoryPrizeExtension_pb.PM_StoryPrizeTotalInfoReq()

	self:sendMsg(req)
end

function StoryPrizeAgent:handlePM_StoryPrizeTotalInfoRes(status, msg)
	if status == 0 then
		StoryPrizeController.instance:handlePM_StoryPrizeTotalInfoRes(msg)
	end
end

StoryPrizeAgent.instance = StoryPrizeAgent.New()

return StoryPrizeAgent
