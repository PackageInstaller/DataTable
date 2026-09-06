-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/agent/HalloweenSceneMonsterAgent.lua

module("logic.extensions.halloweenguest.agent.HalloweenSceneMonsterAgent", package.seeall)

local HalloweenSceneMonsterAgent = class("HalloweenSceneMonsterAgent", BaseAgent)

function HalloweenSceneMonsterAgent:sendPM_HalloweenSceneMonsterGetInfoReq(activityId)
	local req = HalloweenSceneMonsterExtension_pb.PM_HalloweenSceneMonsterGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HalloweenSceneMonsterAgent:handlePM_HalloweenSceneMonsterGetInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestHalloweenGuest===back")

	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenSceneMonsterGetInfo(msg)
	end
end

function HalloweenSceneMonsterAgent:sendPM_HalloweenSceneMonsterChallengeReq(activityId, sceneConfigId, positionId)
	local req = HalloweenSceneMonsterExtension_pb.PM_HalloweenSceneMonsterChallengeReq()

	req.activityId = activityId
	req.sceneConfigId = sceneConfigId
	req.positionId = positionId

	self:sendMsg(req)
end

function HalloweenSceneMonsterAgent:handlePM_HalloweenSceneMonsterChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	elseif ViewMgr.instance:isOpen(ViewName.HalloweenMission) then
		UIStateManager.instance:clear(true)
	end
end

function HalloweenSceneMonsterAgent:handlePM_HalloweenSceneMonsterChallengeEndRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendMonsterNotifyChallengeEnd(msg)
	end
end

function HalloweenSceneMonsterAgent:sendPM_HalloweenSceneMonsterGainPrizeReq(activityId, prizeId)
	local req = HalloweenSceneMonsterExtension_pb.PM_HalloweenSceneMonsterGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function HalloweenSceneMonsterAgent:handlePM_HalloweenSceneMonsterGainPrizeRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenSceneMonsterGainPrize(msg)
	end
end

HalloweenSceneMonsterAgent.instance = HalloweenSceneMonsterAgent.New()

return HalloweenSceneMonsterAgent
