-- chunkname: @modules/logic/dungeon/rpc/HeroStoryRpc.lua

module("modules.logic.dungeon.rpc.HeroStoryRpc", package.seeall)

local HeroStoryRpc = class("HeroStoryRpc", BaseRpc)

function HeroStoryRpc:sendGetHeroStoryRequest(callback, callbackObj)
	local req = HeroStoryModule_pb.GetHeroStoryRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveGetHeroStoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function HeroStoryRpc:sendUnlocHeroStoryRequest(storyId, callback, callbackObj)
	local req = HeroStoryModule_pb.UnlocHeroStoryRequest()

	req.storyId = storyId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveUnlocHeroStoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onUnlocHeroStoryReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UnlockStory, msg.info.storyId)
end

function HeroStoryRpc:sendGetHeroStoryBonusRequest(storyId, callback, callbackObj)
	local req = HeroStoryModule_pb.GetHeroStoryBonusRequest()

	req.storyId = storyId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveGetHeroStoryBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryBonusReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function HeroStoryRpc:onReceiveHeroStoryUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryUpdatePush(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function HeroStoryRpc:sendUpdateHeroStoryStatusRequest(storyId, callback, callbackObj)
	local req = HeroStoryModule_pb.UpdateHeroStoryStatusRequest()

	req.storyId = storyId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveUpdateHeroStoryStatusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onUpdateHeroStoryStatusReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryNewChange)
end

function HeroStoryRpc:sendExchangeTicketRequest(callback, callbackObj)
	local req = HeroStoryModule_pb.ExchangeTicketRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveExchangeTicketReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onExchangeTicketReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ExchangeTick)
end

function HeroStoryRpc:sendGetScoreBonusRequest(list, callback, callbackObj)
	local req = HeroStoryModule_pb.GetScoreBonusRequest()

	for i, v in ipairs(list) do
		table.insert(req.bonusId, v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveGetScoreBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetScoreBonusReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetScoreBonus)
end

function HeroStoryRpc:onReceiveHeroStoryScorePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryScorePush(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ScoreUpdate)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		1116
	})
end

function HeroStoryRpc:sendGetChallengeBonusRequest(callback, callbackObj)
	local req = HeroStoryModule_pb.GetChallengeBonusRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveGetChallengeBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetChallengeBonusReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetChallengeBonus)
end

function HeroStoryRpc:onReceiveHeroStoryTicketPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryTicketPush(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.PowerChange)
end

function HeroStoryRpc:onReceiveHeroStoryWeekTaskPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskPush(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function HeroStoryRpc:sendHeroStoryWeekTaskGetRequest(callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryWeekTaskGetRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryWeekTaskGetReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskGetReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function HeroStoryRpc:sendHeroStoryDispatchRequest(storyId, dispatchId, heroIds, callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryDispatchRequest()

	req.storyId = storyId
	req.dispatchId = dispatchId

	for i, v in ipairs(heroIds) do
		table.insert(req.heroIds, v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryDispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local serverTimeStamp = tonumber(msg.startTime)
	local serverTimeStampSecond = math.floor(serverTimeStamp / 1000)

	ServerTime.update(serverTimeStampSecond)
	RoleStoryModel.instance:onHeroStoryDispatchReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchSuccess)
end

function HeroStoryRpc:sendHeroStoryDispatchResetRequest(storyId, dispatchId, callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryDispatchResetRequest()

	req.storyId = storyId
	req.dispatchId = dispatchId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryDispatchResetReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchReset)
	RoleStoryModel.instance:onHeroStoryDispatchResetReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchReset)
end

function HeroStoryRpc:sendHeroStoryDispatchCompleteRequest(storyId, dispatchId, callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryDispatchCompleteRequest()

	req.storyId = storyId
	req.dispatchId = dispatchId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryDispatchCompleteReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryDispatchCompleteReply(msg)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchFinish)
	self:sendGetHeroStoryRequest()
end

function HeroStoryRpc:sendHeroStoryPlotFinishRequest(plot, callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryPlotFinishRequest()

	req.plot = plot

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryPlotFinishReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function HeroStoryRpc:sendHeroStoryCommonTaskRequest(id, num, callback, callbackObj)
	local req = HeroStoryModule_pb.HeroStoryCommonTaskRequest()

	req.id = id
	req.num = num

	return self:sendMsg(req, callback, callbackObj)
end

function HeroStoryRpc:onReceiveHeroStoryCommonTaskReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

HeroStoryRpc.instance = HeroStoryRpc.New()

return HeroStoryRpc
