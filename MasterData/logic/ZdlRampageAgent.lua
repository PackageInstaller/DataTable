-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/agent/ZdlRampageAgent.lua

module("logic.extensions.bonus.agent.ZdlRampageAgent", package.seeall)

local ZdlRampageAgent = class("ZdlRampageAgent", BaseAgent)

function ZdlRampageAgent:sendPM_GetZdlRampageCompetitionReq(actId)
	local req = ZdlRampageCompetition_pb.PM_GetZdlRampageCompetitionReq()

	req.actId = actId

	self:sendMsg(req)

	self._curZoneId = nil
end

function ZdlRampageAgent:handlePM_GetZdlRampageCompetitionRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataPowerSurgeInfo, msg)
	end
end

function ZdlRampageAgent:sendPM_ZdlRampageCompetitionGainPrizeReq(actId, index)
	local req = ZdlRampageCompetition_pb.PM_ZdlRampageCompetitionGainPrizeReq()

	req.actId = actId
	req.index = index

	self:sendMsg(req)
end

function ZdlRampageAgent:handlePM_ZdlRampageCompetitionGainPrizeRes(status, msg)
	if status ~= 0 then
		return
	end

	local actCfg = PowerSurgeConfig.instance:getOpenActivityCfg()

	if actCfg == nil then
		return
	end

	self:sendPM_GetZdlRampageCompetitionReq(actCfg.activityId)
end

function ZdlRampageAgent:sendPM_ZdlRampageCompetitionRankReq(actId, id)
	local req = ZdlRampageCompetition_pb.PM_ZdlRampageCompetitionRankReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function ZdlRampageAgent:handlePM_ZdlRampageCompetitionRankRes(status, msg)
	if status == 0 then
		local id = msg.id

		RankModel.instance:setRankData(msg, GameEnum.RankType.PowerSurgeRank, id)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PowerSurgeRankDataGetError, status)
	end
end

ZdlRampageAgent.instance = ZdlRampageAgent.New()

return ZdlRampageAgent
