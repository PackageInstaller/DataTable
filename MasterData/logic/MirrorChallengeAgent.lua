-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/agent/MirrorChallengeAgent.lua

module("logic.extensions.xinxiyamirror.agent.MirrorChallengeAgent", package.seeall)

local MirrorChallengeAgent = class("MirrorChallengeAgent", BaseAgent)

function MirrorChallengeAgent:sendPM_MirrorChallengeInfoReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeInfoReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeInfoRes(status, msg)
	if status == 0 then
		XinxiyaMirrorController.instance:scSendMirrorInfo(msg)
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeReq(stageId)
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeReq()

	req.stageId = stageId

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeRes(status, msg)
	if status ~= 0 and ViewMgr.instance:isOpen(ViewName.XXYMission) then
		UIStateManager.instance:clear(true)
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeUseBuffReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeUseBuffReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeUseBuffRes(status, msg)
	if status == 0 and msg and msg.buffInfo then
		XinxiyaMirrorController.instance:scSendMirrorUseBuff(msg.buffInfo)
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeAllStageScoreReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeAllStageScoreReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeAllStageScoreRes(status, msg)
	if status == 0 and msg and msg.stageScore then
		XinxiyaMirrorController.instance:scSendMirrorStagePower(msg.stageScore)
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeRankReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeRankReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeRankRes(status, msg)
	if status == 0 then
		XinxiyaMirrorController.instance:scSendMirrorRankInfo(msg)
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeClearMirrorReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeClearMirrorReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeClearMirrorRes(status, msg)
	if status == 0 then
		XinxiyaMirrorController.instance:scSendsResetMirrorStage()
	end
end

function MirrorChallengeAgent:sendPM_MirrorChallengeGainDailyPrizeReq()
	local req = MirrorChallengeExtension_pb.PM_MirrorChallengeGainDailyPrizeReq()

	self:sendMsg(req)
end

function MirrorChallengeAgent:handlePM_MirrorChallengeGainDailyPrizeRes(status, msg)
	if status == 0 then
		XinxiyaMirrorController.instance:scSendMirrorDailyPrize()
	end
end

function MirrorChallengeAgent:handleNotifyMirrorChallengeEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

MirrorChallengeAgent.instance = MirrorChallengeAgent.New()

return MirrorChallengeAgent
