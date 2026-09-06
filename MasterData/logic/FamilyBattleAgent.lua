-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/agent/FamilyBattleAgent.lua

module("logic.extensions.newfamily.agent.FamilyBattleAgent", package.seeall)

local FamilyBattleAgent = class("FamilyBattleAgent", BaseAgent)

function FamilyBattleAgent:sendPM_FamilyBattleGetRegistrationInfoReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetRegistrationInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetRegistrationInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetRegistrationInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleRegisteringReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleRegisteringReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleRegisteringRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleRegistering()
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetFormationReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetFormationReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetFormationRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetFormation(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleSetFormationReq(req)
	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleSetFormationRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleSetFormation(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetDivinePillarInfoReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetDivinePillarInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetDivinePillarInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetDivinePillarInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleViewDivinePillarTierFormationInfoReq(periodId, targetUserId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleViewDivinePillarTierFormationInfoReq()

	req.periodId = periodId
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleViewDivinePillarTierFormationInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleViewDivinePillarTierFormationInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleAdjustReq(periodId, targetPos, replacerId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleAdjustReq()

	req.periodId = periodId
	req.targetPos = targetPos
	req.replacerId = replacerId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleAdjustRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleAdjust(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetInfoReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleChallengeNestReq(periodId, nestId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleChallengeNestReq()

	req.periodId = periodId
	req.nestId = nestId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleChallengeNestRes(status, msg)
	if status == 0 then
		-- block empty
	elseif ViewMgr.instance:isOpen(ViewName.FWPNMission) then
		UIStateManager.instance:clear(true)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetDivinePillarChanglleInfoReq(periodId, targetFamilyId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetDivinePillarChanglleInfoReq()

	req.periodId = periodId
	req.targetFamilyId = targetFamilyId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetDivinePillarChanglleInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetDivinePillarChanglleInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleChallengeDivinePillarReq(periodId, targetFamilyId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleChallengeDivinePillarReq()

	req.periodId = periodId
	req.targetFamilyId = targetFamilyId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleChallengeDivinePillarRes(status, msg)
	if status == 0 then
		-- block empty
	elseif ViewMgr.instance:isOpen(ViewName.FWPNMission) then
		UIStateManager.instance:clear(true)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleSetFlagReq(periodId, attackFlagFamilyId, noAttackFlagFamilyId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleSetFlagReq()

	req.periodId = periodId
	req.attackFlagFamilyId = attackFlagFamilyId
	req.noAttackFlagFamilyId = noAttackFlagFamilyId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleSetFlagRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleSetFlag(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetReportInfoReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetReportInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetReportInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetReportInfo(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleViewRankReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleViewRankReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleViewRankRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleViewRank(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleViewUserRankReq(periodId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleViewUserRankReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleViewUserRankRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleViewUserRank(msg)
	end
end

function FamilyBattleAgent:handlePM_FamilyBattleChallengeNestResult(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleChallengeNestResult(msg)
	end
end

function FamilyBattleAgent:handlePM_FamilyBattleChallengeDivinePillarResult(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleChallengeDivinePillarResult(msg)
	end
end

function FamilyBattleAgent:sendPM_FamilyBattleGetNestInfoReq(periodId, nestId)
	local req = FamilyBattleExtension_pb.PM_FamilyBattleGetNestInfoReq()

	req.periodId = periodId
	req.nestId = nestId

	self:sendMsg(req)
end

function FamilyBattleAgent:handlePM_FamilyBattleGetNestInfoRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilyBattleGetNestInfo(msg)
	end
end

FamilyBattleAgent.instance = FamilyBattleAgent.New()

return FamilyBattleAgent
