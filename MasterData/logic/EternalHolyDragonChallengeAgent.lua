-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/agent/EternalHolyDragonChallengeAgent.lua

module("logic.extensions.eternalholydragonchallenge.agent.EternalHolyDragonChallengeAgent", package.seeall)

local EternalHolyDragonChallengeAgent = class("EternalHolyDragonChallengeAgent", BaseAgent)

EternalHolyDragonChallengeAgent.EHolyDragonClgGetInfoRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgGetInfoRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgForwardRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgForwardRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgFightRiverMonsterRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgFightRiverMonsterRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightRiverMonsterRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightRiverMonsterRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgFightLandMonsterRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgFightLandMonsterRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightLandMonsterRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightLandMonsterRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgUseItemOnLandRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgUseItemOnLandRes"
EternalHolyDragonChallengeAgent.EHolyDragonClgResetStageRes = "EternalHolyDragonChallengeAgent.EHolyDragonClgResetStageRes"

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgGetInfoReq(activityId)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgGetInfoRes(status, msg)
	if status == 0 then
		EternalholydragonModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgGetInfoRes)
	end
end

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgForwardReq(activityId)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgForwardReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgForwardRes(status, msg)
	if status == 0 then
		EternalholydragonModel.instance:dragonClgForward(msg.targetPos)
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgForwardRes)
	end
end

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgFightRiverMonsterReq(activityId, form, monsterPos)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgFightRiverMonsterReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.monsterPos.x = monsterPos.x
	req.monsterPos.y = monsterPos.y

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgFightRiverMonsterRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgFightRiverMonsterRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgNotifyFightRiverMonsterRes(status, msg)
	if status == 0 then
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

		EternalholydragonController.instance:onNotifyFightRiverMonsterRes(msg)

		if msg.changeSetId and msg.changeSetId > 0 and not isAoqiGodProcessType then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end

		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightRiverMonsterRes)
	end
end

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgFightLandMonsterReq(activityId, form, monsterPos)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgFightLandMonsterReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.monsterPos.x = monsterPos.x
	req.monsterPos.y = monsterPos.y

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgFightLandMonsterRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgFightLandMonsterRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgNotifyFightLandMonsterRes(status, msg)
	if status == 0 then
		EternalholydragonController.instance:onNotifyFightLandMonsterRes(msg)
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgNotifyFightLandMonsterRes)
	end
end

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgUseItemOnLandReq(activityId, itemId, gridPos)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgUseItemOnLandReq()

	req.activityId = activityId
	req.itemId = itemId
	req.gridPos.x = gridPos.x
	req.gridPos.y = gridPos.y

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgUseItemOnLandRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("道具已生效，位置不可变更")
		EternalholydragonModel.instance:onUseItemOnLandRes(msg)
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgUseItemOnLandRes)
	end
end

function EternalHolyDragonChallengeAgent:sendPM_EHolyDragonClgResetStageReq(activityId)
	local req = EternalHolyDragonChallengeExtension_pb.PM_EHolyDragonClgResetStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalHolyDragonChallengeAgent:handlePM_EHolyDragonClgResetStageRes(status, msg)
	if status == 0 then
		EternalholydragonModel.instance:onResetStageRes(msg)
		GlobalDispatcher:dispatch(EternalHolyDragonChallengeAgent.EHolyDragonClgResetStageRes)
	end
end

EternalHolyDragonChallengeAgent.instance = EternalHolyDragonChallengeAgent.New()

return EternalHolyDragonChallengeAgent
