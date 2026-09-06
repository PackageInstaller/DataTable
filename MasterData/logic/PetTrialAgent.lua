-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/agent/PetTrialAgent.lua

module("logic.extensions.pettrial.agent.PetTrialAgent", package.seeall)

local PetTrialAgent = class("PetTrialAgent", BaseAgent)

function PetTrialAgent:sendGetMyTrialInfoReq()
	local req = PetTrialExtension_pb.GetMyTrialInfoReq()

	self:sendMsg(req)
end

function PetTrialAgent:handleGetMyTrialInfoRes(status, msg)
	if status == 0 then
		PetTrialModel.instance:handleGetMyTrialInfo(msg)
		PetTrialController.instance:localNotify("GetMyTrialInfo")
	end
end

function PetTrialAgent:sendTrialReq(stageId, teamId)
	local req = PetTrialExtension_pb.TrialReq()

	self._cacheStageId = stageId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function PetTrialAgent:handleTrialRes(status, msg)
	if status == 0 then
		local iswin = msg.isWin

		PetTrialModel.instance:handleTrialRes(msg)
		print("real iswin = " .. tostring(iswin))

		if not PetTrialModel.instance:getIsClearAll(self._cacheStageId) then
			-- block empty
		end
	end
end

function PetTrialAgent:sendTrialSweepReq(stageId)
	local req = PetTrialExtension_pb.TrialSweepReq()

	req.stageId = stageId

	self:sendMsg(req)
end

function PetTrialAgent:handleTrialSweepRes(status, msg)
	if status == 0 then
		local hassweeptimes = msg.leftSweepTimes

		PetTrialModel.instance:setSweepTimes(hassweeptimes)
		PetTrialController.instance:localNotify("TrialSweepFinished")
	end
end

function PetTrialAgent:showChangeSet(changeSetId, name)
	if name == "handleTrialRes" then
		printInfo("精灵试炼 设置 changeSetId", changeSetId)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		PetTrialAgent.super.showChangeSet(self, changeSetId, name)
	end
end

PetTrialAgent.instance = PetTrialAgent.New()

return PetTrialAgent
