-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/agent/PetCollegeAgent.lua

module("logic.extensions.petcollege.agent.PetCollegeAgent", package.seeall)

local PetCollegeAgent = class("PetCollegeAgent", BaseAgent)

PetCollegeAgent.PetCollegeChallengeRes = "PetCollegeAgent.PetCollegeChallengeRes"

function PetCollegeAgent:sendPetCollegeProcessInfoReq()
	local req = PetCollegeExtension_pb.PetCollegeProcessInfoReq()

	self:sendMsg(req)
end

function PetCollegeAgent:handlePetCollegeProcessInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadPetCollegeInfo===back")

	if status == 0 then
		local infos = msg.infos

		PetCollegeModel.instance:setProcessInfos(infos)
	else
		PetCollegeController.instance:resetRequireTag()
	end
end

function PetCollegeAgent:sendPetCollegeChallengeReq(challengeId, stageId, form_pb)
	local req = PetCollegeExtension_pb.PetCollegeChallengeReq()

	req.challengeId = challengeId
	req.stageId = stageId

	req.form:ParseFromString(form_pb:SerializeToString())
	self:sendMsg(req)
end

function PetCollegeAgent:handlePetCollegeChallengeRes(status, msg)
	if status == 0 then
		PetCollegeController.instance:startListenBattle()
	end

	GlobalDispatcher:dispatch(PetCollegeAgent.PetCollegeChallengeRes, status, msg)
end

function PetCollegeAgent:handleNotifyAfterChallengeRes(status, msg)
	if status == 0 then
		local iswin = msg.isWin

		challengeId = msg.challengeId
		stageId = msg.stageId

		PetCollegeModel.instance:challengeSuccess(iswin, challengeId, stageId)
		UIJumper.instance:pushOneStack(ViewName.PetcollegeView, nil, challengeId)
	end
end

PetCollegeAgent.instance = PetCollegeAgent.New()

return PetCollegeAgent
