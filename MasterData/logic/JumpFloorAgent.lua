-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/agent/JumpFloorAgent.lua

module("logic.extensions.jumpfloor.agent.JumpFloorAgent", package.seeall)

local JumpFloorAgent = class("JumpFloorAgent", BaseAgent)

function JumpFloorAgent:sendPM_DancingLionJumpGetInfoReq(activityId)
	local req = DancingLionJumpExtension_pb.PM_DancingLionJumpGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JumpFloorAgent:handlePM_DancingLionJumpGetInfoRes(status, msg)
	if status == 0 then
		JumpFloorModel.instance:onDancingLionJumpGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpGetInfoRes)
	end
end

function JumpFloorAgent:sendPM_DancingLionJumpGameStartReq(activityId, stageId, clientKey)
	local req = DancingLionJumpExtension_pb.PM_DancingLionJumpGameStartReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function JumpFloorAgent:handlePM_DancingLionJumpGameStartRes(status, msg)
	if status == 0 then
		JumpFloorModel.instance:onDancingLionJumpGameStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpGameStartRes, true, msg.encryptedKey)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpGameStartRes, false)
	end
end

function JumpFloorAgent:sendPM_DancingLionJumpGameEndReq(result, clientEncryptedKey)
	local req = DancingLionJumpExtension_pb.PM_DancingLionJumpGameEndReq()

	req.result = result
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function JumpFloorAgent:handlePM_DancingLionJumpGameEndRes(status, msg)
	if status == 0 then
		JumpFloorModel.instance:onDancingLionJumpGameEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpGameEndRes)
	end
end

function JumpFloorAgent:sendPM_DancingLionJumpGetRankReq(activityId)
	local req = DancingLionJumpExtension_pb.PM_DancingLionJumpGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JumpFloorAgent:handlePM_DancingLionJumpGetRankRes(status, msg)
	if status == 0 then
		JumpFloorModel.instance:onDancingLionJumpGetRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpGetRankRes)
	end
end

JumpFloorAgent.instance = JumpFloorAgent.New()

return JumpFloorAgent
