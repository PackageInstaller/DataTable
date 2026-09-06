-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/agent/DivineSuperDragonClgAgent.lua

module("logic.extensions.divinesuperdragonclg.agent.DivineSuperDragonClgAgent", package.seeall)

local DivineSuperDragonClgAgent = class("DivineSuperDragonClgAgent", BaseAgent)

function DivineSuperDragonClgAgent:sendPM_DivineSuperDragonClgGetInfoReq(activityId)
	local req = DivineSuperDragonClgExtension_pb.PM_DivineSuperDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineSuperDragonClgAgent:handlePM_DivineSuperDragonClgGetInfoRes(status, msg)
	if status == 0 then
		DivinesuperdragonModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineSuperDragonClgGetInfoRes)
	end
end

function DivineSuperDragonClgAgent:sendPM_DivineSuperDragonClgBuffStageFightReq(activityId, stageId, form)
	local req = DivineSuperDragonClgExtension_pb.PM_DivineSuperDragonClgBuffStageFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineSuperDragonClgAgent:handlePM_DivineSuperDragonClgBuffStageFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineSuperDragonClgBuffStageFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineSuperDragonClgAgent:handlePM_DivineSuperDragonClgNotifyBuffStageFightResultRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local stageId = msg.stageId
		local win = msg.win

		if win then
			DivinesuperdragonModel.instance:updateBuffStageProgress(activityId, stageId)
		end

		UIJumper.instance:pushOneStack(ViewName.DivinesuperdragonmainView, false, activityId)
		UIJumper.instance:pushOneStack(ViewName.DivinesuperdragonbuffstageView, false, activityId)
		GlobalDispatcher:dispatch(GlobalNotify.DivineSuperDragonClgNotifyBuffStageFightResultRes)
	end
end

function DivineSuperDragonClgAgent:sendPM_DivineSuperDragonClgSuperStageFightReq(activityId, form)
	local req = DivineSuperDragonClgExtension_pb.PM_DivineSuperDragonClgSuperStageFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineSuperDragonClgAgent:handlePM_DivineSuperDragonClgSuperStageFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineSuperDragonClgSuperStageFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineSuperDragonClgAgent:handlePM_DivineSuperDragonClgNotifySuperStageFightResultRes(status, msg)
	if status == 0 then
		DivinesuperdragonController.instance:handlePM_DivineSuperDragonClgNotifySuperStageFightResultRes(msg)
	end
end

DivineSuperDragonClgAgent.instance = DivineSuperDragonClgAgent.New()

return DivineSuperDragonClgAgent
