-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/agent/DarkDragonAgent.lua

module("logic.extensions.sunranbattle.agent.DarkDragonAgent", package.seeall)

local DarkDragonAgent = class("DarkDragonAgent", BaseAgent)

function DarkDragonAgent:sendPM_DarkDragonInfoReq()
	local req = DarkDragonExtension_pb.PM_DarkDragonInfoReq()

	self:sendMsg(req)
end

function DarkDragonAgent:handlePM_DarkDragonInfoRes(status, msg)
	if status ~= 0 or msg == nil or msg.stages == nil then
		print("sr---挑战    DarkDragonAgent:handlePM_DarkDragonInfoRes   下发 主信息 有误！！")

		return
	end

	SunranBattleController.instance:scSendDarkDragonInfo(msg.stages)
end

function DarkDragonAgent:sendPM_DarkDragonStageInfoReq(stageId)
	local req = DarkDragonExtension_pb.PM_DarkDragonStageInfoReq()

	req.stageId = stageId

	self:sendMsg(req)
end

function DarkDragonAgent:handlePM_DarkDragonStageInfoRes(status, msg)
	if status == 0 then
		SunranBattleController.instance:scSendDarkDragonStageInfo(msg)
	end
end

function DarkDragonAgent:sendPM_DarkDragonChallengeReq(stageId, groupIds)
	local req = DarkDragonExtension_pb.PM_DarkDragonChallengeReq()

	req.stageId = stageId

	if groupIds and #groupIds > 0 then
		for i = 1, #groupIds do
			local groups = req.optionGroups:add()

			groups.optionId = groupIds[i].optionId
			groups.optionGroup = groupIds[i].optionGroup
		end
	end

	self:sendMsg(req)
end

function DarkDragonAgent:handlePM_DarkDragonChallengeRes(status, msg)
	if status ~= 0 and ViewMgr.instance:isOpen(ViewName.SRMission) then
		UIStateManager.instance:clear(true)
	end
end

function DarkDragonAgent:handlePM_NotifyChallengeEndRes(status, msg)
	if status == 0 then
		SunranBattleController.instance:scSendNotifyChallengeEnd(msg)
	end
end

function DarkDragonAgent:sendPM_DarkDragonRankInfoReq(stageId)
	local req = DarkDragonExtension_pb.PM_DarkDragonRankInfoReq()

	req.stageId = stageId

	self:sendMsg(req)
end

function DarkDragonAgent:handlePM_DarkDragonRankInfoRes(status, msg)
	if status == 0 then
		SunranBattleController.instance:scSendDarkDragonRankInfo(msg)
	end
end

DarkDragonAgent.instance = DarkDragonAgent.New()

return DarkDragonAgent
