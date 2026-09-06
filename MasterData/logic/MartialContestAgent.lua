-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/agent/MartialContestAgent.lua

module("logic.extensions.martialcontest.agent.MartialContestAgent", package.seeall)

local MartialContestAgent = class("MartialContestAgent", BaseAgent)

function MartialContestAgent:sendPM_MCGetInfoReq(activityId)
	local req = MartialContestExtension_pb.PM_MCGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetInfoRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCGetInfoRes(msg)
	end
end

function MartialContestAgent:handlePM_MCNotifyStepChangeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MartialContestAgent:sendPM_MCGetBattleVideoReq(battleId)
	local req = MartialContestExtension_pb.PM_MCGetBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetBattleVideoRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCGetBattleVideoRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetBattleVideoErrorRes, status)
	end
end

function MartialContestAgent:sendPM_MCGetDefenseForamtionReq(activityId)
	local req = MartialContestExtension_pb.PM_MCGetDefenseForamtionReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetDefenseForamtionRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCGetDefenseForamtionRes(msg)
	end
end

function MartialContestAgent:sendPM_MCSetDefenseForamtionReq(activityId, simpleForm)
	local req = MartialContestExtension_pb.PM_MCSetDefenseForamtionReq()

	req.activityId = activityId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCSetDefenseForamtionRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MartialContestAgent:sendPM_MCFinalsGetFormationReq(activityId)
	local req = MartialContestExtension_pb.PM_MCFinalsGetFormationReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCFinalsGetFormationRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCFinalsGetFormationRes(msg)
	end
end

function MartialContestAgent:sendPM_MCFinalsSetFormationReq(activityId, addForms, buffIds)
	local req = MartialContestExtension_pb.PM_MCFinalsSetFormationReq()

	req.activityId = activityId

	if addForms ~= nil then
		for formId, form in ipairs(addForms) do
			local forms = req.forms:add()

			forms:ParseFromString(form:SerializeToString())
		end
	end

	if buffIds then
		for i, v in ipairs(buffIds) do
			req.buffIds:append(v)
		end
	end

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCFinalsSetFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCFinalsSetFormationRes)
	end
end

function MartialContestAgent:sendPM_MCGetQualifierInfoReq(activityId, stepId)
	local req = MartialContestExtension_pb.PM_MCGetQualifierInfoReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetQualifierInfoRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCGetQualifierInfoRes(msg)
	end
end

function MartialContestAgent:sendPM_MCQualifierGetNewOpponentReq(activityId, stepId)
	local req = MartialContestExtension_pb.PM_MCQualifierGetNewOpponentReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCQualifierGetNewOpponentRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCQualifierGetNewOpponentRes(msg)
	end
end

function MartialContestAgent:sendPM_MCQualifierFightReq(activityId, stepId, formNos)
	local req = MartialContestExtension_pb.PM_MCQualifierFightReq()

	req.activityId = activityId
	req.stepId = stepId

	if formNos ~= nil then
		for formId, form in ipairs(formNos) do
			local forms = req.formNos:add()

			forms:ParseFromString(form:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCQualifierFightRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCQualifierFightRes(msg)
	end
end

function MartialContestAgent:sendPM_MCQualifierRecordsReq(activityId, stepId)
	local req = MartialContestExtension_pb.PM_MCQualifierRecordsReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCQualifierRecordsRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCQualifierRecordsRes(msg)
	end
end

function MartialContestAgent:sendPM_MCQualifierRankInfoReq(activityId, zoneId, stepId)
	local req = MartialContestExtension_pb.PM_MCQualifierRankInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stepId = stepId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCQualifierRankInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCQualifierRankInfoRes, msg)
	end
end

function MartialContestAgent:sendPM_MCQualifierPetRaceRankReq(activityId, stepId, winRank)
	local req = MartialContestExtension_pb.PM_MCQualifierPetRaceRankReq()

	req.activityId = activityId
	req.stepId = stepId
	req.winRank = winRank

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCQualifierPetRaceRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCQualifierPetRaceRankRes, msg)
	end
end

function MartialContestAgent:sendPM_MCFinalsInfoReq(activityId)
	local req = MartialContestExtension_pb.PM_MCFinalsInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCFinalsInfoRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCFinalsInfoRes(msg)
	end
end

function MartialContestAgent:handlePM_MCNotifyFinalsResultRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCNotifyFinalsResultRes(msg)
	end
end

function MartialContestAgent:sendPM_MCFinalsResultReq(activityId, stepId, groupId)
	local req = MartialContestExtension_pb.PM_MCFinalsResultReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCFinalsResultRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCFinalsResultRes, msg)
	end
end

function MartialContestAgent:sendPM_MCGetDisplayInfoReq(activityId)
	local req = MartialContestExtension_pb.PM_MCGetDisplayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetDisplayInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCGetDisplayInfoRes, msg)
	end
end

function MartialContestAgent:sendPM_MCGetFinalsEquipInfoReq(activityId)
	local req = MartialContestExtension_pb.PM_MCGetFinalsEquipInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCGetFinalsEquipInfoRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCGetFinalsEquipInfoRes(msg)
	end
end

function MartialContestAgent:sendPM_MCUpgradeFinalsEquipReq(activityId, equipId)
	local req = MartialContestExtension_pb.PM_MCUpgradeFinalsEquipReq()

	req.activityId = activityId
	req.equipId = equipId

	self:sendMsg(req)
end

function MartialContestAgent:handlePM_MCUpgradeFinalsEquipRes(status, msg)
	if status == 0 then
		MartialContestController.instance:handlePM_MCUpgradeFinalsEquipRes(msg)
	end
end

MartialContestAgent.instance = MartialContestAgent.New()

return MartialContestAgent
