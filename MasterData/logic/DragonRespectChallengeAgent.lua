-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/agent/DragonRespectChallengeAgent.lua

module("logic.extensions.dragonrespectchallenge.agent.DragonRespectChallengeAgent", package.seeall)

local DragonRespectChallengeAgent = class("DragonRespectChallengeAgent", BaseAgent)

function DragonRespectChallengeAgent:sendPM_DragonRespectChallengeInfoReq(actId)
	local req = DragonRespectChallengeExtension_pb.PM_DragonRespectChallengeInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_DragonRespectChallengeInfoRes(status, msg)
	if status == 0 then
		local passnum = msg.passNum

		DrogonLordsModel.instance:setPassNum(passnum)
		GlobalDispatcher:dispatch(GlobalNotify.DragonLordsMain)
	end
end

function DragonRespectChallengeAgent:sendPM_ExtremeChallengeInfoReq(actId)
	local req = DragonRespectChallengeExtension_pb.PM_ExtremeChallengeInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_ExtremeChallengeInfoRes(status, msg)
	if status == 0 then
		DrogonLordsModel.instance:setLimitChallengeInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonLimitChallenge)
	end
end

function DragonRespectChallengeAgent:sendPM_ExtremeChallengeReq(actId, simpleForm)
	local req = DragonRespectChallengeExtension_pb.PM_ExtremeChallengeReq()

	req.actId = actId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_ExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	elseif status == -36 and ViewMgr.instance:isOpen(ViewName.CustomMissionView) then
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
		FloatWordMgr.instance:show(DragonLordsConfig.instance:getCommonCfg("LIMIT_TIPS_TEXT"))
	end
end

function DragonRespectChallengeAgent:sendPM_ExtremeChallengeRestReq(actId)
	local req = DragonRespectChallengeExtension_pb.PM_ExtremeChallengeRestReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_ExtremeChallengeRestRes(status, msg)
	if status == 0 then
		DrogonLordsModel.instance:setLimitChallengeInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonLimitChallenge)
	end
end

function DragonRespectChallengeAgent:handlePM_NotifyExtremeChallengeEndRes(status, msg)
	if status == 0 then
		local curstage = msg.curStage

		if curstage == 5 then
			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.LongZunChallenge)
		end
	end
end

function DragonRespectChallengeAgent:sendPM_UniversalChallengeInfoReq(actId)
	local req = DragonRespectChallengeExtension_pb.PM_UniversalChallengeInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_UniversalChallengeInfoRes(status, msg)
	if status == 0 then
		DrogonLordsModel.instance:setNormalInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonNationalChallenge)
	end
end

function DragonRespectChallengeAgent:sendPM_GetSingleChallengeInfoReq(actId, challengeId)
	local req = DragonRespectChallengeExtension_pb.PM_GetSingleChallengeInfoReq()

	req.actId = actId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_GetSingleChallengeInfoRes(status, msg)
	if status == 0 then
		DrogonLordsModel.instance:setNormalStageInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DragonChallenge)
	end
end

function DragonRespectChallengeAgent:sendPM_UniversalChallengeReq(actId, challengeId, simpleForm, operate)
	local req = DragonRespectChallengeExtension_pb.PM_UniversalChallengeReq()

	req.actId = actId
	req.challengeId = challengeId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	req.operate = operate

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_UniversalChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DragonChallengeUpdate)
	end
end

function DragonRespectChallengeAgent:sendPM_UniversalChallengeSettlementReq(actId, challengeId)
	local req = DragonRespectChallengeExtension_pb.PM_UniversalChallengeSettlementReq()

	req.actId = actId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_UniversalChallengeSettlementRes(status, msg)
	if status == 0 then
		local finalscore = msg.finalScore

		DrogonLordsModel.instance:setNormalChallengeScore(finalscore)
		GlobalDispatcher:dispatch(GlobalNotify.DragonChallengeOver)
	end
end

function DragonRespectChallengeAgent:handlePM_NotifyUniversalChallengeEndRes(status, msg)
	if status == 0 then
		DrogonLordsModel.instance:setNormalChallengeEnd(msg)
	end
end

function DragonRespectChallengeAgent:sendPM_UniversalChallengeFusionReq(actId)
	local req = DragonRespectChallengeExtension_pb.PM_UniversalChallengeFusionReq()

	req.actId = actId

	self:sendMsg(req)
end

function DragonRespectChallengeAgent:handlePM_UniversalChallengeFusionRes(status, msg)
	if status == 0 then
		DragonLordsController.instance:scGodLotteryDone(msg)
	end
end

DragonRespectChallengeAgent.instance = DragonRespectChallengeAgent.New()

return DragonRespectChallengeAgent
