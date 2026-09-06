-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/agent/SpringRedPackAgent.lua

module("logic.extensions.springredpack.agent.SpringRedPackAgent", package.seeall)

local SpringRedPackAgent = class("SpringRedPackAgent", BaseAgent)

function SpringRedPackAgent:sendPM_GetRedPackInfoReq(activityId, round)
	local req = SpringRedPackExtension_pb.PM_GetRedPackInfoReq()

	req.activityId = activityId

	if round then
		req.round = round
	end

	self:sendMsg(req)
end

function SpringRedPackAgent:handlePM_GetRedPackInfoRes(status, msg)
	if status == 0 then
		SpringRedPackModel.instance:onGetRedPackInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetRedPackInfoRes)
	end
end

function SpringRedPackAgent:sendPM_GainSpringRedPackReq(activityId, round, simlateOtherResults, index)
	local req = SpringRedPackExtension_pb.PM_GainSpringRedPackReq()

	req.activityId = activityId
	req.round = round
	req.simlateOtherResults = simlateOtherResults

	self:sendMsg(req)

	self._round = round
	self._index = index
	self._simlateOtherResults = simlateOtherResults
end

function SpringRedPackAgent:handlePM_GainSpringRedPackRes(status, msg)
	if status == 0 then
		SpringRedPackModel.instance:onGainSpringRedPackRes(msg)

		if self._simlateOtherResults and self._round then
			if self._round > 0 then
				SpringRedPackModel.instance:setHasGainThisRound(true)
			elseif self._round == -1 then
				SpringRedPackModel.instance:setHasGainDailyPrize(true)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.GainSpringRedPackRes, self._round, self._index, msg.redPackPrizeId, msg.otherPrizeIds)

		self._round = nil
		self._index = nil
		self._simlateOtherResults = nil
	else
		GlobalDispatcher:dispatch(GlobalNotify.FailGainSpringRedPackRes)
	end
end

function SpringRedPackAgent:sendPM_GetRedPackLogsReq(activityId)
	local req = SpringRedPackExtension_pb.PM_GetRedPackLogsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SpringRedPackAgent:handlePM_GetRedPackLogsRes(status, msg)
	if status == 0 then
		SpringRedPackModel.instance:onGetRedPackLogsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetRedPackLogsRes)
	end
end

SpringRedPackAgent.instance = SpringRedPackAgent.New()

return SpringRedPackAgent
