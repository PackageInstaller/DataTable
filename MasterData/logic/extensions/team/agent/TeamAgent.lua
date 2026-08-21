-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/agent/TeamAgent.lua

module("logic.extensions.team.agent.TeamAgent", package.seeall)

local TeamAgent = class("TeamAgent", BaseAgent)

function TeamAgent:ctor()
	TeamAgent.super.ctor(self)
end

function TeamAgent:sendLoadTeamsRequest()
	local req = TeamEditExtension_pb.LoadTeamsRequest()

	self:sendMsg(req)
end

function TeamAgent:sendEditTeamNameRequest(teamid, name)
	local req = TeamEditExtension_pb.EditTeamNameRequest()

	req.tid = teamid
	req.name = name

	self:sendMsg(req)
end

function TeamAgent:sendUnlockTeamRequest(teamid)
	local req = TeamEditExtension_pb.UnlockTeamRequest()

	req.tid = teamid

	self:sendMsg(req)
end

function TeamAgent:sendSaveTeamRoleRequest(teamid, teamname, roles)
	local req = TeamEditExtension_pb.SaveTeamRoleRequest()

	req.team.tid = teamid
	req.team.teamName = teamname

	for idx, v in ipairs(roles) do
		local cell = TeamEditExtension_pb.TeamCell()

		cell.gid = idx
		cell.uuid = v

		table.insert(req.team.roles, cell)
	end

	self:sendMsg(req)
end

function TeamAgent:sendDeleteTeamRequest(teamId)
	local req = TeamEditExtension_pb.DeleteTeamRequest()

	req.tid = teamId

	self:sendMsg(req)
end

function TeamAgent:handleDeleteTeamReply(status, msg)
	if status == 0 then
		TeamModel.instance:removeTeam(msg.tid)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_TEAM_INFO)
	end
end

function TeamAgent:handleTeamsInfoReply(status, msg)
	if status == 0 then
		TeamModel.instance:refreshTeamData(msg)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_TEAM_INFO)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_TEAM_MAIN_VIEW)
	end
end

TeamAgent.instance = TeamAgent.New()

return TeamAgent
