-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/agent/NewFamilyBattleAgent.lua

module("logic.extensions.godstatueswar.agent.NewFamilyBattleAgent", package.seeall)

local NewFamilyBattleAgent = class("NewFamilyBattleAgent", BaseAgent)

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetRegistrationReq()
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetRegistrationReq()

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetRegistrationRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleGetRegistrationRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleRegisteringReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleRegisteringReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleRegisteringRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleRegisteringRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetFormReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetFormReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetFormRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleGetFormRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleSetFormReq(seasonId, simpleFormList)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleSetFormReq()

	req.seasonId = seasonId

	if simpleFormList then
		for id, v in ipairs(simpleFormList) do
			local mo = NewFamilyBattleExtension_pb.PM_NewFamilyBattleForm()

			mo.id = id

			mo.form:ParseFromString(v:SerializeToString())
			req.forms:add():ParseFromString(mo:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleSetFormRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleSetFormRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetDivinePillarFormReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetDivinePillarFormReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetDivinePillarFormRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleGetDivinePillarFormRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetFormDetailReq(seasonId, targetFamilyId, playerId, formId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetFormDetailReq()

	req.seasonId = seasonId
	req.targetFamilyId = targetFamilyId
	req.playerId = playerId
	req.formId = formId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetFormDetailRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleGetFormDetailRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleAdjustReq(seasonId, req)
	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleAdjustRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleAdjustRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetDivinePillarMapReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetDivinePillarMapReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetDivinePillarMapRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleGetDivinePillarMapRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetDivinePillarInfoReq(seasonId, familyId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetDivinePillarInfoReq()

	req.seasonId = seasonId
	req.familyId = familyId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetDivinePillarInfoRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleGetDivinePillarInfoRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleFightDivinePillarReq(seasonId, familyId, tier, simpleFormList)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleFightDivinePillarReq()

	req.seasonId = seasonId
	req.familyId = familyId
	req.tier = tier

	if simpleFormList then
		for _, v in ipairs(simpleFormList) do
			req.form:add():ParseFromString(v:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleFightDivinePillarRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleFightDivinePillarRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleReportReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleReportReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleReportRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleReportRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleVideoReq(battleId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleVideoRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleVideoRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleChallengeNestReq(seasonId, form, nestId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleChallengeNestReq()

	req.seasonId = seasonId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.nestId = nestId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleChallengeNestRes(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleChallengeNestRes(status, msg)
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleSetFlagReq(seasonId, attackFlagFamilyId, noAttackFlagFamilyId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleSetFlagReq()

	req.seasonId = seasonId
	req.attackFlagFamilyId = attackFlagFamilyId
	req.noAttackFlagFamilyId = noAttackFlagFamilyId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleSetFlagRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleSetFlagRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleRankViewReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleRankViewReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleRankViewRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleRankViewRes(msg)
	end
end

function NewFamilyBattleAgent:sendPM_NewFamilyBattleGetSpaceGroupInfoReq(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleGetSpaceGroupInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleGetSpaceGroupInfoRes(status, msg)
	if status == 0 then
		GodStatuesWarController.instance:handlePM_NewFamilyBattleGetSpaceGroupInfoRes(msg)
	end
end

function NewFamilyBattleAgent:handlePM_NewFamilyBattleChallengeNestResult(status, msg)
	GodStatuesWarController.instance:handlePM_NewFamilyBattleChallengeNestResult(msg)
end

NewFamilyBattleAgent.instance = NewFamilyBattleAgent.New()

return NewFamilyBattleAgent
