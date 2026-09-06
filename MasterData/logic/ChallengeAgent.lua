-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/agent/ChallengeAgent.lua

module("logic.extensions.challenge.agent.ChallengeAgent", package.seeall)

local ChallengeAgent = class("ChallengeAgent", BaseAgent)

function ChallengeAgent:sendPM_ChallengeExtOperationReq(challengeId, strategy, prizeReq, extParam)
	local req = ChallengeExtension_pb.PM_ChallengeExtOperationReq()

	req.challengeId = challengeId
	req.strategy = strategy

	if prizeReq ~= nil then
		req.prizeReq:ParseFromString(prizeReq:SerializeToString())
	end

	req.reqExtParams = extParam or ""

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeExtOperationRes(status, msg)
	if status == 0 then
		local extjsonparams = msg.extJsonParams

		ChallengeModel.instance:changeLongTimeValues(extjsonparams)
		printInfo("额外参数返回")
		GlobalDispatcher:dispatch(GlobalNotify.ChallengeExtParamUpdate, msg.extJsonParams, msg.changeSetId)
	end
end

ChallengeAgent._resGotFunc = nil

function ChallengeAgent:sendPM_ChallengeGetInfoReq(challengeId, func, notReOpenUI)
	local req = ChallengeExtension_pb.PM_ChallengeGetInfoReq()

	req.challengeId = challengeId
	ChallengeAgent._resGotFunc = func
	ChallengeAgent._notReOpenUI = notReOpenUI

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeGetInfoRes(status, msg)
	if status == 0 then
		local prePhase = ChallengeModel.instance:getCurPhase()

		ChallengeModel.instance:setCurChallenge(msg)

		if ChallengeAgent._notReOpenUI then
			ChallengeAgent._notReOpenUI = nil
		else
			UIStateManager.instance:push(ViewName.challengemgrview)
		end

		if ChallengeAgent._resGotFunc then
			ChallengeAgent._resGotFunc(prePhase)

			ChallengeAgent._resGotFunc = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.ChallengeDataUpdate, msg)
	end
end

function ChallengeAgent:sendPM_ChallengeFightTeamReq(challengeId, branchId, changeSetId, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeFightTeamReq()

	req.challengeId = challengeId
	req.branchId = branchId
	req.reqExtParams = reqExtParams

	BattleFacade.instance:startFightChallenge()
	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeFightTeamRes(status, msg)
	if status == 0 then
		ChallengeModel.instance:setChangeSetIds(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function ChallengeAgent:showChangeSet(changeSetId, name)
	if name == "handlePM_ChallengeFightTeamRes" or name == "handlePM_OnFightTeamEndRes" then
		printInfo("挑战设置changeSetId", changeSetId)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		printInfo("test changeSetId = ", changeSetId, name)
		ChallengeAgent.super.showChangeSet(self, changeSetId, name)
	end
end

function ChallengeAgent:handlePM_OnFightTeamEndRes(status, msg)
	if status == 0 then
		local json = require("cjson")
		local resextjsonparams = json.decode(msg.resExtJsonParams)

		printInfo("设置需要弹出的changeSetId = " .. msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		ChallengeModel.instance:setBattleResultInfo()
		ChallengeModel.instance:setCurChallenge(msg.newInfo)
		ChallengeController.instance:localNotify("TeamFightEnd", resextjsonparams)
		GlobalDispatcher:dispatch(GlobalNotify.ChallengeDataUpdate, msg.newInfo)
	end
end

function ChallengeAgent:sendPM_ChallengeOneKeyPassTeamReq(challengeId, branchId, strategy, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeOneKeyPassTeamReq()

	req.challengeId = challengeId
	req.branchId = branchId
	req.strategy = strategy
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeOneKeyPassTeamRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

ChallengeAgent._teamOptSucFunc = nil

function ChallengeAgent:sendPM_ChallengeTeamExtOperationReq(challengeId, branchId, strategy, reqExtParams, sucFunc)
	local req = ChallengeExtension_pb.PM_ChallengeTeamExtOperationReq()

	req.challengeId = challengeId
	req.branchId = branchId
	req.strategy = strategy
	req.reqExtParams = reqExtParams
	ChallengeAgent._teamOptSucFunc = sucFunc

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeTeamExtOperationRes(status, msg)
	if status == 0 then
		if ChallengeAgent._teamOptSucFunc then
			ChallengeAgent._teamOptSucFunc()

			ChallengeAgent._teamOptSucFunc = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.ChallengeTeamExtOperationRes, msg)
	end
end

function ChallengeAgent:sendPM_ChallengeOneKeyPassBranchReq(challengeId, branchId, strategy, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeOneKeyPassBranchReq()

	req.challengeId = challengeId
	req.branchId = branchId
	req.strategy = strategy
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeOneKeyPassBranchRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChallengeAgent:sendPM_ChallengeRestartBranchReq(challengeId, branchId, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeRestartBranchReq()

	req.challengeId = challengeId
	req.branchId = branchId
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeRestartBranchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ChallengeRestartBranch, msg)
	end
end

function ChallengeAgent:sendPM_ChallengeOneKeyPassPhaseReq(challengeId, strategy, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeOneKeyPassPhaseReq()

	req.challengeId = challengeId
	req.strategy = strategy
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeOneKeyPassPhaseRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChallengeAgent:sendPM_ChallengeRestartPhaseReq(challengeId, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeRestartPhaseReq()

	req.challengeId = challengeId
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeRestartPhaseRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ChallengeRestartPhase, msg)
	end
end

function ChallengeAgent:sendPM_ChallengeOneKeyFinishReq(challengeId, strategy, reqExtParams)
	local req = ChallengeExtension_pb.PM_ChallengeOneKeyFinishReq()

	req.challengeId = challengeId
	req.strategy = strategy
	req.reqExtParams = reqExtParams

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeOneKeyFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

ChallengeAgent.prizeGotFunc = nil

function ChallengeAgent:sendPM_ChallengeGainPrizeReq(challengeId, changeSetId, packPetId, reqExtParams, func)
	local req = ChallengeExtension_pb.PM_ChallengeGainPrizeReq()

	req.challengeId = challengeId
	req.packPetId = packPetId
	req.reqExtParams = reqExtParams
	ChallengeAgent.prizeGotFunc = func

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeGainPrizeRes(status, msg)
	if status == 0 then
		ChallengeModel.instance:setPrizeGot()
		ChallengeController.instance:localNotify("PrizeGot")

		if ChallengeAgent.prizeGotFunc then
			ChallengeAgent.prizeGotFunc()

			ChallengeAgent.prizeGotFunc = nil
		end
	end
end

function ChallengeAgent:sendPM_ChallengeBatchGetSimpleInfosReq(challengeId)
	local req = ChallengeExtension_pb.PM_ChallengeBatchGetSimpleInfosReq()

	for i, v in ipairs(challengeId) do
		table.insert(req.challengeId, v)
	end

	self:sendMsg(req)
end

function ChallengeAgent:handlePM_ChallengeBatchGetSimpleInfosRes(status, msg)
	if status == 0 then
		local simpleinfo = msg.simpleInfo

		ChallengeModel.instance:setChallengeSimpleInfos(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ChallengeBatchInfos, simpleinfo)
	end
end

ChallengeAgent.instance = ChallengeAgent.New()

return ChallengeAgent
