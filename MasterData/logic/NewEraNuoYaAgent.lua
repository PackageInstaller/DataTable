-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/agent/NewEraNuoYaAgent.lua

module("logic.extensions.neweranuoya.agent.NewEraNuoYaAgent", package.seeall)

local NewEraNuoYaAgent = class("NewEraNuoYaAgent", BaseAgent)

function NewEraNuoYaAgent:sendPM_NewEraNuoYaInfoReq(activityId)
	local req = NewEraNuoYaExtension_pb.PM_NewEraNuoYaInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaInfoRes(status, msg)
	if status == 0 then
		NeweranuoyaModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaInfoRes)
	end
end

function NewEraNuoYaAgent:sendPM_NewEraNuoYaResetFloorReq(activityId, floorIds)
	local req = NewEraNuoYaExtension_pb.PM_NewEraNuoYaResetFloorReq()

	req.activityId = activityId

	for i, v in ipairs(floorIds) do
		req.floorId:append(v)
	end

	self:sendMsg(req)
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaResetFloorRes(status, msg)
	if status == 0 then
		NeweranuoyaModel.instance:onResetFloorRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaResetFloorRes)
	end
end

function NewEraNuoYaAgent:sendPM_NewEraNuoYaExtChallengeReq(activityId, form, floorId, stageId)
	local req = NewEraNuoYaExtension_pb.PM_NewEraNuoYaExtChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaExtChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaExtChallengeRes)
	end
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaBattleRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaBattleRes)
	end
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaNotifyExtChallengeRes(status, msg)
	if status == 0 then
		NeweranuoyaController.instance:onNotifyExtChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaNotifyExtChallengeRes)
	end
end

function NewEraNuoYaAgent:sendPM_NewEraNuoYaSaveReq(activityId, isSave)
	local req = NewEraNuoYaExtension_pb.PM_NewEraNuoYaSaveReq()

	req.activityId = activityId
	req.isSave = isSave

	self:sendMsg(req)
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaSaveRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		self:sendPM_NewEraNuoYaInfoReq(activityId)
		NeweranuoyaController.instance:onSaveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaSaveRes)
	end
end

function NewEraNuoYaAgent:sendPM_NewEraNuoYaCommonChallengeReq(activityId, stageId, form)
	local req = NewEraNuoYaExtension_pb.PM_NewEraNuoYaCommonChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaCommonChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaCommonChallengeRes)
	end
end

function NewEraNuoYaAgent:handlePM_NewEraNuoYaNotifyCommonChallengeRes(status, msg)
	if status == 0 then
		NeweranuoyaModel.instance:onNotifyCommonChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NewEraNuoYaNotifyCommonChallengeRes)
	end
end

NewEraNuoYaAgent.instance = NewEraNuoYaAgent.New()

return NewEraNuoYaAgent
