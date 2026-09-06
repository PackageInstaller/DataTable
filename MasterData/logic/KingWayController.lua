-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/controller/KingWayController.lua

module("logic.extensions.kingway.controller.KingWayController", package.seeall)

local KingWayController = class("KingWayController", BaseController)

function KingWayController:onInit()
	KingRoadAgent.instance:addHandler(KingRoadAgent.PM_ChallengeEndRes, self.SCChallengeEnd, self)
end

function KingWayController:onReset()
	return
end

function KingWayController:CSRequestKingInfo(callback)
	KingRoadAgent.instance:sendPM_GetMyKingRoadInfoReq(function(msg)
		if msg and msg.kingRoadInfo then
			KingWayModel.instance:SetKingInitData(msg.kingRoadInfo)
			GameUtil.callBack(callback)
		end
	end)
end

function KingWayController:CSChallengeStageReq(battleId, stageId)
	KingRoadAgent.instance:sendPM_ChallengeStageReq(battleId, stageId)
end

function KingWayController:SCChallengeEnd(msg)
	KingWayModel.instance:SetBattleAndStageId(msg)
end

KingWayController.instance = KingWayController.New()

return KingWayController
