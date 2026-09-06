-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/agent/CommonRankAgent.lua

module("logic.extensions.commonrank.agent.CommonRankAgent", package.seeall)

local json = require("cjson")
local CommonRankAgent = class("CommonRankAgent", BaseAgent)

function CommonRankAgent:sendPM_MaxZdlRankGetInfoReq(rankType, startRank, endRank)
	local req = CommonRankExtension_pb.PM_MaxZdlRankGetInfoReq()

	req.rankType = rankType
	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function CommonRankAgent:handlePM_MaxZdlRankGetInfoRes(status, msg)
	if status == 0 then
		local ranklist = msg.rankList
		local ranksize = msg.rankSize
		local myRank = msg.myRank
		local newMsg = {}
		local t = {}

		for _, v in ipairs(ranklist) do
			table.insert(t, json.decode(v))
		end

		newMsg.rankList = t
		newMsg.rankSize = ranksize
		newMsg.myRank = myRank
		newMsg.userId = msg.userId

		RankModel.instance:setRankData(newMsg, GameEnum.RankType.MaxPower, msg.rankType)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function CommonRankAgent:sendPM_GetFirstPassRankViewReq(activityId)
	local req = CommonRankExtension_pb.PM_GetFirstPassRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CommonRankAgent:handlePM_GetFirstPassRankViewRes(status, msg)
	if status == 0 then
		UltimateTrialController.instance:handlePM_GetFirstPassRankViewRes(msg)
	end
end

CommonRankAgent.instance = CommonRankAgent.New()

return CommonRankAgent
