-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/agent/ElementSparkAgent.lua

module("logic.extensions.elementspark.agent.ElementSparkAgent", package.seeall)

local ElementSparkAgent = class("ElementSparkAgent", BaseAgent)

function ElementSparkAgent:sendPM_EleSparkGetRegisterInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetRegisterInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetRegisterInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetRegisterInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkRegisterReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkRegisterReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkRegisterRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkRegisterRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetMyFormsReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetMyFormsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetMyFormsRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetMyFormsRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkSetMyFormsReq(activityId, forms)
	local req = ElementSparkExtension_pb.PM_EleSparkSetMyFormsReq()

	for k, v in pairs(forms) do
		local add = req.updateForms:add()

		add.teamId = v.teamId

		add.form:ParseFromString(v.form:SerializeToString())
	end

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkSetMyFormsRes(status, msg)
	ElementSparkController.instance:handlePM_EleSparkSetMyFormsRes(status, msg)
end

function ElementSparkAgent:sendPM_EleSparkGetOtherGuardInfoReq(activityId, chunkId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetOtherGuardInfoReq()

	req.activityId = activityId
	req.chunkId = chunkId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetOtherGuardInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetOtherGuardInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetMyGuardInfoReq(activityId, chunkId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetMyGuardInfoReq()

	req.activityId = activityId
	req.chunkId = chunkId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetMyGuardInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetMyGuardInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkUpgradeGuardReq(activityId, chunkId, targetLv)
	local req = ElementSparkExtension_pb.PM_EleSparkUpgradeGuardReq()

	req.activityId = activityId
	req.chunkId = chunkId
	req.targetLv = targetLv

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkUpgradeGuardRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkUpgradeGuardRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkSendGuardDefenseFormReq(activityId, chunkId, teamId)
	local req = ElementSparkExtension_pb.PM_EleSparkSendGuardDefenseFormReq()

	req.activityId = activityId
	req.chunkId = chunkId
	req.teamId = teamId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkSendGuardDefenseFormRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkSendGuardDefenseFormRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetGuardRecordReq(activityId, chunkId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetGuardRecordReq()

	req.activityId = activityId
	req.chunkId = chunkId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetGuardRecordRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetGuardRecordRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkChallengeDefenseFormReq(activityId, chunkId, teamId)
	local req = ElementSparkExtension_pb.PM_EleSparkChallengeDefenseFormReq()

	req.activityId = activityId
	req.chunkId = chunkId
	req.teamId = teamId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkChallengeDefenseFormRes(status, msg)
	ElementSparkController.instance:handlePM_EleSparkChallengeDefenseFormRes(status, msg)

	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ElementSparkAgent:sendPM_EleSparkChallengeBossReq(activityId, chunkId, teamId)
	local req = ElementSparkExtension_pb.PM_EleSparkChallengeBossReq()

	req.activityId = activityId
	req.chunkId = chunkId
	req.teamId = teamId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkChallengeBossRes(status, msg)
	ElementSparkController.instance:handlePM_EleSparkChallengeBossRes(status, msg)

	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ElementSparkAgent:sendPM_EleSparkRevokeDefenseFormReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkRevokeDefenseFormReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkRevokeDefenseFormRes(status, msg)
	ElementSparkController.instance:handlePM_EleSparkRevokeDefenseFormRes(status, msg)
end

function ElementSparkAgent:sendPM_EleSparkGetSparkInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetSparkInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetSparkInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetSparkInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkBuyPetReq(activityId, itemId)
	local req = ElementSparkExtension_pb.PM_EleSparkBuyPetReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkBuyPetRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkBuyPetRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkRefreshMapInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkRefreshMapInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkRefreshMapInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkRefreshMapInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkAddTagReq(activityId, chunkId, signId)
	local req = ElementSparkExtension_pb.PM_EleSparkAddTagReq()

	req.activityId = activityId
	req.chunkId = chunkId
	req.signId = signId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkAddTagRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkAddTagRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkModifyTagReq(activityId, tagId, signId, chunkId)
	local req = ElementSparkExtension_pb.PM_EleSparkModifyTagReq()

	req.activityId = activityId
	req.tagId = tagId
	req.signId = signId
	req.chunkId = chunkId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkModifyTagRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkModifyTagRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkModifyBoardReq(activityId, content)
	local req = ElementSparkExtension_pb.PM_EleSparkModifyBoardReq()

	req.activityId = activityId
	req.content = content

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkModifyBoardRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkModifyBoardRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetCampInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetCampInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetCampInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetCampInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkModifyMinDefenseFormZdlReq(activityId, minZdl)
	local req = ElementSparkExtension_pb.PM_EleSparkModifyMinDefenseFormZdlReq()

	req.activityId = activityId
	req.minZdl = minZdl

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkModifyMinDefenseFormZdlRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkModifyMinDefenseFormZdlRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkPublishCommandReq(activityId, command)
	local req = ElementSparkExtension_pb.PM_EleSparkPublishCommandReq()

	req.activityId = activityId
	req.command = command

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkPublishCommandRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkPublishCommandRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetResourceInfoReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetResourceInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetResourceInfoRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetResourceInfoRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGainResourceReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGainResourceReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGainResourceRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGainResourceRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetCampRankReq(activityId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetCampRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetCampRankRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetCampRankRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkGetPersonRankReq(activityId, campId)
	local req = ElementSparkExtension_pb.PM_EleSparkGetPersonRankReq()

	req.activityId = activityId
	req.campId = campId

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkGetPersonRankRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkGetPersonRankRes(status, msg)
	end
end

function ElementSparkAgent:handlePM_EleSparkNotifyGuardInfoChangeRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkNotifyGuardInfoChangeRes(status, msg)
	end
end

function ElementSparkAgent:handlePM_EleSparkNotifyMapInfoChangeRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkNotifyMapInfoChangeRes(status, msg)
	end
end

function ElementSparkAgent:sendPM_EleSparkExitReq()
	local req = ElementSparkExtension_pb.PM_EleSparkExitReq()

	self:sendMsg(req)
end

function ElementSparkAgent:handlePM_EleSparkExitRes(status, msg)
	if status == 0 then
		ElementSparkController.instance:handlePM_EleSparkExitRes(status, msg)
	end
end

ElementSparkAgent.instance = ElementSparkAgent.New()

return ElementSparkAgent
