-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/agent/DivineDisorderDragonAgent.lua

module("logic.extensions.divinedisorderdragon.agent.DivineDisorderDragonAgent", package.seeall)

local DivineDisorderDragonAgent = class("DivineDisorderDragonAgent", BaseAgent)

function DivineDisorderDragonAgent:sendPM_DivineDisorderDragonGetInfoReq(activityId)
	local req = DivineDisorderDragonExtension_pb.PM_DivineDisorderDragonGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDisorderDragonAgent:handlePM_DivineDisorderDragonGetInfoRes(status, msg)
	if status == 0 then
		DivinedisorderdragonModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDisorderDragonGetInfoRes)
	end
end

function DivineDisorderDragonAgent:sendPM_DivineDisorderDragonFightReq(activityId, form)
	local req = DivineDisorderDragonExtension_pb.PM_DivineDisorderDragonFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineDisorderDragonAgent:handlePM_DivineDisorderDragonFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineDisorderDragonFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineDisorderDragonAgent:handlePM_DivineDisorderDragonNotifyFightRes(status, msg)
	if status == 0 then
		DivinedisorderdragonModel.instance:notifyFightRes(msg)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)
		local activityId = msg.activityId

		if isAoqiGodProcessType then
			local allPass = DivinedisorderdragonController.instance:allHasPass(activityId)

			if isAoqiGodProcessType and allPass then
				AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineDisorderDragon, activityId)

				return
			end
		end

		UIJumper.instance:pushOneStack(ViewName.DivinedisorderdragonmainView, nil, activityId)
		UIJumper.instance:pushOneStack(ViewName.DivinedisorderdragonlevelView, nil, activityId)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDisorderDragonNotifyFightRes)
	end
end

DivineDisorderDragonAgent.instance = DivineDisorderDragonAgent.New()

return DivineDisorderDragonAgent
