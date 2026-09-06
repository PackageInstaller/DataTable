-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/agent/GodLongYanAgent.lua

module("logic.extensions.godlongyan.agent.GodLongYanAgent", package.seeall)

local GodLongYanAgent = class("GodLongYanAgent", BaseAgent)

function GodLongYanAgent:ctor()
	return
end

function GodLongYanAgent:sendPM_GodLongYanChallengeGetInfoReq()
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeGetInfoReq()

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeGetInfoRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeGetInfoRes(msg)
	end
end

function GodLongYanAgent:sendPM_GodLongYanChallengeUpgradeBuffReq(buffType)
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeUpgradeBuffReq()

	req.buffType = buffType

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeUpgradeBuffRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeUpgradeBuffRes(msg)
	end
end

function GodLongYanAgent:sendPM_GodLongYanChallengeFightReq()
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeFightReq()

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeFightRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeFightRes(msg)
	end
end

function GodLongYanAgent:sendPM_GodLongYanChallengeStartGameReq(clientKey)
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeStartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeStartGameRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeStartGameRes(msg)
	end
end

function GodLongYanAgent:sendPM_GodLongYanChallengeEndGameReq(score, encryptedKey)
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeEndGameReq()

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeEndGameRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeEndGameRes(msg)
	end
end

function GodLongYanAgent:handlePM_GodLongYanChallengeFinishRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onHandleGodLongYanChallengeFinishRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function GodLongYanAgent:handlePM_GodLongYanChallengeOneKeyPassRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onGodLongYanChallengeOneKeyPassRes(msg)
	end
end

function GodLongYanAgent:sendPM_GodLongYanChallengeResetBuffReq(buffType)
	local req = GodLongYanChallengeExtension_pb.PM_GodLongYanChallengeResetBuffReq()

	req.buffType = buffType

	self:sendMsg(req)
end

function GodLongYanAgent:handlePM_GodLongYanChallengeResetBuffRes(status, msg)
	if status == 0 then
		GodLongYanController.instance:onChallengeResetBuffRes(msg)
	end
end

GodLongYanAgent.instance = GodLongYanAgent.New()

return GodLongYanAgent
