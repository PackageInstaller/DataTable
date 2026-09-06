-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/agent/FamilyTeamPlayAgent.lua

module("logic.extensions.familyteamplay.agent.FamilyTeamPlayAgent", package.seeall)

local FamilyTeamPlayAgent = class("FamilyTeamPlayAgent", BaseAgent)

function FamilyTeamPlayAgent:sendPM_GetTeamPlayProgressInfoReq(teamPlayType)
	local req = FamilyTeamPlayExtension_pb.PM_GetTeamPlayProgressInfoReq()

	req.teamPlayType = checknumber(teamPlayType)

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_GetTeamPlayProgressInfoRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scGetTeamPlayProgressInfo(msg)
	end
end

function FamilyTeamPlayAgent:sendPM_ViewMemberZdlInfoListReq()
	local req = FamilyTeamPlayExtension_pb.PM_ViewMemberZdlInfoListReq()

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_ViewMemberZdlInfoListRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scViewMemberZdlInfoList(msg)
	end
end

function FamilyTeamPlayAgent:sendPM_ViewFamilyTeamPlayRankReq()
	local req = FamilyTeamPlayExtension_pb.PM_ViewFamilyTeamPlayRankReq()

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_ViewFamilyTeamPlayRankRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scViewFamilyTeamPlayRank(msg)
	end
end

function FamilyTeamPlayAgent:sendPM_TeamPlayFightReq(periodId, bossId, teamPlayType)
	local req = FamilyTeamPlayExtension_pb.PM_TeamPlayFightReq()

	req.periodId = periodId
	req.bossId = bossId
	req.teamPlayType = teamPlayType

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_TeamPlayFightRes(status, msg)
	FamilyteamplayController.instance:scTeamPlayFight(status)
end

function FamilyTeamPlayAgent:sendPM_TeamPlayPracticeReq(periodId, bossId, teamPlayType)
	local req = FamilyTeamPlayExtension_pb.PM_TeamPlayPracticeReq()

	req.periodId = periodId
	req.bossId = bossId
	req.teamPlayType = teamPlayType

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_TeamPlayPracticeRes(status, msg)
	FamilyteamplayController.instance:scTeamPlayPractice(status)
end

function FamilyTeamPlayAgent:sendPM_TeamPlaySmallGameStartReq(periodId, gameId)
	local req = FamilyTeamPlayExtension_pb.PM_TeamPlaySmallGameStartReq()

	req.periodId = periodId
	req.gameId = gameId

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_TeamPlaySmallGameStartRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scTeamPlaySmallGameStart()
	end
end

function FamilyTeamPlayAgent:sendPM_TeamPlaySmallGameEndReq(periodId, gameId, score)
	local req = FamilyTeamPlayExtension_pb.PM_TeamPlaySmallGameEndReq()

	req.periodId = periodId
	req.gameId = gameId
	req.score = score

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_TeamPlaySmallGameEndRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scTeamPlaySmallGameEnd(msg)
	else
		TipsFacade.instance:openTipWindowNoX("提示", "发生错误，请重新进行游戏", nil)
	end
end

function FamilyTeamPlayAgent:sendPM_ViewMemberDamageListReq(periodId)
	local req = FamilyTeamPlayExtension_pb.PM_ViewMemberDamageListReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_ViewMemberDamageListRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scViewMemberDamageList(msg)
	end
end

function FamilyTeamPlayAgent:sendPM_CheckTeamPlayBossValidReq(periodId, bossId, familyId, teamPlayType)
	local req = FamilyTeamPlayExtension_pb.PM_CheckTeamPlayBossValidReq()

	req.periodId = periodId
	req.bossId = bossId
	req.familyId = familyId
	req.teamPlayType = teamPlayType

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_CheckTeamPlayBossValidRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scCheckTeamPlayBossValid()
	end
end

function FamilyTeamPlayAgent:handlePM_NotifyAfterTeamPlayBattleRes(status, msg)
	FamilyteamplayController.instance:scNotifyAfterTeamPlayBattle(msg, status)
end

function FamilyTeamPlayAgent:sendPM_ChooseTeamPlayWarZoneReq(periodId, zoneId, familyId)
	local req = FamilyTeamPlayExtension_pb.PM_ChooseTeamPlayWarZoneReq()

	req.periodId = periodId
	req.zoneId = zoneId
	req.familyId = familyId

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_ChooseTeamPlayWarZoneRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scChooseTeamPlayWarZone(msg.zoneId)
	end
end

function FamilyTeamPlayAgent:sendPM_GetFamilyZoneRnakReq(periodId, zoneId)
	local req = FamilyTeamPlayExtension_pb.PM_GetFamilyZoneRnakReq()

	req.periodId = periodId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_GetFamilyZoneRnakRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scGetFamilyZoneRnak(msg)
	end
end

function FamilyTeamPlayAgent:sendPM_GetFamilyZoneInfoReq(periodId)
	local req = FamilyTeamPlayExtension_pb.PM_GetFamilyZoneInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function FamilyTeamPlayAgent:handlePM_GetFamilyZoneInfoRes(status, msg)
	if status == 0 then
		FamilyteamplayController.instance:scGetFamilyZoneInfo(msg)
	else
		FloatWordMgr.instance:show("获取战区数据失败，稍后重试！")
	end
end

FamilyTeamPlayAgent.instance = FamilyTeamPlayAgent.New()

return FamilyTeamPlayAgent
