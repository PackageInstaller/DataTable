-- chunkname: @modules/logic/versionactivity3_6/yami/rpc/V3a6YaMiRpc.lua

module("modules.logic.versionactivity3_6.yami.rpc.V3a6YaMiRpc", package.seeall)

local V3a6YaMiRpc = class("V3a6YaMiRpc", BaseRpc)

function V3a6YaMiRpc:sendGetAct231InfoRequest(callback, callbackObj)
	local req = Activity231Module_pb.GetAct231InfoRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveGetAct231InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:refreshInfo(msg.researchInstitute)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onInitInfo)
end

function V3a6YaMiRpc:sendAct231BuyResearcherRequest(researcherId, callback, callbackObj)
	local req = Activity231Module_pb.Act231BuyResearcherRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()
	req.researcherId = researcherId

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231BuyResearcherReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:unlockHero(msg.researcher)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onUnlockHero, msg.researcher.id)
	V3a6YaMiModel.instance:refreshMoney(msg.money)
end

function V3a6YaMiRpc:sendAct231UnlockSeatRequest(seatId, callback, callbackObj)
	local req = Activity231Module_pb.Act231UnlockSeatRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()
	req.seatId = seatId

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231UnlockSeatReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:refreshUnlockSeat(msg.seatId, true)
	V3a6YaMiModel.instance:refreshMoney(msg.money)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onUnlockSeat, msg.seatId)
end

function V3a6YaMiRpc:sendAct231StartResearchRequest(callback, callbackObj)
	local req = Activity231Module_pb.Act231StartResearchRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()

	local subType, materials = V3a6YaMiModel.instance:getSelectMaterials()

	req.materialIds:append(subType)

	if materials then
		for _, id in pairs(materials) do
			req.materialIds:append(id)
		end
	end

	local list = V3a6YaMiModel.instance:getSelectHeros()

	if list then
		for _, id in pairs(list) do
			req.researcherId:append(id)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231StartResearchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:refreshResearchInfo(msg.researchInfo)
end

function V3a6YaMiRpc:sendAct231FinishResearchRequest(callback, callbackObj)
	local req = Activity231Module_pb.Act231FinishResearchRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()

	V3a6YaMiModel.instance:clearAddMissionCurrency()
	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231FinishResearchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:setResearchResult(msg)
	V3a6YaMiModel.instance:clearSelectInfo()
	V3a6YaMiModel.instance:refreshMoney(msg.researchInstitute.money)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onFinishPerform)
end

function V3a6YaMiRpc:sendAct231PauseResearchRequest(pauseSecond, callback, callbackObj)
	local req = Activity231Module_pb.Act231PauseResearchRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()
	req.pauseSecond = pauseSecond

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231PauseResearchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:setResearchStatus(V3a6YaMiEnum.ResearchStatus.Pause)
end

function V3a6YaMiRpc:sendAct231ContinueResearchRequest(callback, callbackObj)
	local req = Activity231Module_pb.Act231ContinueResearchRequest()

	req.activityId = V3a6YaMiModel.instance:getActId()

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231ContinueResearchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:setResearchStatus(V3a6YaMiEnum.ResearchStatus.Research)
	V3a6YaMiModel.instance:setPerformPauseSecond(msg.lastPauseSecond)
end

function V3a6YaMiRpc:sendAct231RecordPlaySecondRequest(playSecond, callback, callbackObj)
	local req = Activity231Module_pb.Act231RecordPlaySecondRequest()
	local activityId = V3a6YaMiModel.instance:getActId()

	V3a6YaMiModel.instance:clearMissionCurrency()

	req.activityId = activityId
	req.playSecond = playSecond

	self:sendMsg(req, callback, callbackObj)
end

function V3a6YaMiRpc:onReceiveAct231RecordPlaySecondReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function V3a6YaMiRpc:onReceiveAct231MissionPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a6YaMiModel.instance:updateMission(msg.updateMissions)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onRefreshMission)
end

V3a6YaMiRpc.instance = V3a6YaMiRpc.New()

return V3a6YaMiRpc
