-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/agent/DragonDishitianAgent.lua

module("logic.extensions.dragondishitian.agent.DragonDishitianAgent", package.seeall)

local DragonDishitianAgent = class("DragonDishitianAgent", BaseAgent)

function DragonDishitianAgent:sendPM_DragonDishitianGetInfoReq(activityId)
	local req = DragonDishitianExtension_pb.PM_DragonDishitianGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonDishitianAgent:handlePM_DragonDishitianGetInfoRes(status, msg)
	if status == 0 then
		DragonDishitianModel.instance:onDragonDishitianGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonDishitianGetInfoRes)
	end
end

function DragonDishitianAgent:sendPM_DragonDishitianChallengeReq(activityId, chapterId, stageId, form)
	local req = DragonDishitianExtension_pb.PM_DragonDishitianChallengeReq()

	req.activityId = activityId
	req.chapterId = chapterId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)

	self._activityId = activityId
	self._chapterId = chapterId
	self._stageId = stageId
end

function DragonDishitianAgent:handlePM_DragonDishitianChallengeRes(status, msg)
	if status == 0 then
		DragonDishitianModel.instance:onDragonDishitianChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonDishitianChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DragonDishitianAgent:handlePM_Notify_DragonDishitianChallengeRes(status, msg)
	if status == 0 then
		DragonDishitianModel.instance:onNotify_DragonDishitianChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_DragonDishitianChallengeRes, self._activityId, self._chapterId, self._stageId)
	end

	self._activityId = nil
	self._chapterId = nil
	self._stageId = nil
end

function DragonDishitianAgent:sendPM_DragonDishitianChargeReq(activityId, typeId, num)
	local req = DragonDishitianExtension_pb.PM_DragonDishitianChargeReq()

	req.activityId = activityId
	req.typeId = typeId
	req.num = num

	self:sendMsg(req)
end

function DragonDishitianAgent:handlePM_DragonDishitianChargeRes(status, msg)
	if status == 0 then
		DragonDishitianModel.instance:onDragonDishitianChargeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonDishitianChargeBuffRes)
	end
end

DragonDishitianAgent.instance = DragonDishitianAgent.New()

return DragonDishitianAgent
