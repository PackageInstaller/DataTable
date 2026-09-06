-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/agent/ShowOffRankAgent.lua

module("logic.extensions.showoffrank.agent.ShowOffRankAgent", package.seeall)

local ShowOffRankAgent = class("ShowOffRankAgent", BaseAgent)

function ShowOffRankAgent:sendPM_ShowOffRankViewReq(rankId, member)
	local req = ShowOffRankExtension_pb.PM_ShowOffRankViewReq()

	req.rankId = rankId

	if member ~= nil then
		req.member = member
	end

	self:sendMsg(req)
end

function ShowOffRankAgent:handlePM_ShowOffRankViewRes(status, msg)
	if status == 0 then
		ShowOffRankController.instance:onGetRankInfo(msg)
	end
end

ShowOffRankAgent.instance = ShowOffRankAgent.New()

return ShowOffRankAgent
